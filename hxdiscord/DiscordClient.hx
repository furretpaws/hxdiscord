package hxdiscord;

import hxdiscord.gateway.Gateway;
import hxdiscord.gateway.OpCode;
import hxdiscord.endpoints.Endpoints;
import hxdiscord.net.WebSocketConnection;
import hxdiscord.types.*;
import hxdiscord.types.structTypes.*;
import hxdiscord.cache.CachedData;
import hxdiscord.utils.Https;
import haxe.Timer;

using StringTools;

/**
    This is the so-called "heart" of the application you're building. This will be used to handle events from Discord.
**/

class DiscordClient
{
    public static var token:String = "";
    public static var debug:Bool;
    var ws:WebSocketConnection;
    var heartbeatTimer:Timer;
    public var status:String = "online";
    private var canResume:Bool = false;
    var receivedHelloOC:Bool = false;
    private var ignore:Bool = false;
    private var sequence:Int = 0;
    var showWsLogsVar:Bool = false;
    private var connectedVoiceClients:Array<VoiceClient> = [];
    private var session:String = "";
    private var session_type:String = "";
    private var session_id:String = "";
    private var heartbeat_interval:Int = 0;
    private var resume_gateway_url:String = "";

    public var cache:CachedData;

    public var data:BotData = null;

    public var readySent:Bool = false;
    @:dox(hide)
    public var verified:Bool = false;
    public var username:String = "";
    @:dox(hide)
    public var mfa_enabled = false;
    public var user:User = null;
    public static var accountId:String = "";
    public var accId:String = accountId;
    @:dox(hide)
    public var flags:Int = 0;
    @:dox(hide)
    public var email:Dynamic;
    public var discriminator:String = "";
    @:dox(hide)
    public var bot:Bool = false;
    @:dox(hide)
    public var avatar:Dynamic;

    public var presence:String = "";
    public var presenceType:Int = 99;
    public var presenceArray:Array<Dynamic> = []; //current presences
    @:dox(hide)
    public var afk:Bool = false;
    public static var authHeader:String = "";

    @:dox(hide)
    public var currentVoiceClients:Array<VoiceClient> = [];

    public var intentsNumber:Int = 0;
    public var noConnection:Bool = false;

    /**
        Constructor. This will start a new hxdiscord instance.
        @param _token Your token (I'm not sure if user tokens work.)
        @param intents Array of intents.
        @param _debug Debug mode. This will print every single websocket incoming message from the Discord Gateway.
    **/

    public function new (_token:String, intents:Array<Int>, ?_debug:Bool)
    {
        token = _token;
        debug = _debug;
        data = new BotData();

        if (intents == null || intents == [])
        {
            throw("The Discord client requires valid intents");
        }
        else
        {
            for (intent in intents) {
                intentsNumber |= intent;
            }
        }

        connect();

        #if (js&&nodejs)
        haxe.MainLoop.add(tick);
        #end

        cache = new CachedData(this);
    }

    @:dox(hide)
    public function tick() {
        
    }

    public function showWsLogs() {
        if (showWsLogsVar) {
            Sys.println("[hxdiscord] WebSocket logs are already shown! To hide them, use hideWsLogs()");
        } else {
            showWsLogsVar = true;
            Sys.println("[hxdiscord] WebSocket logs will be shown now!");
        }
    }

    public function hideWsLogs() {
        if (!showWsLogsVar) {
            Sys.println("[hxdiscord] WebSocket logs are already hidden! To hide them, use hideWsLogs()");
        } else {
            showWsLogsVar = false;
            Sys.println("[hxdiscord] WebSocket logs will be hidden now!");
        }
    }

