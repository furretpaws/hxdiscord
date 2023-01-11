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
    var receivedHelloOC:Bool = false;

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

            var json = haxe.Json.parse(Endpoints.getEndpointData(token, Endpoints.url, Endpoints.version, Endpoints.getGatewayBot));
            var url = Gateway.GATEWAY_URL = json.url + "/?v=10&encoding=json";

            ws = new WebSocketConnection(url);
            ws.onMessage = this.wsm;
            ws.onClose = this.connect;
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
                ws.send(Gateway.preparePackage("heartbeat_package"));
            }
            var idPayload = {
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
            }
            ws.sendJson(idPayload);
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
                if (!readySent)
                {
                    onReady();
                    readySent = true;
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
        }
    }

    /**
        Register slash commands.
        @param j JSON data (See Discord API documentation if you need help)
    **/

    public function setInteractionCommands(j:Dynamic)
    {
        Endpoints.bulkOverwriteGlobalApplicationCommands(j);
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
}
