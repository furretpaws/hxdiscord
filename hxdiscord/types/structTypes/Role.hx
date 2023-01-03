package hxdiscord.types.structTypes;

typedef Role = {
    var id:String;
    var name:String;
    var color:Int;
    var hoist:Bool;
    @:optional var icon:String;
    @:optional var unicode_emoji:String;
    var position:Int;
    var permissions:String;
    var managed:Bool;
    var mentionable:Bool;
    var tags:RoleTags;
}

typedef RoleTags = {
    @:optional var bot_id:String;
    @:optional var integration_id:String;
    @:optional var premium_subscriber:Any;
}