    @:dox(hide)
    function connect()
    {
        if (noConnection) {
            Sys.println("[i] - Waiting 30 seconds for the connection to come back...");
            var wait = new Timer(30000);
            wait.run = function()
            {
                noConnection = false;
                wait.stop();
                connect();
            }
        }
        try {
            if (!noConnection) {
                if (debug)
                    trace("Connecting");
    
                var url = Gateway.GATEWAY_URL;
    
                ws = new WebSocketConnection(url);
                ws.onReady = () -> {
                    if (showWsLogsVar) {
                        Sys.println("[ws-hxdiscord] The WebSocket connection is ready!");
                    }
                }
                ws.onMessage = this.wsm;
                ws.onClose = (m:Dynamic) -> {
                    if (showWsLogsVar) {
                        Sys.println("[ws-hxdiscord] The WebSocket connection has been closed. Code: " + m);
                    }
                    if (heartbeatTimer != null)
                    {
                        heartbeatTimer.stop();
                    }
                    heartbeatTimer = null;

                    @:privateAccess
                    for (i in 0...haxe.EntryPoint.pending.length) {
                        @:privateAccess
                        haxe.EntryPoint.pending.remove(haxe.EntryPoint.pending[i]);
                    }

                    ws.destroy();
                    ws = null;
                
                    if (m == 4007) //session is invalid so i cannot resume
                    {
                        session_id = "";
                        session = "";
                        session_type = "";
                        canResume = false;
    
                        Gateway.GATEWAY_URL = "wss://gateway.discord.gg/?v="+Gateway.API_VERSION+"&encoding=json";
                    }
                
                    if (Std.is(m, String)) {
                        var error:String = m.toLowerCase();
                        if (error.contains("intent")) {
                            throw "\r\n\n[!] The connection has closed due to the error \"" + m + "\". There's an issue with your intents.\nFor further information you can look at this Discord Developer pages\nhttps://discord.com/developers/docs/change-log#message-content-is-a-privileged-intent\nhttps://discord.com/developers/docs/topics/gateway-events#gateway-events";
                        } else if (error.contains("invalid")) {
                            throw "\r\n\n[!] The connection has closed due to the error \"" + m + "\". There's an issue with something you've sent to the Discord API. Please check the Discord Developer Portal documentation for more information";
                        } else if (error.contains("sharding")) {
                            throw "\r\n\n[!] The connection has closed due to the error \"" + m + "\". There's an issue with shards. If it says that shards are required then it's because the session would have handled too many guilds, you are required to shard your connection in order to connect.";
                        } else {
                            if (debug)
                                trace("[!] The socket has closed with the error \"" + m + "\". Re-opening...");
                        }
                    } else {
                        switch (m) {
                            case 4013:
                                throw "\r\n\n[!] You sent an invalid intent for a Gateway Intent. You may have incorrectly calculated the bitwise value.";
                            case 4014:
                                throw "\r\n\n[!] You sent a disallowed intent for a Gateway Intent. You may have tried to specify an intent that you have not enabled or are not approved for.";
                            case 4004:
                                throw "\r\n\n[!] The account token sent with your identify payload is incorrect.";
                            case 4012:
                                throw "\r\n\n[!] You sent an invalid version for the gateway.";
                            case 4011:
                                throw "\r\n\n[!] The session would have handled too many guilds - you are required to shard your connection in order to connect.";
                            case 4010:
                                throw "\r\n\n[!] You sent us an invalid shard when identifying.";
                            default: 
                                if (debug) {
                                    trace("[!] The socket has closed with code: " + m + ". Re-opening...");
                                }
                        }
                    }
                    //destroying since it's not required anymore
                    if (debug)
                        Sys.println('Waiting 2.5 seconds..');
                    var t:Timer = new Timer(2500);
                    t.run = () -> {
                        t.stop();
                        connect();
                    }
                };
                ws.onError = (e) -> {
                    #if neko
                    if (e.contains("ssl@ssl_handshake")) {
                        trace("oh no");
                        noConnection = true;
                    }
                    #end
                    if (showWsLogsVar) {
                        Sys.println("[ws-hxdiscord] The WebSocket has got an error. Error: " + e);
                    }
                    try {
                        if (debug) {
                            trace("Websocket gave an error. (" + e + ")");
                        }
                        ws.close();
                    } catch (err) {
                        Sys.println("[!] Catched an error from the WebSocket, please make a new GitHub issue if this problem persists\nError: " + e);
                    }
                }
                /*ws.requiredReconnect = () -> { //library bug
                    if (showWsLogsVar) {
                        Sys.println("[ws-hxdiscord] The WebSocket is required to close itself and reconnect due to a library issue");
                    }
                    try {
                        ws.close();
                        ws.destroy();
                        ws = null;
                    } catch (err) {
                        if (heartbeatTimer != null)
                        {
                            heartbeatTimer.stop();
                        }
                    }
                }*/
            }
        } catch (err) {
            if (err.message == "ssl@ssl_close") {
                return;
            }
            else {
                throw err;
            }
        }
    }

    function reset() {
        ws.close();
        ws = null;
        if (heartbeatTimer != null) {
            heartbeatTimer.stop();
        }
        heartbeatTimer = null;
    }

