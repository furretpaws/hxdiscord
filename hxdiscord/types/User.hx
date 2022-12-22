package hxdiscord.types;

import hxdiscord.DiscordClient;

class User
{
    var discordClient:DiscordClient;
    public var id:Int;
    public var tag:String;
    public var username:String;
    public var discriminator:String;
    public var avatar:String;
    public var avatarUrl:String;
    public var bot:Bool;
    public var mfa_enabled:Bool;
    public var verified:Bool;
    public var email:String;
    public var flags:Int;
    public var premium_type:Int;
}