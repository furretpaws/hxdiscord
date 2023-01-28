package hxdiscord.types;

class Embed{
    private var title:String;
    private var type:String;
    private var description:String;
    private var url:String;
    private var timestamp:Date;
    private var color:Int;
    private var footer:hxdiscord.types.structTypes.Embed.EmbedFooter;
    private var image:hxdiscord.types.structTypes.Embed.EmbedImage;
    private var thumbnail:hxdiscord.types.structTypes.Embed.EmbedThumbnail;
    private var video:hxdiscord.types.structTypes.Embed.EmbedVideo;
    private var provider:hxdiscord.types.structTypes.Embed.EmbedProvider;
    private var author:hxdiscord.types.structTypes.Embed.EmbedAuthor;
    private var fields:Array<hxdiscord.types.structTypes.Embed.EmbedField>;

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