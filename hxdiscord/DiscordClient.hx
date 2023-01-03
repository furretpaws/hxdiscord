package hxdiscord;

import hxdiscord.gateway.Gateway;
import hxdiscord.gateway.OpCode;
import hxdiscord.endpoints.Endpoints;
import hxdiscord.net.WebSocketConnection;
import hxdiscord.types.*;
import hxdiscord.types.structTypes.*;
import hxdiscord.utils.Https;
import haxe.Timer;

class DiscordClient
{
    public static var token:String = "";
    public static var debug:Bool;
    var ws:WebSocketConnection;
    var heartbeatTimer:Timer;
    public static var status:String = "online";
    var receivedHelloOC:Bool = false;

    public var readySent:Bool = false;
    public var verified:Bool = false;
    public var username:String = "";
    public var mfa_enabled = false;
    public static var accountId:String = "";
    public var flags:Int = 0;
    public var email:Dynamic;
    public var discriminator:String = "";
    public var bot:Bool = false;
    public var avatar:Dynamic;

    public function new (_token:String, _debug:Bool = false)
    {
        token = _token;
        debug = _debug;

        connect();
    }

    public function tick() {}

    function connect()
    {
        try {
            if (debug)
                trace("Connecting");

            var json = haxe.Json.parse(Endpoints.getEndpointData(token, Endpoints.url, Endpoints.version, Endpoints.getGatewayBot));
            Gateway.GATEWAY_URL = json.url + "/?v=10&encoding=json";

            var url = Gateway.GATEWAY_URL;

            ws = new WebSocketConnection(url);
            ws.onMessage = this.wsm;
            ws.onClose = this.connect;
        } catch (err) {
            throw(err);
        }
    }

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
                    intents: 131071,
                    properties: {
                        os: 'customOS',
                        browser: 'hxdiscord',
                        device: 'hxdiscord'
                    }
                }
            }
            ws.sendJson(idPayload);
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

    public function setInteractionCommands(j:Dynamic)
    {
        Endpoints.bulkOverwriteGlobalApplicationCommands(j);
    }

    public function getValue(array:Array<Dynamic>, thingToSearch:Dynamic)
    {
        var daThing:Dynamic = null;
        for (i in 0...array.length)
        {
            if (array[i] == thingToSearch)
            {
                daThing = thingToSearch;
            }
        }
        return daThing;
    }

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

    public function changeStatus(status:String, ?type:String, ?presence:String, ?afk:Bool = false)
    {
        var availableStatus:Array<String> = ["online", "dnd", "idle", "invisible", "offline"];
        if (status != "online" && status != "dnd" && status != "idle" && status != "invisible" && status != "offline")
        {
            throw("Invalid status: " + status);
        }
        
        var data = null;
        if (type != null && type != null)
        {
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

        ws.sendJson(data);
    }

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

    public function nMessage(ms:MessageS, d:Dynamic) {
        var daUser = new User(this);
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

    dynamic public function onInteractionCreate(i:Interaction)
    {

    }

    dynamic public function onReady()
    {

    }

    dynamic public function onMessageCreate(m:Message)
    {

    }
}