    @:dox(hide)
    function wsm(msg){
        if (showWsLogsVar) {
            Sys.println("[ws-hxdiscord] New message!");
        }
        #if (!hl)
        try {
        #end
            if (debug)
            {
                trace(msg);
            }
            var json:Dynamic = haxe.Json.parse(msg);
            var t = json.t;
            var event = json.event;
            var op = json.op;
            var d:Dynamic = json.d;
            switch (json.op)
            {
                case 10:
                if (debug)
                {
                    trace("hello op code");
                }
                heartbeat_interval = json.d.heartbeat_interval;
                heartbeatTimer = new Timer(heartbeat_interval);
                heartbeatTimer.run = function()
                {
                    try {
                        ws.send(haxe.Json.stringify({
                            op: 1,
                            d: sequence
                        }));
                    } catch (err) {
                        reset();
                    }
                }
                var payload:Dynamic = null;
                if (canResume) {
                    payload = {
                        "op": 6,
                        "d" : {
                            "token": token,
                            "session_id": session_id,
                            "seq": sequence
                        }
                    };
                }
                else
                {
                    payload = {
                        op:2,
                        d: {
                            token: token,
                            intents: intentsNumber,
                            properties: {
                                os: 'customOS',
                                browser: 'hxdiscord',
                                device: 'hxdiscord'
                            }
                        }
                    };
                }
                try {
                    ws.sendJson(payload);
                } catch (err) {
                    reset();
                }
                //alright, i fixed this
                case 9:
                    if (debug) {
                        trace("invalid :( " + sequence);
                    }
                    if (canResume) {
                        ws.close();
                        canResume = false;
                    }
                case 7: //gateway needs client to reconnect
                    ws.close();
                case 0:
                    sequence = json.s;
            }
        
            switch (t) {
                case "RESUMED":
                    //nothing happens except the onResumed() function is called :)
                    onResumed();
                case 'READY':
                    user = new hxdiscord.types.User(this, d.user);
                    verified = d.user.verified;
                    avatar = d.user.avatar;
                    mfa_enabled = d.user.mfa_enabled;
                    accountId = d.user.id;
                    email = d.user.email;
                    discriminator = d.user.discriminator;
                    username = d.user.username;
                    flags = d.user.flags;
                    bot = d.user.bot;
                    session_id = d.session_id;
                    session_type = d.session_type;
                    #if (nodejs&&js)
                    Gateway.GATEWAY_URL = d.resume_gateway_url + "?v=" + Gateway.API_VERSION;
                    #end
                    canResume = true;
                    if (!bot) {
                        authHeader = token;
                    }
                    else {
                        authHeader = "Bot " + token;
                    }
                    if (!readySent)
                    {
                        onReady();
                        readySent = true;
                    }
                    try {
                        accId = d.application.id;
                    } catch (e) {
                        if (debug) {
                            trace(e.message);
                        }
                    }
                case 'INTERACTION_CREATE':
                    onInteractionCreate(nInteraction(d, d, haxe.Json.parse(msg)));
                case 'MESSAGE_CREATE':
                    /*var author = d.author.username;
                    var content = d.content;
                    if (debug)
                    {
                        trace(content);
                        trace(author + ": " + content);
                    }*/
                    onMessageCreate(nMessage(d, d));
                case 'THREAD_MEMBER_UPDATE':
                    onThreadMemberUpdate(d);
                case 'THREAD_MEMBERS_UPDATE':
                    onThreadMembersUpdate(d);
                case 'GUILD_CREATE':
                    var alreadyHasTheGuild:Bool = false;
                    for (i in 0...cache.guilds.length) {
                        if (cache.guilds[0].id == d.id) {
                            alreadyHasTheGuild = true;
                        }
                    }
                    if (!alreadyHasTheGuild) {
                        cache.guilds.push(d);
                    }
                    onGuildCreate(d);
                case 'GUILD_UPDATE':
                    onGuildUpdate(d);
                case 'GUILD_DELETE':
                    for (i in 0...cache.guilds.length) {
                        if (cache.guilds[0].id == d.id) {
                            cache.guilds.remove(cache.guilds[i]);
                            trace("removed guild");
                        }
                    }
                    onGuildDelete(d);
                case "GUILD_BAN_ADD":
                    onGuildBanAdd(d);
                case "GUILD_BAN_REMOVE":
                    onGuildBanRemove(d);
                case 'GUILD_AUDIT_LOG_ENTRY_CREATE':
                    onGuildAuditLogEntryCreate(d);
                case 'GUILD_MEMBER_ADD':
                    onGuildMemberAdd(d);
                case "GUILD_MEMBER_REMOVE":
                    onGuildMemberRemove(d);
                    //UNcaching shit haha
                    //actually i'm doing this because i found out this was crashing the thing so yeah
                    //this is actually needed
                    try {
                        for (i in 0...cache.guild_members.length) {
                            if (cache.guild_members[i].guild_id == d.guild_id) {
                                if (cache.guild_members[i].user.id == d.user.id) {
                                    cache.guild_members.remove(cache.guild_members[i]);
                                    if (d.user.id == user.id)
                                        for (i in 0...cache.roles.length) {
                                            if (cache.roles[i][0] == d.guild_id) {
                                                cache.roles.remove(cache.roles[i]);
                                            }
                                        }
                                }
                            }
                        }
                    } catch (err) {
                        trace("oopsie " + err.message);
                    }
                case "GUILD_MEMBER_UPDATE":
                    onGuildMemberUpdate(d);
                    //caching shit
                    var member:Member = null;
                    hxdiscord.endpoints.Endpoints.getGuildMember(d.guild_id, d.user.id, (m) -> {member = m;}, null);
                    var foundRoles:Bool = false;
                    var dataRoles:Dynamic = null;
                    if (cache.roles.length == 0) {
                        var r:Dynamic = Endpoints.getRoles(d.guild_id);
                        cache.roles.push([d.guild_id, r]);
                        dataRoles = r;
                        foundRoles = true;
                    } else {
                        for (i in 0...cache.roles.length) {
                            if (cache.roles[i][0] == d.guild_id) {
                                dataRoles = cache.roles[i][1];
                                foundRoles = true;
                            }
                        }
                    }
                    if (!foundRoles) {
                        dataRoles = Endpoints.getRoles(d.guild_id);
                    }
        
                    dataRoles = haxe.Json.parse(dataRoles);
        
                    for (i in 0...member.roles.length)
                    {
                        for (x in 0...dataRoles.length)
                        {
                            if (member.roles[i] == dataRoles[x].id)
                            {
                                member.permissionsBitwise.push(dataRoles[x].permissions);
                            }
                        }
                    }
                    if (cache.guild_members.length == 0) {
                        cache.guild_members.push(member);
                    } else {
                        for (i in 0...cache.guild_members.length) {
                            var found:Bool = false;
                            if (cache.guild_members[i].user.id == member.user.id && cache.guild_members[i].guild_id == d.guild_id) {
                                found = true;
                            }
                            if (found) {
                                cache.guild_members.remove(cache.guild_members[i]);
                                cache.guild_members.push(member);
                            } else {
                                cache.guild_members.push(member);
                            }
                        }
                    }
                case "VOICE_SERVER_UPDATE":
                    for (i in 0...currentVoiceClients.length) {
                        @:privateAccess
                        if (currentVoiceClients[i].guild_id == d.guild_id) {
                            currentVoiceClients[i].giveCredentials(d);
                        }
                    }
                case "VOICE_STATE_UPDATE":
                    //deal with functions later
                    for (i in 0...currentVoiceClients.length) {
                        @:privateAccess
                        if (currentVoiceClients[i].guild_id == d.guild_id) {
                            if (d.channel_id != null && d.session_id != null) {
                                @:privateAccess
                                currentVoiceClients[i].session_id = d.session_id;
                            }
                            else
                            {
                                currentVoiceClients.remove(currentVoiceClients[i]); //like, if there's no channel id (which means that the bot disconnected), it removes its instance?
                            }
                        }
                    }
            }
        #if (!hl)
        } catch (err) {
        }
        #end
    }

