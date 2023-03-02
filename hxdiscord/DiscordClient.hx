package hxdiscord;

import hxdiscord.gateway.Gateway;
import hxdiscord.gateway.OpCode;
import hxdiscord.endpoints.Endpoints;
import hxdiscord.net.WebSocketConnection;
import hxdiscord.types.*;
import hxdiscord.types.structTypes.*;
import hxdiscord.utils.Https;
import haxe.Timer;

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
    private var sequence:String = "";
    private var session:String = "";
    private var session_type:String = "";
    private var session_id:String = "";
    private var resume_gateway_url:String = "";

    public var readySent:Bool = false;
    @:dox(hide)
    public var verified:Bool = false;
    public var username:String = "";
    @:dox(hide)
    public var mfa_enabled = false;
    public static var accountId:String = "";
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
    @:dox(hide)
    public var afk:Bool = false;

    public var intentsNumber:Int = 0;

    /**
        Constructor. This will start a new hxdiscord instance.
        @param _token You're token (I'm not sure if user tokens work.)
        @param intents Array of intents.
        @param _debug Debug mode. This will print every single websocket incomming message from the Discord Gateway.
    **/

    public function new (_token:String, intents:Array<Int>, ?_debug:Bool)
    {
        token = _token;
        debug = _debug;

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
    }

    @:dox(hide)
    public function tick() {}

    @:dox(hide)
    function connect()
    {
        try {
            if (debug)
                trace("Connecting");

            var url = Gateway.GATEWAY_URL;

            ws = new WebSocketConnection(url);
            ws.onMessage = this.wsm;
            ws.onClose = (m:Int) -> {
                if (heartbeatTimer != null)
                {
                    heartbeatTimer.stop();
                }
            
                if (m == 4006 || m == 1000 || m == 1001) //session is invalid so i cannot resume
                {
                    session_id = "";
                    session = "";
                    session_type = "";
                    canResume = false;

                    Gateway.GATEWAY_URL = "wss://gateway.discord.gg/?v="+Gateway.API_VERSION+"&encoding=json";
                }
            
                if (debug) {
                    trace("[!] The socket has closed with code: " + m + ". Re-opening...");
                }
                connect();
            };
            ws.onError = (e) -> {
                throw("Websocket gave an error.");
            }
        } catch (err) {
            throw(err);
        }
    }

    @:dox(hide)
    function wsm(msg){
        if (debug)
        {
            trace(msg);
        }
        var json:Dynamic = haxe.Json.parse(msg);
        var t = json.t;
        var event = json.event;
        var op = json.op;
        var d:Dynamic = json.d;
        if (json.s != null)
        {
            sequence = json.s;
        }
        switch (json.op)
        {
            case 10:
            if (debug)
            {
                trace("hello op code");
            }
            heartbeatTimer = new Timer(json.d.heartbeat_interval);
            heartbeatTimer.run = function()
            {
                ws.send(haxe.Json.stringify({
                    op: 1,
                    d: sequence
                }));
            }
            var payload:Dynamic = null;
            if (canResume) {
                payload = {
                    "op": 6,
                    "d" : {
                        "token": token,
                        "session_id": session_id,
                        "seq": Std.parseInt(sequence)
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
            ws.sendJson(payload);
            //alright, i fixed this
            if (presenceType == 99)
            {
                //do nothing
            }
            else
            {
                var numericType = presenceType;
                var data = {
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
                ws.sendJson(data);
            }
            case 9:
                ws.close();
            case 7: //gateway needs client to reconnect
                ws.close();
        }

        switch (t) {
            case 'READY':
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
                Gateway.GATEWAY_URL = d.resume_gateway_url + "?v=" + Gateway.API_VERSION;
                if (!readySent)
                {
                    onReady();
                    readySent = true;
                }
                canResume = true;
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
                onGuildCreate(d);
            case 'GUILD_UPDATE':
                onGuildUpdate(d);
            case 'GUILD_DELETE':
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
            case "GUILD_MEMBER_UPDATE":
                onGuildMemberUpdate(d);
        }
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

    public function causeResume() {
        this.wsm('{
            "op": 7,
            "d": null
          }');
    }

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