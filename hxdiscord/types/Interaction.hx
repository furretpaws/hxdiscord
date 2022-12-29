package hxdiscord.types;

import hxdiscord.DiscordClient;
import hxdiscord.types.structTypes.*;
import hxdiscord.endpoints.Endpoints;

class Interaction
{
    public var username:String;
    public var public_flags:Int;
    public var id:String;
    public var discriminator:String;
    public var avatar_decoration:Dynamic;
    public var avatar:String;
    public var channel_id:String;
    public var name:String;
    public var intId:String;
    public var options:Array<Dynamic>;
    public var data:Dynamic;
    public var type:Int;
    public var token:String;

    public function new(ins:InteractionS, _client:DiscordClient)
    {
        username = ins.username;
        public_flags = ins.public_flags;
        id = ins.id;
        discriminator = ins.discriminator;
        avatar_decoration = ins.avatar_decoration;
        avatar = ins.avatar;
        channel_id = ins.channel_id;
        name = ins.name;
        intId = ins.intId;
        options = ins.options;
        type = ins.type;
        token = ins.token;
        data = this.options[0];
        trace(this.options);
    }

    public function reply(content:String, ?ephemeral:Bool = false)
    {
        /*trace(intId);
        trace(token);*/
        Endpoints.sendInteractionCallback(content, intId, token, type, true);
    }

    public function replyData(data:Dynamic)
    {
        Endpoints.sendDataToInteraction(data, intId, token, type);
    }

    public function getValue(optionName:String)
    {
        var daThing:Dynamic = optionName;

        for (int in this.options)
        {
            if (int.name == optionName)
            {
                daThing = int.value;
            }
        }
        return daThing;
    }
}