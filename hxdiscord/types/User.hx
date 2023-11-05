package hxdiscord.types;

import hxdiscord.DiscordClient;
import hxdiscord.types.structTypes.UserS;

class User
{
    public var id:String;
    public var username:String;
    public var public_flags:Int;
    public var discriminator:String;
    public var avatar_decoration:String;
    public var avatar:String;
    public var banner:String;
    public var bot:Bool;
    public var system:Bool;
    public var mfa_enabled:Bool;
    public var accent_color:Int;
    public var locale:String;
    public var username_f:String; //Stands for formatted username
    public var verified:Bool;
    public var email:String;
    public var flags:Int;
    public var premium_type:Int;

    public function new (?client:hxdiscord.DiscordClient, us:UserS)
    {
        id = us.id;
        username = us.username;
        public_flags = us.public_flags;
        discriminator = us.discriminator;
        avatar_decoration = us.avatar_decoration;
        avatar = us.avatar;
        banner = us.banner;
        bot = us.bot;
        system = us.system;
        mfa_enabled = us.mfa_enabled;
        accent_color = us.accent_color;
        locale = us.locale;
        verified = us.verified;
        email = us.email;
        flags = us.flags;
        premium_type = us.premium_type;
        public_flags = us.public_flags;
        /**
            Discord I fucking hate you for adding pomelo
        **/
        if (this.discriminator == "0") {
            username_f = username;
        } else {
            username_f = '${username}#${discriminator}';
        }
    }
}
