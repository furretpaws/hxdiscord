package hxdiscord.types.structTypes;

typedef EmbedFooter = {
    var text:String;
    @:optional var icon_url:String;
    @:optional var proxy_icon_url:String;
}

typedef EmbedImage = {
    var url:String;
    @:optional var proxy_url:String;
    @:optional var height:Int;
    @:optional var width:Int;
}

typedef EmbedThumbnail = {
    var url:String;
    @:optional var proxy_url:String;
    @:optional var height:Int;
    @:optional var width:Int;
}

typedef EmbedVideo = {
    @:optional var url:String;
    @:optional var proxy_url:String;
    @:optional var height:Int;
    @:optional var width:Int;
}

typedef EmbedProvider = {
    @:optional var name:String;
    @:optional var url:String;
}

typedef EmbedAuthor = {
    var name:String;
    @:optional var url:String;
    @:optional var icon_url:String;
    @:optional var proxy_icon_url:String;
}

typedef EmbedField = {
    var name:String;
    @:optional var url:String;
    var value:String;
    @:optional @:native("inline") var _inline:Bool;
}

typedef Embed = {
    @:optional var title:String;
    @:optional var type:String;
    @:optional var description:String;
    @:optional var url:String;
    @:optional var timestamp:String;
    @:optional var color:Int;
    @:optional var footer:EmbedFooter;
    @:optional var image:EmbedImage;
    @:optional var thumbnail:EmbedThumbnail;
    @:optional var video:EmbedVideo;
    @:optional var provider:EmbedProvider;
    @:optional var author:EmbedAuthor;
    @:optional var fields:Array<EmbedField>;
}