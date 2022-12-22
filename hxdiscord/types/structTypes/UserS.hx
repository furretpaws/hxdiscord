package hxdiscord.types.structTypes;

typedef UserS = {
    var id:String;
    @:optional var username:String;
    @:optional var discriminator:String;
    @:optional var avatar:String;
    @:optional var bot:Bool;
    @:optional var mfa_enabled:Bool;

    @:optional var verified:Bool;
    @:optional var email:String;
    @:optional var flags:Int;
    @:optional var premium_type:Int;

    @:optional var guild_id:String;
}