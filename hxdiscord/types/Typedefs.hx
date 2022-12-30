package hxdiscord.types;

import hxdiscord.types.structTypes.*;

typedef MessageCreate = {
    @:optional var content:String;
    @:optional var embeds:Array<Embed>;
    @:optional var nonce:Int;
    @:optional var tts:Bool;
    @:optional var file:String;
    @:optional var message_reference:Any;
}

typedef ComponentArray = {
    var type:Int;
    var style:Int;
    @:optional var label:String;
    @:optional var emoji:Dynamic;
    @:optional var custom_id:String;
    @:optional var url:String;
    @:optional var disabled:Bool;
}

typedef Component = {
    var type:Int;
    var components:Array<ComponentArray>;
}

typedef InteractionCallback = {
    @:optional var tts:Bool;
    @:optional var content:String;
    @:optional var embeds:Array<Embed>;
    @:optional var allowed_mentions:Any;
    @:optional var flags:Int;
    @:optional var components:Array<Component>;
    @:optional var attachments:Array<Dynamic>;
}