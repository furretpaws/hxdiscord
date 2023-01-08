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
}