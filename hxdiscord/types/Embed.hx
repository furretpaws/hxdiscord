package hxdiscord.types;

class Embed{
    public var title:String;
    public var type:String;
    public var description:String;
    public var url:String;
    public var timestamp:Date;
    public var color:Int;
    public var footer:hxdiscord.types.structTypes.Embed.EmbedFooter;
    public var image:hxdiscord.types.structTypes.Embed.EmbedImage;
    public var thumbnail:hxdiscord.types.structTypes.Embed.EmbedThumbnail;
    public var video:hxdiscord.types.structTypes.Embed.EmbedVideo;
    public var provider:hxdiscord.types.structTypes.Embed.EmbedProvider;
    public var author:hxdiscord.types.structTypes.Embed.EmbedAuthor;
    public var fields:Array<hxdiscord.types.structTypes.Embed.EmbedField>;

    public var json:hxdiscord.types.structTypes.Embed;

    public function new()
    {

    }

    public function setTitle(title:String)
    {
        this.title = title;
    }

    public function setType(type:String)
    {
        this.type = type;
    }
    
    public function setDescription(description:String)
    {
        this.description = description;
    }

    public function setUrl(url:String)
    {
        this.url = url;
    }

    public function setTimestamp(timestamp:Date)
    {
        this.timestamp = timestamp;
    }

    public function setColor(color:Int)
    {
        this.color = color;
    }
    
    public function setFooter(footer:hxdiscord.types.structTypes.Embed.EmbedFooter)
    {
        this.footer = footer;
    }

    public function setImage(image:hxdiscord.types.structTypes.Embed.EmbedImage)
    {
        this.image = image;
    }
    
    public function setThumbnail(thumbnail:hxdiscord.types.structTypes.Embed.EmbedThumbnail)
    {
        this.thumbnail = thumbnail;
    }

    public function setVideo(video:hxdiscord.types.structTypes.Embed.EmbedVideo)
    {
        this.video = video;
    }

    public function setProvider(provider:hxdiscord.types.structTypes.Embed.EmbedProvider)
    {
        this.provider = provider;
    }

    public function setAuthor(author:hxdiscord.types.structTypes.Embed.EmbedAuthor)
    {
        this.author = author;
    }

    public function addFields(fields:hxdiscord.types.structTypes.Embed.EmbedField)
    {
        this.fields.push(fields);
    }
}