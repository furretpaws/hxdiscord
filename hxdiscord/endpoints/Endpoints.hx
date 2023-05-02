/**
    Endpoints. The class that handles all the HTTP requests.
**/

package hxdiscord.endpoints;

import hxdiscord.types.structTypes.Thread.ForumChannel;
import hxdiscord.types.structTypes.Thread.WithoutMessage;
import hxdiscord.types.structTypes.Thread.FromMessage;
import hxdiscord.types.Typedefs.ModifyGuildParams;
import hxdiscord.utils.Https;
import hxdiscord.DiscordClient;
import hxdiscord.utils.Http;
#if (js&&nodejs)
import js.node.Fs;
#end
import haxe.io.BytesOutput;
import hxdiscord.gateway.Gateway;
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

    /**
        Creates a DM chat with a specified user ID
        @param userID The user ID
    **/

    public static function createDM(userID:String):String
    {
        var _data:String;
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/users/@me/channels");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);

        r.setPostData(haxe.Json.stringify({
            recipient_id: userID
        }));

        r.setMethod("POST");

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
            trace(r.responseData);
		}

		r.send();

        return _data;
    }

    //users

    /**
        Gets the current user information.
    **/
    public static function getCurrentUser()
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/users/@me");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);

        r.setMethod("GET");

        var user:hxdiscord.types.User = null;

		r.onData = function(data:String)
		{
            user = new hxdiscord.types.User(null, haxe.Json.parse(data));
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
            trace(r.responseData);
		}

		r.send();

        return user;
    }

    /**
        Check if the user has a specific permission
        @param userID The ID of the user you want to check
        @param guildID The ID of the guild where the user is in
        @param permissionToLookFor The permission which you wanna look for. (Example: ADMINISTRATOR)
    **/

    public static function hasPermission(userID:String, guild_id:String, permissionToLookFor:String)
    {
        var hasPermission:Bool = false;
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/members/" + userID);
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");


		r.onData = function(dataG:String)
		{
            var data = getRoles(guild_id);
            var json:Dynamic = haxe.Json.parse(dataG);

            var roles:Array<String> = json.roles;

            var jsonRole:Dynamic = haxe.Json.parse(data);
            for (i in 0...jsonRole.length)
            {
                for (x in 0...roles.length)
                {
                    if (jsonRole[i].id == roles[x])
                    {
                        var array:Array<String> = hxdiscord.utils.Permissions.resolve(haxe.Int64.fromFloat(Std.parseFloat(jsonRole[i].permissions)));
                        if (array.contains(permissionToLookFor))
                        {
                            hasPermission = true;
                        }
                    }
                }
            }
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
            trace(r.responseData);
		}

		r.send();
        return hasPermission;
    }

    /**
        Get the information about a user
        @param id The ID of the user
    **/
    public static function getUser(id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/users/" + id);

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

        var user:hxdiscord.types.User = null;

        r.onData = function(data:String)
        {
            user = new hxdiscord.types.User(null, haxe.Json.parse(data));
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }

        r.send();

        return user;
    }

    /**
        Returns a GuildMember object of a user
        @param guild_id The guild id where the user is in
        @param id The user ID
    **/

    public static function getGuildMember(guild_id:String, id:String, cb:hxdiscord.types.Member -> Void, err:Dynamic->Void):Void
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/" + guild_id + "/members/" + id);
    
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");
    
        var guildmember:hxdiscord.types.Member = null;
    
        r.onData = function(data:String)
        {
            guildmember = new hxdiscord.types.Member(haxe.Json.parse(data), guild_id);
            cb(guildmember);
        }
    
        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
            err(error);
        }
    
        r.send();
    }

    /**
        Get the roles of a guild
        @param guild_id The guild ID
    **/
    public static function getRoles(guild_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/roles");
        //trace("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/roles/");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader); //WHY DO I KEEP ADDING MY TOKEN TO THE SOURCE? :SOB:
        r.setMethod("GET");

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
            trace(r.responseData);
		}

		r.send();

        return response;
    }

    /**
        Deletes a message
        @param channel_id Channel ID where the message is
        @param m_id Message ID
    **/
    public static function deleteMessage(channel_id:String, m_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/"+m_id);
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
		req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setMethod("DELETE");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.send();
    }

    /*
        Edit a message (Obviously it has to be sent by you)

        @param channel_id The channel id where the message is located
        @param m_id The message id
        @param m The message create object
    */

    public static function editMessage(channel_id:String, m_id:String, m:hxdiscord.types.Typedefs.MessageCreate)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/"+m_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData(haxe.Json.stringify(m));
        req.setMethod("PATCH");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
    }

    /*
        Send a message
        @param channel_id The channel ID to send the message
        @param message JSON object about the message
        @param id If you want to ping a message. Enter the ID of the message here
        @param reply Whether to ping the message or not
    */
    public static function sendMessage(channel_id:String, message:hxdiscord.types.Typedefs.MessageCreate, ?id:String, reply:Bool):Dynamic
    {
        //USING MULTIPART BECAUSE YES.
        var response:String;
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

        #if (!js)
        var bytesOutput:BytesOutput = new BytesOutput();
        bytesOutput.writeString("--boundary");
        bytesOutput.writeString("\n");
        bytesOutput.writeString("Content-Disposition: form-data; name=\"payload_json\"");
        bytesOutput.writeString("\n");
        bytesOutput.writeString("Content-Type: application/json;");
        bytesOutput.writeString("\n\n");
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
            bytesOutput.writeString(haxe.Json.stringify(returnJson) + "\n");
        }
        else
        {
            bytesOutput.writeString(haxe.Json.stringify(message) + "\n");
        }
        if (!attachments)
        {
            bytesOutput.writeString('--boundary--');
        }
        else if (attachments)
        {
            var json = haxe.Json.parse(haxe.Json.stringify(message));
            for (i in 0...message.attachments.length)
            {
                var filename:String = "";
                var thing = "";
                #if python
                thing = json.attachments[i].filename;
                #else
                thing = json.attachments[i].filename.toString();
                #end
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
                bytesOutput.writeString('--boundary\n');
                bytesOutput.writeString('Content-Disposition: form-data; name="files[' + i + ']"; filename="' + filename + '"' + "\n");
                bytesOutput.writeString('Content-Type: ' + hxdiscord.utils.MimeResolver.getMimeType(filename) + ";base64"); //idk why's base64 there but it works so i'm leaving it like that
                bytesOutput.writeString("\n\n");
                bytesOutput.writeFullBytes(sys.io.File.getBytes(json.attachments[i].filename), 0, sys.FileSystem.stat(json.attachments[i].filename).size);
                bytesOutput.writeString("\n");
            }
            bytesOutput.writeString('--boundary--');
        }

        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/messages");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.addHeader("Content-Type", "multipart/form-data; boundary=boundary");

        r.setMethod("POST");

        //trace(body);
        r.setPostBytes(bytesOutput.getBytes());

        var daRealResponse:Dynamic = "";

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
            trace(r.responseData);
        }

        r.send();

        try {
            daRealResponse = haxe.Json.parse(response);
        } catch (e) {
            daRealResponse = response;
        }

        return haxe.Json.parse(response);
        #else
        var request:String = "";
        request += ("--boundary");
        request += ("\n");
        request += ("Content-Disposition: form-data; name=\"payload_json\"");
        request += ("\n");
        request += ("Content-Type: application/json;");
        request += ("\n\n");
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
            request += (haxe.Json.stringify(returnJson) + "\n");
        }
        else
        {
            request += (haxe.Json.stringify(message) + "\n");
        }
        if (!attachments)
        {
            request += ('--boundary--');
        }
        else if (attachments)
        {
            var json = haxe.Json.parse(haxe.Json.stringify(message));
            for (i in 0...message.attachments.length)
            {
                var filename:String = "";
                var thing = "";
                #if python
                thing = json.attachments[i].filename;
                #else
                thing = json.attachments[i].filename.toString();
                #end
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
                request += ('--boundary\n');
                request += ('Content-Disposition: form-data; name="files[' + i + ']"; filename="' + filename + '"' + "\n");
                request += ('Content-Type: ' + hxdiscord.utils.MimeResolver.getMimeType(filename) + ";base64"); //idk why's base64 there but it works so i'm leaving it like that
                request += ("\n\n");
                //request += (sys.io.File.getBytes(json.attachments[i].filename).toString());
                request += (Fs.readFileSync(json.attachments[i].filename, {encoding: "binary"}));
                request += ("\n");
            }
            request += ('--boundary--');
        }

        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/messages");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.addHeader("Content-Type", "multipart/form-data; boundary=boundary");

        r.setMethod("POST");

        //trace(body);
        r.setPostData(request);

        var daRealResponse:Dynamic = "";

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
            trace(r.responseData);
        }

        r.send();

        try {
            daRealResponse = haxe.Json.parse(response);
        } catch (e) {
            daRealResponse = response;
        }

        return response;
        #end
    }

    @:dox(hide) @:deprecated
    public static function sendMessageToChannelID(channelID:String, data:Dynamic)
    {
        var r = new Http("https://discord.com/api/v9/channels/" + channelID + "/messages");

        if (DiscordClient.debug)
        {
            trace(channelID);
            trace(data);
        }

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");

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

		r.send();
    }

    @:dox(hide) @:deprecated
    public static function sendDataToMessageAPI(data:Dynamic, channelId:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channelId + "/messages");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);

        r.setMethod("POST");

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

		r.send();
    }

    //reactions

    /**
        React to a message
        @param channel_id The channel id where the message is located
        @param message_id The id of the message you wanna react to
        @param emoji The emoji itself
    **/

    public static function createReaction(channel_id:String, message_id:String, emoji:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji+"/@me");
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("PUT");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.send();
    }

    /**
        Remove your own reaction from a message
        @param channel_id The channel id where the message is located
        @param message_id The id of the message you wanna remove the reaction
        @param emoji The emoji itself
    **/

    public static function deleteOwnReaction(channel_id:String, message_id:String, emoji:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji+"/@me");
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.send();
    }

    /**
        Remove a user reaction
        @param channel_id The channel id where the message is located
        @param message_id The id of the message you wanna remove the reaction
        @param emoji The emoji itself
        @param user_id The ID of the user
    **/

    public static function deleteUserReaction(channel_id:String, message_id:String, emoji:String, user_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji+"/" + user_id);
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.send();
    }

    /**
        Remove ALL reactions
        @param channel_id The channel id where the message is located
        @param message_id The id of the message
    **/
    
    public static function deleteAllReactions(channel_id:String, message_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/"+message_id+"/reactions");
		var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.send();
    }

    /**
        Remove ALL reactions for an specific emoji
        @param channel_id The channel id where the message is located
        @param message_id The id of the message
        @param emoji The emoji itself
    **/

    public static function deleteAllReactionsForEmoji(channel_id:String, message_id:String, emoji:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/"+message_id+"/reactions/"+emoji);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
    }

    //guilds

    /**
        Get a JSON object about a guild
        @param guild_id Guild ID
    **/
    public static function getGuild(guild_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/" + guild_id + "?with_counts=true");

        var guild:hxdiscord.types.Guild = null;

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

		r.onData = function(data:String)
		{
            var d = haxe.Json.parse(data);
            guild = new hxdiscord.types.Guild(d);
		}

		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
            trace(r.responseData);
		}

		r.send();

        return guild;
    }
    
    /**
        Ban a user from a guild
        @param id The ID of the user to ban
        @param guild_id The guild ID
        @param reason The ban reason
    **/
    public static function createGuildBan(id:String, guild_id:String, ?reason:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/bans/"+id);
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
		req.addHeader("Content-type", "application/json");
        if (reason != null)
        {
            req.addHeader("X-Audit-Log-Reason", reason);
        }
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setMethod("PUT");

        req.setPostData(haxe.Json.stringify({
            delete_message_days: 0,
            delete_message_seconds: 0
        }));
    
    	req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.send();
        return s;
    }

    /**
        Remove a ban (unban)
        @param id The user ID to unban
        @param guild_id The guild ID
    **/
    public static function removeGuildBan(id:String, guild_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/bans/"+id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Kick a user from a guild
        @param id The user ID to kick
        @param guild_id The guild ID
        @param reason The kick reason
    **/
    public static function removeGuildMember(id:String, guild_id:String, ?reason:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/members/"+id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setMethod("DELETE");
        if (reason != null)
        {
            req.addHeader("X-Audit-Log-Reason", reason);
        }

    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }
    
    /**
        Modify a member of a guild
        @param guild_id The ID of the guild
        @param user_id The ID of the user you want to modify
        @param d The request object
    **/

    public static function modifyGuildMember(guild_id:String, user_id:String, d:hxdiscord.types.Typedefs.ModifyGuildMemberParams):Bool {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/members/"+user_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.addHeader("Content-Type", "application/json");
        req.setPostData(haxe.Json.stringify(d));
        req.setMethod("PATCH");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Modifies a guild
        @param guild_id The ID of the guild
        @param params The request object
    **/

    public static function modifyGuild(guild_id:String, params:hxdiscord.types.Typedefs.ModifyGuildParams):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.addHeader("Content-Type", "application/json");
        req.setPostData(haxe.Json.stringify(params));
        req.setMethod("PATCH");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Returns a JSON object representing all the channels in a guild
        @param guild_id The ID of the guild
    **/

    public static function getGuildChannels(guild_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/" + guild_id + "/channels");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");
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
            trace(r.responseData);
        }

        r.send();

        return thing;
    }

    /**
        Removes a guild (This will only work if you're the owner of the guild)
        @param guild_id The ID of the guild you want to remove
    **/

    public static function deleteGuild(guild_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Edit channel's permissions
        @param channel_id The ID of the channel
        @param overwrite_id The ID of the role you want to over
    **/

    public static function editChannelPermissions(channel_id:String, overwrite_id:String, data:Dynamic):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/permissions/"+overwrite_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.addHeader("Content-Type", "application/json");
        req.setPostData(haxe.Json.stringify(data));
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Returns a JSON representation of the invites from the channel
        @param channel_id The ID of the channel
    **/

    public static function getChannelInvites(channel_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/invites");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");
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
            trace(r.responseData);
        }

        r.send();

        return thing;
    }

    /**
        Returns a JSON object containing the messages you wanted. Also, read https://discord.com/developers/docs/resources/channel#get-channel-messages
        @param channel_id The channel ID to get the messages
        @param obj The JSON object (Read API)
    **/

    public static function getChannelMessages(channel_id:String, limit:Int) {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/messages?limit=" + limit);

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");
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
            trace(r.responseData);
        }

        r.send();

        return thing;
    }

    /**
        Creates a channel invite
        @param channel_id The id of the channel
        @param obj The request object
    **/

    public static function createChannelInvite(channel_id:String, obj:hxdiscord.types.Typedefs.ChannelInvite):String
    {
        var thing:String = "";
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/invites");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");

        r.setPostData(haxe.Json.stringify(obj));

        r.onData = function(data:String)
        {
            thing = data;
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

        r.send();
        return thing;
    }

    /**
        Delete channel permission
        @param channel_id The ID of the channel
        @param overwrite_id The overwrite ID of the permission
    **/

    public static function deleteChannelPermission(channel_id:String, overwrite_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/permissions/"+overwrite_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.addHeader("Content-Type", "application/json");
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Follows an announcement channel
        @param channel_id The ID of the channel to follow
        @param id
    **/

    public static function followAnnouncementChannel(channel_id:String, id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/invites");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");

        r.setPostData(haxe.Json.stringify({
            webhook_channel_id: id
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
            trace(r.responseData);
        }

        r.send();
    }

    /**
        Triggers the typing indicator on a channel
        @param channel_id The channel ID on which to trigger the typing indicator
    **/

    public static function triggerTypingIndicator(channel_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/typing");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");

        r.setPostData("");

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

        r.send();
    }

    /**
        Returns a list of the pinned messages in a channel
        @param channel_id The channel ID
    **/

    public static function getPinnedMessages(channel_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/pins");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

        var thing:String = null;

        r.onData = function(data:String)
        {
            if (DiscordClient.debug)
            {
                trace(data);
                thing = data;
            }
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }

        r.send();
        return thing;
    }

    /**
        Pin a message to the channel
        @param channel_id The channel ID where the message is located on
        @param message_id The message ID
    **/

    public static function pinMessage(channel_id:String, message_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/pins/"+message_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("PUT");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Unpin a message from the channel
        @param channel_id The id of the channel where the message is located on
        @param message_id The id of the message you want to unpin
    **/

    public static function unpinMessage(channel_id:String, message_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/pins/"+message_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    @:dox(hide)
    public static function groupDMAddRecipient(channel_id:String, user_id:String, access_token:String, nick:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/recipients/"+user_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData(haxe.Json.stringify({
            access_token: access_token,
            nick: nick
        }));
        req.setMethod("PUT");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
    }

    @:dox(hide)
    public static function groupDMRemoveRecipient(channel_id:String, user_id:String)
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/recipients/"+user_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
    }

    /**
        Starts a new thread from a message
        @param channel_id The channel ID where the message is located in/where to start a thread
        @param message_id The message ID you want to start a thread from
        @param obj The request object
    **/
    public static function startThreadFromMessage(channel_id:String, message_id:String, obj:FromMessage):Bool
    {
        var s:Bool = true;
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/messages/" + message_id + "/threads");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");

        r.setPostData(haxe.Json.stringify(obj));

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
            s = false;
        }

        r.send();
        return s;
    }

    /**
        Starts a new thread without a message
        @param channel_id The id of the channel
        @param obj The object request
    **/

    public static function startThreadWithoutMessage(channel_id:String, obj:WithoutMessage):Bool
    {
        var s:Bool = true;
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/threads");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");

        r.setPostData(haxe.Json.stringify(obj));

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
            s = false;
        }

        r.send();
        return s;
    }

    /**
        Starts a thread in a forum channel
        @param channel_id The channel ID
        @param message_id The message ID
        @param obj The request object
    **/
    public static function startThreadInForumChannel(channel_id:String, message_id:String, obj:ForumChannel):Bool
    {
        var s:Bool = true;
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/threads");
    
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");
    
        r.setPostData(haxe.Json.stringify(obj));
    
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
            s = false;
        }
       
        r.send();
        return s;
    }

    /**
        Join a thread
        @param channel_id The channel ID
    **/

    public static function joinThread(channel_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/thread-members/@me");
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("PUT");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Add a member to a thread
        @param channel_id The ID of the thread
        @param user_id The ID of the user
    **/

    public static function addThreadMember(channel_id:String, user_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/thread-members/" + user_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("PUT");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Leave a thread
        @param channel_id The ID of the channel
    **/

    public static function leaveThread(channel_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/thread-members/@me");
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Kick a member from a thread
        @param channel_id The channel ID
        @param user_id The ID of the user
    **/

    public static function removeThreadMember(channel_id:String, user_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/thread-members/" + user_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Returns the information about a thread member
        @param channel_id
        @param user_id
    **/

    public static function getThreadMember(channel_id:String, user_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/thread-members/" + user_id);

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

        var thing:String = null;

        r.onData = function(data:String)
        {
            if (DiscordClient.debug)
            {
                trace(data);
                thing = data;
            }
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }

        r.send();
        return thing;
    }

    /**
        Returns a list of the thread members that are in a thread
        @param channel_id The ID of the channel
        @param user_id The ID of the user
    **/

    public static function listThreadMembers(channel_id:String, user_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/thread-members/");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

        var thing:String = null;

        r.onData = function(data:String)
        {
            if (DiscordClient.debug)
            {
                trace(data);
                thing = data;
            }
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }

        r.send();
        return thing;
    }

    /**
        List public archived threads
        @param channel_id The channel ID
        @param user_id The user ID
    **/
    public static function listPublicArchivedThreads(channel_id:String, user_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/thread-members/archived/public");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

        var thing:String = null;

        r.onData = function(data:String)
        {
            if (DiscordClient.debug)
            {
                trace(data);
                thing = data;
            }
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }

        r.send();
        return thing;
    }

    /**
        List private archived threads
        @param channel_id The channel ID
        @param user_id The user ID
    **/

    public static function listPrivateArchivedThreads(channel_id:String, user_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/thread-members/archived/public");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

        var thing:String = null;

        r.onData = function(data:String)
        {
            if (DiscordClient.debug)
            {
                trace(data);
                thing = data;
            }
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }

        r.send();
        return thing;
    }
    
    /**
        List joined private archived threads
        @param channel_id The channel ID
    **/

    public static function listJoinedPrivateArchivedThreads(channel_id:String)
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/" + channel_id + "/users/@me/thread-members/archived/private");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

        var thing:String = null;

        r.onData = function(data:String)
        {
            if (DiscordClient.debug)
            {
                trace(data);
                thing = data;
            }
        }

        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }

        r.send();
        return thing;
    }

    /**
        Modify a guild role
        @param guild_id The guild ID
        @param role_id The role ID
        @param data The request data
    **/

    public static function modifyGuildRole(guild_id:String, role_id:String, data:hxdiscord.types.Typedefs.ModifyGuildRoleParams):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/roles/"+role_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.addHeader("Content-Type", "application/json");
        req.setPostData(haxe.Json.stringify(data));
        req.setMethod("PATCH");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Adds a role to a guild member
        @param guild_id The guild ID
        @param user_id The user ID
        @param role_id The role ID
    **/

    public static function addGuildMemberRole(guild_id:String, user_id:String, role_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/members/"+user_id+"/roles/"+role_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("PUT");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    /**
        Removes a role from a guild member
        @param guild_id The guild ID
        @param user_id The user ID
        @param role_id The role ID
    **/

    public static function removeGuildMemberRole(guild_id:String, user_id:String, role_id:String):Bool
    {
        var s:Bool = true;
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/members/"+user_id+"/roles/"+role_id);
        var responseBytes = new BytesOutput();
    
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setPostData("");
        req.setMethod("DELETE");
    
        req.onError = function(error:String) {
            trace("An error has occurred: " + error);
            trace(req.responseData);
            s = false;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        return s;
    }

    //interactions

    /**
        Get application commands
    **/

    public static function getGlobalApplicationCommands()
    {
        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/applications/" + DiscordClient.accountId + "/commands");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("GET");

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

		r.send();

        return r.responseData;
    }
    /**
        Add application commands
        @param data JSON object containing application commands
    **/
    public static function createGlobalApplicationCommand(data:Any)
    {
        var r:Http;

        r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/applications/"+DiscordClient.accountId+"/commands");
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");
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
            trace(r.responseData);
        }
        r.send();
    }

    /**
        Override existing commands with new ones
        @param data JSON object containing application commands
    **/
    public static function bulkOverwriteGlobalApplicationCommands(data:Dynamic):Dynamic
    {
        var req:Http = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/applications/"+DiscordClient.accountId+"/commands");
		var responseBytes = new BytesOutput();
        var error:Bool = false;

        var json:Dynamic = haxe.Json.parse(Json.stringify(data));

        req.setMethod("PUT");

        #if (!neko)
        for (i in 0...json.length) {
            for (field in Reflect.fields(json[i])) {
                if (Reflect.field(json[i], field) == null) {
                    Reflect.deleteField(json[i], field);
                }
            }
        }
        #end
        
		req.setPostData(Json.stringify(json));
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
		req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", DiscordClient.authHeader);
    
    	req.onError = function(err:String) {
            trace("An error has occurred: " + err);
            error = true;
		};
		
		req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
		};
    
		req.send();
        if (error)
        {
            trace(req.responseData);
        }
    	#if js
        return req.responseData.toString();
        #else
        return req.responseData;
        #end
    }

    /**
        Bulk delete messages from a channel
        @param channel_id The channel ID
        @param messages An array with message ids
    **/

    public static function bulkDeleteMessages(channel_id:String, messages:Array<String>)
    {
        var r:Http;

        r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/channels/"+channel_id+"/messages/bulk-delete");
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");
        r.setPostData(haxe.Json.stringify({
            messages: messages
        }));
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
            trace(r.responseData);
        }
        r.send();
    }

    /**
        Send the interaction callback for the thinking state!
    **/

    public static function makeInteractionThink(interactionID:String, interactionToken:String, ?ephemeral:Bool = false)
    {
        var r:Http;

        r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/interactions/" + interactionID + "/" + interactionToken + "/callback");
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");
        var data:String = "";
        if (ephemeral) {
            data = haxe.Json.stringify(
                {
                    type: 5,
                    data: {
                        flags: 64
                    }
                }
            );
        } else {
            data = haxe.Json.stringify(
                {
                    type: 5
                }
            );
        }
        r.setPostData(data);
        r.onData = function(_data:String)
        {
            if (DiscordClient.debug)
            {
                trace(_data);
            }
        }
        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
            trace(data);
        }
        r.send();
    }

    /**
        Send the interaction callback for modals only!
    **/
    public static function showInteractionModal(imc:Array<hxdiscord.types.message.ActionRow>, interactionID:String, interactionToken:String, type:Int, title:String, custom_id:String)
    {
        var r:Http;

        r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/interactions/" + interactionID + "/" + interactionToken + "/callback");
        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.setMethod("POST");
        var data:String = haxe.Json.stringify(
            {
                type: 9,
                data: {
                    title: title,
                    type: 5,
                    custom_id: custom_id,
                    components: imc
                }
            }
        );
        r.setPostData(data);
        r.onData = function(_data:String)
        {
            if (DiscordClient.debug)
            {
                trace(_data);
            }
        }
        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
            trace(data);
        }
        r.send();
    }

    /**
        Send the interaction callback
    **/
    public static function sendInteractionCallback(ic:hxdiscord.types.Typedefs.InteractionCallback, interactionID:String, interactionToken:String, type:Int, ?ephemeral:Bool)
    {
        var response:String;
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

        #if (!js)
        //generate body / now using multipart :money_mouth:
        var bytesOutput:BytesOutput = new BytesOutput();
        bytesOutput.writeString("--boundary");
        bytesOutput.writeString("\n");
        bytesOutput.writeString("Content-Disposition: form-data; name=\"payload_json\"");
        bytesOutput.writeString("\n");
        bytesOutput.writeString("Content-Type: application/json;");
        bytesOutput.writeString("\n\n");
        if (attachments)
        {
            var newJson:Dynamic = haxe.Json.parse(haxe.Json.stringify({
                "type": type,
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
            bytesOutput.writeString(haxe.Json.stringify(newJson));
        }
        else
        {
            bytesOutput.writeString(haxe.Json.stringify({
                "type": type,
                "data": ic
            }));
        }
        if (attachments)
        {
            for (i in 0...ic.attachments.length)
            {
                bytesOutput.writeString("\n--boundary");
                bytesOutput.writeString('\nContent-Disposition: form-data; name="files[' + i + ']"; filename="' + getJson.attachments[i].filename + '"');
                bytesOutput.writeString('\nContent-Type: ' + hxdiscord.utils.MimeResolver.getMimeType(getJson.attachments[i].filename));
                bytesOutput.writeString('\n\n');
                bytesOutput.writeFullBytes(sys.io.File.getBytes(getJson.attachments[i].filename), 0, sys.FileSystem.stat(getJson.attachments[i].filename).size);
            }
            bytesOutput.writeString("\n--boundary--");
        }
        else
        {
            bytesOutput.writeString("\n--boundary--");
        }
        #else
        //generate body / now using multipart :money_mouth:
        var reqData:String = "";
        reqData += ("--boundary");
        reqData += ("\n");
        reqData += ("Content-Disposition: form-data; name=\"payload_json\"");
        reqData += ("\n");
        reqData += ("Content-Type: application/json;");
        reqData += ("\n\n");
        if (attachments)
        {
            var newJson:Dynamic = haxe.Json.parse(haxe.Json.stringify({
                "type": type,
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
            reqData += (haxe.Json.stringify(newJson));
        }
        else
        {
            reqData += (haxe.Json.stringify({
                "type": type,
                "data": ic
            }));
        }
        if (attachments)
        {
            for (i in 0...ic.attachments.length)
            {
                reqData += ("\n--boundary");
                reqData += ('\nContent-Disposition: form-data; name="files[' + i + ']"; filename="' + getJson.attachments[i].filename + '"');
                reqData += ('\nContent-Type: ' + hxdiscord.utils.MimeResolver.getMimeType(getJson.attachments[i].filename));
                reqData += ('\n\n');
                reqData += (Fs.readFileSync(getJson.attachments[i].filename, {encoding: "binary"}));
            }
            reqData += ("\n--boundary--");
        }
        else
        {
            reqData += ("\n--boundary--");
        }
        #end

        var r = new Http("https://discord.com/api/v"+Gateway.API_VERSION+"/interactions/" + interactionID + "/" + interactionToken + "/callback");

        r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        r.addHeader("Authorization", DiscordClient.authHeader);
        r.addHeader("Content-Type", "multipart/form-data; boundary=boundary");

        r.setMethod("POST");

        #if (!js)
        r.setPostBytes(bytesOutput.getBytes());
        #else
        r.setPostData(reqData);
        #end

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
            trace(r.responseData);
            trace(haxe.Json.stringify(ic));
        }
    
        r.send();
    }

    /**
        Edit a recent interaction response
        @param ic The content of the message
        @param interactionToken The token of the interaction you wanna edit
    **/

    public static function editInteractionResponse(ic:hxdiscord.types.Typedefs.InteractionCallback, interactionToken:String)
    {
        var url:String = "https://discord.com/api/v"+Gateway.API_VERSION+"/webhooks/" + DiscordClient.accountId + "/" + interactionToken + "/messages/@original";
        var req:Http = new Http(url);
        var responseBytes = new BytesOutput();
        var error:Bool = false;
    
        req.setPostData(Json.stringify(ic));
        req.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
        req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", DiscordClient.authHeader);
        req.setMethod("PATCH");
    
        req.onError = function(err:String) {
            trace("An error has occurred: " + err);
            error = true;
        };
        
        req.onStatus = function(status:Int) {
            if (DiscordClient.debug)
            {
                trace(status);
            }
        };
    
        req.send();
        if (error)
        { 
            trace(req.responseData); 
        }
        return Json.parse(req.responseData);
    }
}