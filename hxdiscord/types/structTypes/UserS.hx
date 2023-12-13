package hxdiscord.types.structTypes;

typedef UserS = {
    var id:String;
    @:optional var username:String;
    @:optional var public_flags:Int;
    @:optional var discriminator:String;
    @:optional var avatar_decoration:Dynamic;
    @:optional var avatar:String;
    @:optional var banner:String;
    @:optional var bot:Bool;
    @:optional var system:Bool;
    @:optional var mfa_enabled:Bool;
    @:optional var accent_color:Int;
    @:optional var global_name:String;
    @:optional var locale:String;
    @:optional var verified:Bool;
    @:optional var email:String;
    @:optional var flags:Int;
    @:optional var username_f:String;
    @:optional var premium_type:Int;
}
