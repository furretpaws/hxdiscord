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
    public var user:UserS;
    public var channel_id:String;
    public var name:String;
    public var member:hxdiscord.types.structTypes.InteractionS.Member;
    public var intId:String;
    public var guild_id:String;
    public var components:Array<Dynamic>;
    public var options:Array<Dynamic>;
    public var dataOptions:Dynamic;
    public var type:Int;
    public var token:String;
    public var data:hxdiscord.types.structTypes.InteractionS.InteractionData;

    public function new(ins:InteractionS, _client:DiscordClient, parsedJSON:Dynamic)
    {
        username = ins.username;
        public_flags = ins.public_flags;
        id = ins.id;
        discriminator = ins.discriminator;
        avatar_decoration = ins.avatar_decoration;
        user = ins.user;
        member = ins.member;
        avatar = ins.avatar;
        channel_id = ins.channel_id;
        guild_id = ins.guild_id;
        name = ins.name;
        intId = ins.intId;
        components = ins.components;
        options = ins.options;
        type = ins.type;
        token = ins.token;
        data = ins.data;

        if (this.options != null)
        {
            dataOptions = this.options[0];
        }
        else
        {
            dataOptions = {
                type: 3,
                name: "no_options",
                value: "no_options"
            };
        }
    }

    public function reply(ic:hxdiscord.types.Typedefs.InteractionCallback, ?ephemeral:Bool)
    {
        Endpoints.sendInteractionCallback(ic, intId, token, type, ephemeral);
    }

    public function showModal(title:String, custom_id:String, imc:Array<hxdiscord.types.message.ActionRow>)
    {
        Endpoints.showInteractionModal(imc, intId, token, type, title, custom_id);
    }

    public function getValue(optionName:String):Dynamic
    {
        var daThing:Dynamic = "optionName";

        if (this.options != null)
        {
            for (int in this.options)
            {
                if (int.name == optionName)
                {
                    daThing = int.value;
                }
            }
        }
        else
        {
            daThing = null;
        }
        return daThing;
    }

    public function edit(ic:Typedefs.InteractionCallback)
    {
        Endpoints.editInteractionResponse(ic, token);
    }
}