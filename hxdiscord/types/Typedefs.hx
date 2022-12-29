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