package hxdiscord.types;

import hxdiscord.DiscordClient;
import hxdiscord.types.structTypes.*;
import hxdiscord.types.structTypes.Thread.FromMessage;
import hxdiscord.types.structTypes.MessageS;
import hxdiscord.types.Typedefs;
import hxdiscord.endpoints.Endpoints;
import hxdiscord.gateway.Gateway;

class Message
{
    public var type:Int;
    public var tts:Bool;
    public var timestamp:String;
    public var pinned:Bool;
    public var id:String;
    public var channel_id:String;
    public var attachments:Array<Attachment>;
    public var author:User;
    public var guildmember:GuildMember;
    public var referenced_message:MessageS;
    public var embeds:Array<Embed>;
    public var message_reference:MessageReference;
    public var guild_id:String;
    public var content:String;
    public var embed:Embed;
    public var mention_everyone:Bool;

    var client:DiscordClient;

    var prevSentMessage:Message = null;

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
        embeds = ms.embeds;
        //authorUsername = ms.username;
        attachments = ms.attachments;
        content = ms.content;
        mention_everyone = ms.mention_everyone;
        guildmember = ms.member;
        guild_id = ms.guild_id;
    }

    public function send(mc:hxdiscord.types.Typedefs.MessageCreate)
    {
        try {
            var id:String = haxe.Json.parse(Endpoints.createDM(author.id)).id;
            Endpoints.sendMessage(id, mc, null, false);
        } catch (err) {
            trace("An error has occurred: " + err);
        }
    }

    public function reply(mc:hxdiscord.types.Typedefs.MessageCreate, ?ping:Bool)
    {
        prevSentMessage = new Message(Endpoints.sendMessage(channel_id, mc, id, ping), client);
    }

    public function replyData(data:Dynamic) //this will save a lot of time honestly
    {
        Endpoints.sendDataToMessageAPI(data, channel_id);
    }

    public function react(emoji:String)
    {
        Endpoints.createReaction(channel_id, id, emoji);
    }

    public function deleteOwnReaction(emoji:String)
    {
        Endpoints.deleteOwnReaction(channel_id, id, emoji);
    }

    public function deleteReactions()
    {
        Endpoints.deleteAllReactions(channel_id, id);
    }

    public function deleteEmojiReaction(emoji:String)
    {
        Endpoints.deleteAllReactionsForEmoji(channel_id, id, emoji);
    }

    public function deleteMessage()
    {
        Endpoints.deleteMessage(channel_id, id);
    }

    public function pin()
    {
        Endpoints.pinMessage(channel_id, id);
    }

    public function pinMessage()
    {
        Endpoints.pinMessage(channel_id, id);
    }

    public function unpin()
    {
        Endpoints.unpinMessage(channel_id, id);
    }

    public function unpinMessage()
    {
        Endpoints.unpinMessage(channel_id, id);
    }

    public function createThread(obj:FromMessage)
    {
        Endpoints.startThreadFromMessage(channel_id, id, obj);
    }
    
    public function editMessage(m:hxdiscord.types.Typedefs.MessageCreate)
    {
        if (prevSentMessage == null)
        {
            trace("Couldn't edit a non-existing message");
        }
        else
        {
            Endpoints.editMessage(channel_id, prevSentMessage.id, m);
        }
    }

    public function hasRole(roleToLookFor:String):Bool
    {
        var hasRole:Bool = false;
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
                hasRole = true;
            }
            else
            {
                var r = new haxe.Http("https://discord.com/api/v"+Gateway.API_VERSION+"/guilds/"+guild_id+"/members/" + author.id);
                //LLL
                r.addHeader("User-Agent", "hxdiscord (https://github.com/FurretDev/hxdiscord)");
                r.addHeader("Authorization", "Bot " + DiscordClient.token);


		        r.onData = function(data:String)
		        {
                    var jsonParse:Dynamic = haxe.Json.parse(data);
                    if (jsonParse.roles.contains(roleToLookFor))
                    {
                        hasRole = true;
                    }
		        }

		        r.onError = function(error)
		        {
		        	trace("An error has occurred: " + error);
		        }

		        r.request();
            }
        }
        return hasRole;
    }

    public function hasPermission(permissionToLookFor:String):Bool
    {
        var hasPermission:Bool = false;
        var member:Member = null;
        @:privateAccess
        for (i in 0...client.cache.guild_members.length) {
            if (client.cache.guild_members[i].user.id == this.author.id && client.cache.guild_members[i].guild_id == this.guild_id) {
                member = client.cache.guild_members[i];
            }
        }
        if (member != null) {
            for (i in 0...member.permissionsBitwise.length) {
                var array:Array<String> = hxdiscord.utils.Permissions.resolve(haxe.Int64.fromFloat(Std.parseFloat(member.permissionsBitwise[i])));
                if (array.contains(permissionToLookFor))
                {
                    hasPermission = true;
                }
            }
        } else {
            //MEMBER NOT CACHED? time to cache it then try again
            @:privateAccess
            client.cache.cacheMemberAndRoles(guild_id, author.id);
            var member:Member = null;
            @:privateAccess
            for (i in 0...client.cache.guild_members.length) {
                if (client.cache.guild_members[i].user.id == this.author.id && client.cache.guild_members[i].guild_id == this.guild_id) {
                    member = client.cache.guild_members[i];
                }
            }
            for (i in 0...member.permissionsBitwise.length) {
                var array:Array<String> = hxdiscord.utils.Permissions.resolve(haxe.Int64.fromFloat(Std.parseFloat(member.permissionsBitwise[i])));
                if (array.contains(permissionToLookFor))
                {
                    hasPermission = true;
                }
            }
        }
        /*var hasPermission:Bool = false;
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
                hasPermission = Endpoints.hasPermission(author.id, guild_id, permissionToLookFor);
            }
        }
        return hasPermission;*/
        return hasPermission;
    }

    public function getMember():Member {
        var member:Member = null;
        hxdiscord.endpoints.Endpoints.getGuildMember(guild_id, author.id, (m) -> {member = m;}, null);
        return member;
    }
}