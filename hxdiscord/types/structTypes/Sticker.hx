package hxdiscord.types.structTypes;

typedef Sticker = {
    var id:String;
    @:optional var pack_id:String;
    var name:String;
    @:optional var description:String;
    var tags:String;
    var asset:String;
    var type:Int;
    var format_type:Int;
    @:optional var available:Bool;
    @:optional var guild_id:String;
    @:optional var user:User;
    @:optional var sort_value:Int;
}