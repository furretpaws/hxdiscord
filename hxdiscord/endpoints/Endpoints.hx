package hxdiscord.endpoints;

import hxdiscord.utils.Https;
import hxdiscord.DiscordClient;
import haxe.Http;
import haxe.io.BytesOutput;
import haxe.Json;

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

    /*public static function sendMessage(content:String, reply:Bool, channelId:String, ?refMessageID:String)
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
            trace(r.responseData);
		}

		r.request(true);
    }*/

    public static function sendMessage(channel_id:String, message:hxdiscord.types.Typedefs.MessageCreate, id:String, reply:Bool)
    {
        var r = new haxe.Http("https://discord.com/api/v10/channels/" + channel_id + "/messages");

        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        if (reply)
        {
            message.message_reference = {
                message_id: id
            };
        }
        r.setPostData(haxe.Json.stringify(message));
        trace(haxe.Json.stringify(message));

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
            trace(r.responseData);
		}

		r.request(true);
    }

    public static function sendMessageToChannelID(channelID:String, data:Dynamic)
    {
        var r = new haxe.Http("https://discord.com/api/v9/channels/" + channelID + "/messages");

        trace(channelID);
        trace(data);

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
            trace(r.responseData);
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

    public static function getGlobalApplicationCommands()
    {
        var r = new haxe.Http("https://discord.com/api/v10/applications/" + DiscordClient.accountId + "/commands");

        r.addHeader("Authorization", "Bot " + DiscordClient.token);

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

		r.request();

        return r.responseData;
    }
    public static function createGlobalApplicationCommand(data:Any, overwrite:Bool)
    {
        var r:haxe.Http;

        r = new haxe.Http("https://discord.com/api/v10/applications/"+DiscordClient.accountId+"/commands");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        r.setPostData(haxe.Json.stringify(data));
        r.onData = function(_data:String)
        {
            if (DiscordClient.debug)
            {
                trace(_data);
            }
        }
        r.onError = function(error)
        {
            throw("An error has occurred: " + error);
        }
        r.request(true);
    }

    public static function bulkOverwriteGlobalApplicationCommands(data:Any)
    {
        var req:Http = new Http("https://discord.com/api/v10/applications/"+DiscordClient.accountId+"/commands");
		var responseBytes = new BytesOutput();
    
		req.setPostData(Json.stringify(data)); 
		req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
    
    	req.onError = function(error:String) {
            trace(req.responseData);
            var response = responseBytes.getBytes();
			throw error;
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.customRequest(true, responseBytes, "PUT");
		var response = responseBytes.getBytes();
    	return Json.parse(response.toString());
    }

    public static function sendInteractionCallback(ic:hxdiscord.types.Typedefs.InteractionCallback, interactionID:String, interactionToken:String, type:Int, ?ephemeral:Bool)
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

        if (ephemeral)
        {
            ic.flags = 64;
        }

        r.setPostData(haxe.Json.stringify({
            "type": 4,
            "data": ic
        }));
        trace(haxe.Json.stringify({
            "type": 4,
            "data": ic
        }));

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

    public static function sendDataToInteraction(data:Dynamic, interactionID:String, interactionToken:String, type:Int)
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
}