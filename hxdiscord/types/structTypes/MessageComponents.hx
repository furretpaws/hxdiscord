package hxdiscord.types.structTypes;

import hxdiscord.types.structTypes.Emoji;

typedef ButtonObject = {
    var type:Int;
    var style:Int;
    @:optional var label:String;
    @:optional var emoji:Emoji;
    @:optional var custom_id:String;
    @:optional var url:String;
    @:optional var disabled:Bool;
}

typedef SelectOptionStructure = {
    var label:String;
    var value:String;
    @:optional var description:String;
    @:optional var emoji:Emoji;
}