    /**
        Register slash commands.
        @param j JSON data (See Discord API documentation if you need help)
    **/

    public function setInteractionCommands(j:Dynamic)
    {
        return Endpoints.bulkOverwriteGlobalApplicationCommands(j);
    }

    /**
        Join a voice channel (Won't play any audio for now)
        @param server_id
        @param channel_id
        @param self_mute
        @param self_deaf
    **/

    public function createVoiceConnection(guild_id:String, channel_id:String, ?self_mute:Bool = false, ?self_deaf:Bool = false):VoiceClient {
        var client = new VoiceClient(guild_id, channel_id, this.accId);
        currentVoiceClients.push(client);
        this.ws.sendJson({
            op: 4,
            d: {
                guild_id: guild_id,
                channel_id: channel_id,
                self_mute: self_mute,
                self_deaf: self_deaf
            }
        });
        return client;
    }

    /**
        Get value from an array.
        @param array The array
        @param thingToSearch As the name says, the thing you want to search.
    **/

    public function getValue(array:Array<Dynamic>, thingToSearch:Dynamic)
    {
        if (array.contains(thingToSearch))
            return thingToSearch;
        return null;
    }

    /**
        Request guild members
        @param guild_id The ID of the guild you want to index.
        @param query String that username starts with, or an empty string to return all members
        @param limit Maximum number of members
        @param presences Used to specify if we want the presences of the matched members
        @param user_ids Used to specify which users you wish to fetch. (String or array of strings)
        @param nonce Nonce to identify the Guild Members Chunk response.
    **/

