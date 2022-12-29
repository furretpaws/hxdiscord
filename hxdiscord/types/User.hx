package hxdiscord.types;

import hxdiscord.DiscordClient;
import hxdiscord.types.structTypes.UserS;

class User
{
    var discordClient:DiscordClient;
    
    public var username:String;
    public var public_flags:Int;
    public var id:String;
    public var discriminator:String;
    public var avatar_decoration:Dynamic;
    public var avatar:String;

    public function new (bot:DiscordClient)
    {
        
    }
}