package hxdiscord.types.structTypes;

typedef UserS = {
    var id:String;

    @:optional var username:String;
    @:optional var public_flags:Int;
    @:optional var discriminator:String;
    @:optional var avatar_decoration:Dynamic;
    @:optional var avatar:String;
}