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

typedef InteractionCallback = {
    @:optional var tts:Bool;
    @:optional var content:String;
    @:optional var embeds:Array<Embed>;
    @:optional var allowed_mentions:Any;
    @:optional var flags:Int;
    @:optional var components:Array<Dynamic>;
    @:optional var attachments:Array<Dynamic>;
}