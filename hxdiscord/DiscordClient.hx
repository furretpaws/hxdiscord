package hxdiscord;

import hxdiscord.gateway.Gateway;
import hxdiscord.gateway.OpCode;
import hxdiscord.endpoints.Endpoints;
import haxe.io.Bytes;
import hxdiscord.types.*;
import haxe.ws.Log;
import hxdiscord.types.structTypes.*;
import hxdiscord.cache.CachedData;
import hxdiscord.utils.Https;
import haxe.ws.Types.MessageType;
import haxe.ws.WebSocket;

using StringTools;

class DiscordClient {
    public static var token:String = "";
    public static var debug:Bool;
    var ws:WebSocket;
    var hb_timer:haxe.Timer;
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
    private var last_heartbeat:Date;
    private var interval:Int;
    public var editThis:String = "";
    private var heartbeat_interval:Int = 0;

    public var cache:CachedData;

    public var data:BotData = null;
    private var alive:Bool = false;

    public var readySent:Bool = false;
    @:dox(hide)
    public var verified:Bool = false;
    public var username:String = "";
    @:dox(hide)
    public var mfa_enabled = false;
    public var user:User = null;
    var ticked:Bool = false;
    public static var accountId:String = "";
    public var accId:String = accountId;
    @:dox(hide)
    public var flags:Int = 0;
    @:dox(hide)
    public var email:Dynamic;
    public var resume_gateway_url:String = "wss://gateway.discord.gg/?v="+Gateway.API_VERSION+"&encoding=json";
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
    function sendHeartbeat() {
        ws.send(haxe.Json.stringify({op: 1, d: null}));
        last_heartbeat = Date.now();
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
    public function new(_token:String, intents:Array<Int>, ?_debug:Bool) {
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
                this.intentsNumber |= intent;
            }
        }

        cache = new CachedData(this);

