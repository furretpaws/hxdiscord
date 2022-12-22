package hxdiscord.endpoints;

import hxdiscord.utils.Https;
import hxdiscord.DiscordClient;

class Endpoints
{
    public static var url:String = "https://discord.com/api/";
    public static var version:String = "v10";

    public var getUser:String = "/users/";

    public var getGateway:String = "/gateway";
    public static var getGatewayBot:String = "/gateway/bot";

    public static function getEndpointData(?token:String, _url:String, _version:String, _endpointPath:String, ?_args:String) //idk if that's the correct term to call it
    {
        return Https.sendRequest(_url, _version, _endpointPath, _args, token);
    }

    public static function sendMessage(content:String, reply:Bool, channelId:String, ?refMessageID:String)
    {
        var r = new haxe.Http("https://discord.com/api/v10/channels/" + channelId + "/messages");

        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        if (!reply)
        {
            r.setPostData(haxe.Json.stringify({
                "content": content
            }));
        }
        else
        {
            r.setPostData(haxe.Json.stringify({
                "content": content,
                message_reference: {
                    message_id: refMessageID,
                }
            }));
        }

		r.onData = function(data:String)
		{
            if (DiscordClient.debug)
            {
                trace(data);
            }
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
		}

		r.request(true);
    }

    public static function sendDataToMessageAPI(data:Dynamic, channelId:String)
    {
        var r = new haxe.Http("https://discord.com/api/v10/channels/" + channelId + "/messages");

        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);

        r.setPostData(haxe.Json.stringify(data));

		r.onData = function(data:String)
		{
            if (DiscordClient.debug)
            {
                trace(data);
            }
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
		}

		r.request(true);
    }

    public static function sendInteractionCallback(content:String, interactionID:String, interactionToken:String, type:Int, ?ephemeral:Bool)
    {
        var url:String = "https://discord.com/api/v10/interactions/" + interactionID + "/" + interactionToken + "/callback";
        if (DiscordClient.debug)
        {
            trace(url);
        }
        var r = new haxe.Http(url);

        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        
        var data = null;

        if (!ephemeral)
        {
            r.setPostData(haxe.Json.stringify({
                "type": 4,
                "data": {
                    "content": content
                }
            }));
        }
        else 
        {
            r.setPostData(haxe.Json.stringify({
                "type": 4,
                "data": {
                    "content": content
                },
                "flags": 64
            }));
        }

		r.onData = function(data:String)
		{
            if (DiscordClient.debug)
            {
                trace(data);
            }
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
		}

		r.request(true);
    }
}