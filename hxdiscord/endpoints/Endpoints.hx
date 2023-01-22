/**
    Endpoints. The class that handles all the HTTP requests.
**/

package hxdiscord.endpoints;

import hxdiscord.types.Typedefs.ModifyGuildParams;
import hxdiscord.utils.Https;
import hxdiscord.DiscordClient;
import haxe.Http;
import haxe.io.BytesOutput;
import haxe.Json;

using StringTools;

class Endpoints
{
    @:dox(hide)
    public static var url:String = "https://discord.com/api/";
    @:dox(hide)
    public static var version:String = "v10";

    @:dox(hide)
    public var getGateway:String = "/gateway";
    @:dox(hide)
    public static var getGatewayBot:String = "/gateway/bot";

    @:dox(hide)
    public static function getEndpointData(?token:String, _url:String, _version:String, _endpointPath:String, ?_args:String) //idk if that's the correct term to call it
    {
        return Https.sendRequest(_url, _version, _endpointPath, _args, token);
    }

    //dm

    public static function createDM(userID:String):String
    {
        var _data:String;
        var r = new haxe.Http("https://discord.com/api/v10/users/@me/channels");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);

        r.setPostData(haxe.Json.stringify({
            recipient_id: userID
        }));

		r.onData = function(data:String)
		{
            if (DiscordClient.debug)
            {
                trace(data);
            }
            _data = data;
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
		}

		r.request(true);

        return _data;
    }

    //users

    /**
        Gets the current user information.
    **/
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

    /**
        Get the information about a user
        @param id The ID of the user
    **/
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

    /**
        Get the roles of a guild
        @param guild_id The guild ID
    **/
    public static function getRoles(guild_id:String)
    {
        var r = new haxe.Http("https://discord.com/api/v10/guilds/"+guild_id+"/roles");
        trace("https://discord.com/api/v10/guilds/"+guild_id+"/roles/");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token); //WHY DO I KEEP ADDING MY TOKEN TO THE SOURCE? :SOB:

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

    /**
        Deletes a message
        @param channel_id Channel ID where the message is
        @param m_id Message ID
    **/
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

    /*
        Send a message
        @param channel_id The channel ID to send the message
        @param message JSON object about the message
        @param id If you want to ping a message. Enter the ID of the message here
        @param reply Whether to ping the message or not
    */
    public static function sendMessage(channel_id:String, message:hxdiscord.types.Typedefs.MessageCreate, ?id:String, reply:Bool)
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
                var input = sys.io.File.getBytes(json.attachments[i].filename);
                body += input + "\n";
            }
            body += '--boundary--';
            #if (!neko)
            trace("If the attachment you sent is a corrupted file. Try to use Neko instead. This will probably get fixed in the future.");
            #end
        }

        var r = new haxe.Http("https://discord.com/api/v10/channels/" + channel_id + "/messages");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        r.addHeader("Content-Type", "multipart/form-data; boundary=boundary");

        trace(body);
        r.setPostBytes(haxe.io.Bytes.ofString(body));

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

    @:dox(hide) @:deprecated
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

    @:dox(hide) @:deprecated
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

    //reactions

    public static function createReaction(channel_id:String, message_id:String, emoji:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji+"/@me");
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.customRequest(false, responseBytes, "PUT");
		var response = responseBytes.getBytes();
    }

    public static function deleteOwnReaction(channel_id:String, message_id:String, emoji:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji+"/@me");
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.customRequest(false, responseBytes, "DELETE");
		var response = responseBytes.getBytes();
    }

    public static function deleteUserReaction(channel_id:String, message_id:String, emoji:String, user_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji+"/" + user_id);
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.customRequest(false, responseBytes, "DELETE");
		var response = responseBytes.getBytes();
    }
    
    public static function deleteAllReactions(channel_id:String, message_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/channels/"+channel_id+"/messages/"+message_id+"/reactions");
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.customRequest(false, responseBytes, "DELETE");
		var response = responseBytes.getBytes();
    }

    public static function deleteAllReactionsForEmoji(channel_id:String, message_id:String, emoji:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.customRequest(false, responseBytes, "DELETE");
        var response = responseBytes.getBytes();
    }

    //guilds

    /**
        Get a JSON object about a guild
        @param guild_id Guild ID
    **/
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
    
    /**
        Ban a user from a guild
        @param id The ID of the user to ban
        @param guild_id The guild ID
        @param reason The ban reason
    **/
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

    /**
        Remove a ban (unban)
        @param id The user ID to unban
        @param guild_id The guild ID
    **/
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

    /**
        Kick a user from a guild
        @param id The user ID to kick
        @param guild_id The guild ID
        @param reason The kick reason
    **/
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

    public function modifyGuild(guild_id:String, params:hxdiscord.types.Typedefs.ModifyGuildParams)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.addHeader("Content-Type", "application/json");
        req.setPostData(haxe.Json.stringify(params));
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.customRequest(true, responseBytes, "PATCH");
        var response = responseBytes.getBytes();
    }

    public function getGuildChannels(guild_id:String)
    {
        var r = new haxe.Http("https://discord.com/api/v10/guilds/" + guild_id + "/channels");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        var thing:String = "";

        r.onData = function(data:String)
        {
            if (DiscordClient.debug)
            {
                trace(data);
            }
            thing = data;
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
        }

        r.request();

        return thing;
    }

    public function deleteGuild(guild_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
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

    public function editChannelPermissions(channel_id:String, overwrite_id:String, data:Dynamic)
    {
        var req:Http = new Http("https://discord.com/api/v10/channels/"+channel_id+"/permissions/"+overwrite_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.addHeader("Content-Type", "application/json");
        req.setPostData(haxe.Json.stringify(data));
    
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

    public function modifyGuildRole(guild_id:String, role_id:String, data:hxdiscord.types.Typedefs.ModifyGuildRoleParams)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id+"/roles/"+role_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.addHeader("Content-Type", "application/json");
        req.setPostData(haxe.Json.stringify(data));
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.customRequest(true, responseBytes, "PATCH");
        var response = responseBytes.getBytes();
    }

    public function addGuildMemberRole(guild_id:String, user_id:String, role_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id+"/members/"+user_id+"/roles/"+role_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.customRequest(false, responseBytes, "PUT");
        var response = responseBytes.getBytes();
    }

    public function removeGuildMemberRole(guild_id:String, user_id:String, role_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v10/guilds/"+guild_id+"/members/"+user_id+"/roles/"+role_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
        req.setPostData("");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.customRequest(false, responseBytes, "DELETE");
        var response = responseBytes.getBytes();
    }

    //interactions

    /**
        Get application commands
    **/

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
    /**
        Add application commands
        @param data JSON object containing application commands
    **/
    public static function createGlobalApplicationCommand(data:Any)
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

    /**
        Override existing commands with new ones
        @param data JSON object containing application commands
    **/
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

    /**
        Send the interaction callback
    **/
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

    @:dox(hide) @:deprecated
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