package hxdiscord.types;

import hxdiscord.DiscordClient;
import hxdiscord.types.structTypes.*;
import hxdiscord.endpoints.Endpoints;

class Message
{
    public var type:Int;
    public var tts:Bool;
    public var timestamp:String;
    public var referenced_message:Dynamic;
    public var pinned:Bool;
    public var id:String;
    public var channel_id:String;
    public var authorUsername:String;
    public var authorId:String;
    public var content:String;
    public var mention_everyone:Bool;

    var client:DiscordClient;

    public function new(ms:MessageS, _client:DiscordClient)
    {
        client = _client;
        //trace(ms.username);
        type = ms.type;
        tts = ms.tts;
        timestamp = ms.timestamp;
        //referenced_message = ms.referenced_message;
        pinned = ms.pinned;
        id = ms.id;
        channel_id = ms.channel_id;
        //authorUsername = ms.username;
        content = ms.content;
        mention_everyone = ms.mention_everyone;
    }

    public function reply(content:String, ?ping:Bool)
    {
        if (ping!=null)
        {
            Endpoints.sendMessage(content, ping, channel_id, id);
        }
        else
        {
            Endpoints.sendMessage(content, false, channel_id, id);
        }
    }

    public function replyData(data:Dynamic) //this will save a lot of time honestly
    {
        Endpoints.sendDataToMessageAPI(data, channel_id);
    }
}