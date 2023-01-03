package hxdiscord.types;

class Attachment 
{
    public var id:String;
    public var filename:String;
    public var description:String;
    public var content_type:String;
    public var size:Int;
    public var url:String;
    public var proxy_url:String;
    public var height:Int;
    public var width:Int;
    public var ephemeral:Bool;

    public function new(as:hxdiscord.types.structTypes.Attachment, _client:hxdiscord.DiscordClient)
    {
        id = as.id;
        filename = as.filename;
        description = as.description;
        content_type = as.content_type;
        size = as.size;
        url = as.url;
        proxy_url = as.proxy_url;
        height = as.height;
        width = as.width;
        ephemeral = as.ephemeral;
    }
}