        /*haxe.EntryPoint.addThread(createWebsocket);
        haxe.EntryPoint.addThread(() -> {
            while(true) {
                if (alive) {
                    var diff = Date.now().getTime() - last_heartbeat.getTime();
                    if (diff >= interval) {
                        sendHeartbeat();
                    }
                }
            }
        });*/
    }

    function tick(){}

    public function connect() {
        ws = new WebSocket(resume_gateway_url);
        ws.onmessage = (daType:MessageType) -> {
            switch (daType) {
                case StrMessage(content):
                    haxe.EntryPoint.runInMainThread(incomingMessages.bind(content));
                case BytesMessage(content):
                    //d
            }
        }
        ws.onclose = () -> {
            hb_timer.stop();
            connect();
        }
        #if sys
        if (!ticked) {
            haxe.MainLoop.add(tick);
            ticked = true;
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

    function incomingMessages(msg:String){
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
            var s = json.s;
            var d:Dynamic = json.d;
            switch (json.op)
            {
                case 10:
                    //trace("got op 10");
                    interval = d.heartbeat_interval;
                    if (canResume) {
                        ws.send(haxe.Json.stringify({op:1, d: null})); 
                        ws.send(haxe.Json.stringify({
                            op: 6,
                            d: {
                                token: token,
                                session_id: session_id,
                                seq: sequence
                            }
                        }));
                        hb_timer = new haxe.Timer(interval);
                        hb_timer.run = () -> {
                            ws.send(haxe.Json.stringify({op:1, d: null})); 
                        }
                    } else {
                        ws.send(haxe.Json.stringify({op:1, d: null})); 
                        haxe.EntryPoint.runInMainThread(()->{
                            hb_timer = new haxe.Timer(interval);
                            hb_timer.run = () -> {
                                ws.send(haxe.Json.stringify({op:1, d: null})); 
                            }
                        });
                        ws.send(haxe.Json.stringify({
                            "op": 2,
                            "d": {
                                    "token": token,
                                    "properties": {
                                        "os": "hxdiscord",
                                        "browser": "hxdiscord",
                                        "device": "hxdiscord"
                                },
                                // This intent represents 1 << 0 for GUILDS, 1 << 1 for GUILD_MEMBERS, and 1 << 2 for GUILD_BANS
                                // This connection will only receive the events defined in those three intents
                                "intents": 3276799
                            }
                        }));
                    }
                case 9:
                    canResume = false;
                    ws.close();
                case 0:
                    sequence = s;
                case 7: //gateway needs client to reconnect
                    ws.close();
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
                    onReady();
                    try {
                        accId = d.application.id;
                    } catch (e) {
                        if (debug) {
                            trace(e.message);
                        }
                    }
                    last_heartbeat = Date.now();
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
                case 'GUILD_ROLE_CREATE':
                    cache.guilds_roles.set(d.role.id, d);
                case 'GUILD_ROLE_DELETE':
                    if (cache.guilds_roles.exists(d.role_id)) {
                        cache.guilds_roles.set(d.role_id, d);
                    }
                case 'GUILD_ROLE_UPDATE':
                    cache.guilds_roles.set(d.role.id, d);
                case 'GUILD_CREATE':
                    if (!cache.guilds.exists(d.id)) {
                        cache.guilds.set(d.id, d);
                    }
                    for (i in 0...d.roles.length) {
                        cache.guilds_roles.set(d.roles[i].id, d.roles[i]);
                    }
                    onGuildCreate(d);
                case 'GUILD_UPDATE':
                    onGuildUpdate(d);
                    cache.guilds.set(d.id, d);
                case 'GUILD_DELETE':
                    cache.guilds.remove(d.id);
                    onGuildDelete(d);
                case "GUILD_BAN_ADD":
                    onGuildBanAdd(d);
                case "GUILD_BAN_REMOVE":
                    onGuildBanRemove(d);
                case 'GUILD_AUDIT_LOG_ENTRY_CREATE':
                    onGuildAuditLogEntryCreate(d);
                case 'GUILD_MEMBER_ADD':
                    onGuildMemberAdd(d);
                    var member:Member = new Member(d, d.guild_id);
                    cache.guild_members.set(d.guild_id+d.user.id,member);
                case "GUILD_MEMBER_REMOVE":
                    onGuildMemberRemove(d);
                    //UNcaching shit haha
                    //actually i'm doing this because i found out this was crashing the thing so yeah
                    //this is actually needed
                    /*try {
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
                    }*/
                    if (cache.guild_members.exists(d.guild_id+d.user.id)) {
                        cache.guild_members.remove(d.guild_id+d.user.id);
                    }
                case "GUILD_MEMBER_UPDATE":
                    onGuildMemberUpdate(d);
                    var member:Member = new Member(d, d.guild_id);
                    for (x in 0...member.roles.length) {
                        member.permissionsBitwise.push(cache.guilds_roles.get(member.roles[x]).permissions);
                        //trace(cache.guilds_roles.get(d.members[i].roles[x]));
                    }
                    cache.guild_members.set(member.guild_id+member.user.id, member);
                    /*var dataRoles:Dynamic = Endpoints.getRoles(d.guild_id);
                    //caching
                    for (i in 0...d.roles.length)
                    {
                        var permissionBitwise:Array<Dynamic> = [];
                        for (x in 0...dataRoles.length)
                        {
                            if (d.roles[i] == dataRoles[x].id)
                            {
                                permissionBitwise.push(dataRoles[x].permissions);
                            }
                        }
                        Reflect.setProperty(d, "permissionBitwise", permissionBitwise);
                    }
                    cache.guild_members.set([d.guild_id,d.user.id],d);*/
                    /*var member:Member = null;
                    var gid:String = Std.string(d.guild_id);
                    var user_id:String = Std.string(d.user.id);
                    hxdiscord.endpoints.Endpoints.getGuildMember(gid, user_id, (m) -> {member = m;}, (e) -> trace(e));
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
                    }*/
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
                case "PRESENCE_UPDATE":
                    cache.presences.set(d.user.id, d);
            }
        #if (!hl)
        } catch (err) {
        }
        #end
    }

    //FOR TESTING PURPOSES

    /**
        Causes a resume. This is for testing purposes and it has no logical sense to use this
    **/
    public function causeResume() {
        trace("Causing resume at " + Date.now());
        this.incomingMessages('{"op": 7, "d": null}');
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

        ws.send(haxe.Json.stringify(data));
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

        ws.send(haxe.Json.stringify(data));
    }

    public function createVoiceConnection(guild_id:String, channel_id, ?self_mute:Bool = false, ?self_deaf:Bool = false):VoiceClient {
        var client = new VoiceClient(guild_id, channel_id, this.user.id);
        currentVoiceClients.push(client);
        var data = {
            op: 4,
            d: {
                guild_id: guild_id,
                channel_id: channel_id,
                self_mute: false,
                self_deaf: false
            }
        }
        ws.send(haxe.Json.stringify(data));
        return client;
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