    public function guildRequestMembers(guild_id:String, ?query:String = "", ?limit:Int = 0, ?presences:Bool = null, ?user_ids:haxe.extern.EitherType<Array<String>, String> = null, ?nonce:String = null)
    {
        var data = {
            op: 8,
            d: {
                guild_id: guild_id,
                query: query,
                limit: limit,
                presences: presences,
                user_ids: user_ids,
                nonce: nonce
            }
        }
    }

    /**
        Change the status of the client.
        @param status The status. ("online", "dnd", "idle", "invisible", "offline")
        @param type Type of status ("game", "streaming", "listening", "watching", "custom", "competing")
        @param presence Custom presence. (Example: Playing <your presence>, Watching <your presence>)
        @param afk Whether if the bot is AFK or not.
    **/

    //FOR TESTING PURPOSES

    /**
        Causes a resume. This is for testing purposes and it has no logical sense to use this
    **/
    public function causeResume() {
        trace("Causing resume at " + Date.now());
        this.wsm('{
            "op": 7,
            "d": null
          }');
    }

    /**
        Changes the status from the account
        @param status
        @param type
        @param presence
        @param afk
    **/
    public function changeStatus(status:String, ?type:String, ?presence:String, ?afk:Bool = false)
    {
        var availableStatus:Array<String> = ["online", "dnd", "idle", "invisible", "offline"];
        if (status != "online" && status != "dnd" && status != "idle" && status != "invisible" && status != "offline")
        {
            throw("Invalid status: " + status);
        }
        
        var data = null;
        var numericType:Int = 0;
        if (type != null && type != null)
        {
            switch(type.toLowerCase())
            {
                case "game":
                    numericType = 0;
                case "streaming":
                    numericType = 1;
                case "listening":
                    numericType = 2;
                case "watching":
                    numericType = 3;
                case "custom":
                    numericType = 4;
                case "competing":
                    numericType = 5;
            }

            data = {
                op: 3,
                d: {
                    since: null,
                    activities: [
                        {
                            name: presence,
                            type: numericType
                        }
                    ],
                    status: status,
                    afk: afk
                }
            }
        }

        status = status.toLowerCase();
        this.status = status.toLowerCase();
        this.presence = presence;
        this.presenceType = numericType;
        this.afk = afk;
        presenceArray = [status, type, presence, afk, numericType];

        ws.sendJson(data);
    }

    /**
        Change the presence.
        @param type The presence type ("game", "streaming", "listening", "watching", "custom", "competing")
        @param status The presence status
    **/

    public function changePresence(type:String, status:String)
    {
        if (type != "game" && type != "streaming" && type != "listening" && type != "watching" && type != "custom" && type != "competing")
        {
            throw("Invalid type: " + type + " / The only types that exists are: game, streaming, watching, custom, competing");
        }

        var numericType:Int = 0;

        switch(type.toLowerCase())
        {
            case "game":
                numericType = 0;
            case "streaming":
                numericType = 1;
            case "listening":
                numericType = 2;
            case "watching":
                numericType = 3;
            case "custom":
                numericType = 4;
            case "competing":
                numericType = 5;
        }

        var data = {
            op: 3,
            d: {
                since: null,
                activities: [
                    {
                        name: status,
                        type: numericType
                    }
                ],
                status: null,
                afk: false
            }
        };

        ws.sendJson(data);
    }

