package hxdiscord.types;

import hxdiscord.DiscordClient;
import hxdiscord.types.structTypes.*;
import hxdiscord.types.structTypes.MessageS;
import hxdiscord.types.Typedefs;
import hxdiscord.endpoints.Endpoints;

class Message
{
    public var type:Int;
    public var tts:Bool;
    public var timestamp:String;
    public var pinned:Bool;
    public var id:String;
    public var channel_id:String;
    public var author:User;
    public var guildmember:GuildMember;
    public var referenced_message:MessageS;
    public var message_reference:MessageReference;
    public var guild_id:String;
    public var content:String;
    public var embed:Embed;
    public var mention_everyone:Bool;

    var client:DiscordClient;

    public function new(ms:MessageS, _client:DiscordClient)
    {
        client = _client;
        //trace(ms.username);
        type = ms.type;
        tts = ms.tts;
        timestamp = ms.timestamp; 
        referenced_message = ms.referenced_message;
        message_reference = ms.message_reference;
        pinned = ms.pinned;
        id = ms.id;
        channel_id = ms.channel_id;
        //authorUsername = ms.username;
        content = ms.content;
        mention_everyone = ms.mention_everyone;
        guildmember = ms.member;
        guild_id = ms.guild_id;
    }

    public function reply(mc:hxdiscord.types.Typedefs.MessageCreate, ?ping:Bool)
    {
        Endpoints.sendMessage(channel_id, mc, id, ping);
    }

    public function replyData(data:Dynamic) //this will save a lot of time honestly
    {
        Endpoints.sendDataToMessageAPI(data, channel_id);
    }

    public function hasPermission(permissionToLookFor:String):Bool
    {
        var hasPermission = false;
        if (guildmember == null)
        {
            //do nothing
        }
        else
        {
            var guild = hxdiscord.endpoints.Endpoints.getGuild(guild_id);
            var owner = hxdiscord.endpoints.Endpoints.getUser(guild.owner_id);

            if (author.id == owner.id)
            {
                hasPermission = true;
            }
            else
            {
                var r = new haxe.Http("https://discord.com/api/v10/guilds/"+guild_id+"/members/" + author.id);
                //LLL
                r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
                r.addHeader("Authorization", "Bot " + DiscordClient.token);


		        r.onData = function(dataG:String)
		        {
                    var data = Endpoints.getRoles(guild_id);
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
		        }

		        r.request();
            }
        }
        return hasPermission;
    }
}