package hxdiscord.endpoints;

import hxdiscord.utils.Https;
import hxdiscord.DiscordClient;
import haxe.Http;
import haxe.io.BytesOutput;
import haxe.Json;

using StringTools;

class Endpoints
{
    public static var url:String = "https://discord.com/api/";
    public static var version:String = "v10";

    public var getGateway:String = "/gateway";
    public static var getGatewayBot:String = "/gateway/bot";

    public static function getEndpointData(?token:String, _url:String, _version:String, _endpointPath:String, ?_args:String) //idk if that's the correct term to call it
    {
        return Https.sendRequest(_url, _version, _endpointPath, _args, token);
    }

    //users

    public static function getCurrentUser()
    {
        var r = new haxe.Http("https://discord.com/api/v10/users/@me");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);

        var user:hxdiscord.types.User = null;

		r.onData = function(data:String)
		{
            user = new hxdiscord.types.User(null, haxe.Json.parse(data));
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
		}

		r.request();

        return user;
    }

    public static function getUser(id:String)
    {
        var r = new haxe.Http("https://discord.com/api/v10/users/" + id);

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);

        var user:hxdiscord.types.User = null;

        r.onData = function(data:String)
        {
            user = new hxdiscord.types.User(null, haxe.Json.parse(data));
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
        }

        r.request();

        return user;
    }

    public static function getRoles(guild_id:String)
    {
        var r = new haxe.Http("https://discord.com/api/v10/guilds/"+guild_id+"/roles");
        trace("https://discord.com/api/v10/guilds/"+guild_id+"/roles/");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + "MTA0NzI3NzU2Nzc1NDg5OTUyOA.GU64Dp.FD66A7eWRCBUKD-oZRSy-IVVT-vDTugDXLt6vM");

        var response:String = "";


		r.onData = function(data:String)
		{
            if (DiscordClient.debug)
            {
                trace(data);
            }
            response = data;
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
		}

		r.request();

        return response;
    }

    public static function deleteMessage(channel_id:String, m_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/channels/"+channel_id+"/messages/"+m_id);
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
		req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.customRequest(true, responseBytes, "DELETE");
    }

    public static function sendMessage(channel_id:String, message:hxdiscord.types.Typedefs.MessageCreate, id:String, reply:Bool)
    {
        //USING MULTIPART BECAUSE YES.
        if (reply)
         {
             message.message_reference = {
                 message_id: id
             };
         }
        var attachments:Bool = false;
        if (message.attachments == null)
            attachments = false;
        else
            attachments = true;

        var body:String = '--boundary
Content-Disposition: form-data; name="payload_json";
Content-Type: application/json;';
        body += "\n\n";
        //quick check
        var jsonCheck:Dynamic = haxe.Json.parse(haxe.Json.stringify(message));
        if (jsonCheck.attachments != null)
        {
            var filename:String = "";
            var thing = "";
            var returnJson:Dynamic = haxe.Json.parse(haxe.Json.stringify(message));
            for (i in 0...jsonCheck.attachments.length)
            {
                thing = jsonCheck.attachments[i].filename.toString();
                var split = thing.split("/");
                returnJson.attachments[i].filename = split[split.length-1];
            }
            body += haxe.Json.stringify(returnJson) + "\n";
        }
        else
        {
            body += haxe.Json.stringify(message) + "\n";
        }
        if (!attachments)
        {
            body += '--boundary--';
        }
        else if (attachments)
        {
            var json = haxe.Json.parse(haxe.Json.stringify(message));
            for (i in 0...message.attachments.length)
            {
                var filename:String = "";
                var thing = "";
                thing = json.attachments[i].filename.toString();
                if (thing.contains("/"))
                {
                    var split = thing.split("/");
                    filename = split[split.length-1];
                }
                else
                {
                    filename = thing;
                }
                if (!sys.FileSystem.exists(json.attachments[i].filename))
                {
                    throw('"' + json.attachments[i].filename + '" does not exist.');
                }
                body += '--boundary\n';
                body += 'Content-Disposition: form-data; name="files[' + i + ']"; filename="' + filename + '"' + "\n";
                body += 'Content-Type: ' + hxdiscord.utils.MimeResolver.getMimeType(filename);
                body += '\n\n';
                body += sys.io.File.getBytes(json.attachments[i].filename.toString()).toString() + "\n";
            }
            body += '--boundary--';
        }

        var r = new haxe.Http("https://discord.com/api/v10/channels/" + channel_id + "/messages");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        r.addHeader("Content-Type", "multipart/form-data; boundary=boundary");

        r.setPostData(body);

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

        if (DiscordClient.debug)
        {
            trace(channelID);
            trace(data);
        }

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
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

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
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

    //guilds

    public static function getGuild(guild_id:String)
    {
        var r = new haxe.Http("https://discord.com/api/v10/guilds/" + guild_id + "?with_counts=true");

        var guild:hxdiscord.types.Guild = null;

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);

		r.onData = function(data:String)
		{
            var d = haxe.Json.parse(data);
            guild = new hxdiscord.types.Guild(d);
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
		}

		r.request();

        return guild;
    }
    
    public static function createGuildBan(id:String, guild_id:String, ?reason:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id+"/bans/"+id);
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
		req.addHeader("Content-type", "application/json");
        if (reason != null)
        {
            req.addHeader("X-Audit-Log-Reason", reason);
        }
        req.addHeader("Authorization", "Bot " + DiscordClient.token);

        req.setPostData(haxe.Json.stringify({
            delete_message_days: 0,
            delete_message_seconds: 0
        }));
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.customRequest(true, responseBytes, "PUT");
		var response = responseBytes.getBytes();
    }

    public static function removeGuildBan(id:String, guild_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id+"/bans/"+id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);

    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.customRequest(true, responseBytes, "DELETE");
        var response = responseBytes.getBytes();
    }

    public static function removeGuildMember(id:String, guild_id:String, ?reason:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id+"/members/"+id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        if (reason != null)
        {
            req.addHeader("X-Audit-Log-Reason", reason);
        }

    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.customRequest(true, responseBytes, "DELETE");
        var response = responseBytes.getBytes();
    }

    //interactions

    public static function getGlobalApplicationCommands()
    {
        var r = new haxe.Http("https://discord.com/api/v10/applications/" + DiscordClient.accountId + "/commands");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
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
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
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
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
		req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
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
        var attachments:Bool = false;
        if (ic.attachments != null)
        {
            attachments = true;
        }
        else
        {
            attachments = false;
        }
        var getJson = haxe.Json.parse(haxe.Json.stringify(ic));

        if (ephemeral)
        {
            ic.flags = 64;
        }

        //generate body / now using multipart :money_mouth:
        var body:String = '--boundary';
        body += '\nContent-Disposition: form-data; name="payload_json"';
        body += '\nContent-Type: application/json\n';
        body += '\n';
        if (attachments)
        {
            var newJson:Dynamic = haxe.Json.parse(haxe.Json.stringify({
                "type": 4,
                "data": ic
            }));
            var filename:String = "";
            var thing = "";
            for (i in 0...newJson.data.attachments.length)
            {
                thing = newJson.data.attachments[i].filename.toString();
                var split = thing.split("/");
                newJson.data.attachments[i].filename = split[split.length-1];
            }
            body += haxe.Json.stringify(newJson);
        }
        else
        {
            body += haxe.Json.stringify({
                "type": 4,
                "data": ic
            });
        }
        if (attachments)
        {
            for (i in 0...ic.attachments.length)
            {
                body += "\n--boundary";
                body += '\nContent-Disposition: form-data; name="files[' + i + ']"; filename="' + getJson.attachments[i].filename + '"';
                body += '\nContent-Type: ' + hxdiscord.utils.MimeResolver.getMimeType(getJson.attachments[i].filename);
                body += '\n\n';
                body += sys.io.File.getBytes(getJson.attachments[i].filename.toString()).toString();
            }
            body += "\n--boundary--";
        }
        else
        {
            body += "\n--boundary--";
        }

        var r = new haxe.Http("https://discord.com/api/v10/interactions/" + interactionID + "/" + interactionToken + "/callback");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        r.addHeader("Content-Type", "multipart/form-data; boundary=boundary");

        r.setPostData(body);

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

    public static function sendDataToInteraction(data:Dynamic, interactionID:String, interactionToken:String, type:Int)
    {
        var url:String = "https://discord.com/api/v10/interactions/" + interactionID + "/" + interactionToken + "/callback";
        if (DiscordClient.debug)
        {
            trace(url);
        }
        var r = new haxe.Http(url);
    
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
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