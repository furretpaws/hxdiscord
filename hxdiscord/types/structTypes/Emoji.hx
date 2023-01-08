package hxdiscord.types.structTypes;

typedef Emoji = {
    var id:String;
    var name:String;
    @:optional var roles:Array<String>;
    @:optional var user:User;
    @:optional var require_colons:Bool;
    @:optional var managed:Bool;
    @:optional var animated:Bool;
    @:optional var available:Bool; 
}