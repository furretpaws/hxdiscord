package hxdiscord.types.structTypes;

typedef Attachment = {
    var id:String;
    var filename:String;
    @:optional var description:String;
    @:optional var content_type:String;
    var size:Int;
    var url:String;
    var proxy_url:String;
    @:optional var height:Int;
    @:optional var width:Int;
    @:optional var ephemeral:Bool;
}