    @:dox(hide)
    public function nInteraction(ins:InteractionS, d:Dynamic, pj:Dynamic)
    {
        /*var daUser = new User(this);
        daUser.username = d.interaction.user.username;
        daUser.public_flags = d.interaction.user.public_flags;
        daUser.id = d.interaction.user.id;
        daUser.discriminator = d.interaction.user.discriminator;
        daUser.avatar_decoration = d.interaction.user.discriminator;
        daUser.avatar = d.interaction.user.avatar;*/

        ins.options = d.data.options; //i have to manually adjust it :sob:
        ins.name = d.data.name;
        ins.intId = d.id;
        ins.token = d.token;
        if (DiscordClient.debug)
        {
            trace(d.token);
        }
        var interaction = new Interaction(ins, this, pj);
        return interaction;
    }

    @:dox(hide)
    public function nMessage(ms:MessageS, d:Dynamic) {
        var daUser = new User(this, d);
        daUser.username = d.author.username;
        daUser.public_flags = d.author.public_flags;
        daUser.id = d.author.id;
        daUser.discriminator = d.author.discriminator;
        daUser.avatar_decoration = d.author.discriminator;
        daUser.avatar = d.author.avatar;

        var id = ms.id;
        var message = new Message(ms, this);
        message.author = daUser;
        return message;
    }

    /**
        Event hook for incoming messages
    **/

    dynamic public function onInteractionCreate(i:Interaction)
    {

    }

    /**
        Event hook for the "READY" event
    **/

    dynamic public function onReady()
    {

    }

    /**
        Event hook for the "RESUMED" event
    **/

    dynamic public function onResumed()
    {

    }

    /**
        Event hook for incoming messages
    **/

    dynamic public function onMessageCreate(m:Message)
    {

    }
    
    /**
        Event hook for THREAD_MEMBER_UPDATE
    **/

    dynamic public function onThreadMemberUpdate(d:hxdiscord.types.Typedefs.ThreadMemberUpdate)
    {

    }

    /**
        Event hook for THREAD_MEMBERS_UPDATE
    **/

    dynamic public function onThreadMembersUpdate(d:hxdiscord.types.Typedefs.ThreadMembersUpdate)
    {

    }

    /**
        Event hook for GUILD_CREATE
    **/

    dynamic public function onGuildCreate(d:hxdiscord.types.Typedefs.GuildCreate) {

    }

    /**
        Event hook for GUILD_UPDATE
    **/

    dynamic public function onGuildUpdate(d:hxdiscord.types.structTypes.Guild)
    {

    }

    /**
        Event hook for GUILD_DELETE
    **/

    dynamic public function onGuildDelete(d:hxdiscord.types.structTypes.Guild) {

    }

    /**
        Event hook for GUILD_BAN_ADD
    **/

    dynamic public function onGuildBanAdd(d:hxdiscord.types.Typedefs.GuildBanAddEventFields)
    {

    }

    /**
        Event hook for GUILD_BAN_REMOVE
    **/

    dynamic public function onGuildBanRemove(d:hxdiscord.types.Typedefs.GuildBanRemoveEventFields)
    {

    }

    /**
        Event hook for GUILD_AUDIT_LOG_ENTRY_CREATE
    **/

    dynamic public function onGuildAuditLogEntryCreate(d:hxdiscord.types.Typedefs.AuditLogEntryStructure)
    {

    }

    /**
        Event hook for GUILD_MEMBER_ADD
    **/

    dynamic public function onGuildMemberAdd(d:Dynamic)
    {

    }

    /**
        Event hook for GUILD_MEMBER_REMOVE
    **/

    dynamic public function onGuildMemberRemove(d:hxdiscord.types.Typedefs.GuildBanRemoveEventFields)
    {

    }

    /**
        Event hook for GUILD_MEMBER_UPDATE
    **/

    dynamic public function onGuildMemberUpdate(d:hxdiscord.types.structTypes.GuildMember)
    {
        
    }
}

class BotData {
    public var target:String = "";
    public function new() {
        #if cpp
        target = "cpp";
        #elseif cppia
        target = "cppia";
        #elseif cs
        target = "cs";
        #elseif eval
        target = "eval";
        #elseif hl
        target = "hl";
        #elseif java
        target = "java";
        #elseif js
        target = "js";
        #elseif lua
        target = "lua";
        #elseif neko
        target = "neko";
        #elseif php
        target = "php";
        #elseif python
        target = "python";
        #elseif swf
        target = "swf";
        #end
    }
}