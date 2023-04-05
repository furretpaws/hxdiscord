package hxdiscord.types;

class Embed{
    public var title:String;
    public var type:String;
    public var description:String;
    public var url:String;
    public var timestamp:String;
    public var color:Int;
    public var footer:hxdiscord.types.structTypes.Embed.EmbedFooter;
    public var image:hxdiscord.types.structTypes.Embed.EmbedImage;
    public var thumbnail:hxdiscord.types.structTypes.Embed.EmbedThumbnail;
    public var video:hxdiscord.types.structTypes.Embed.EmbedVideo;
    public var provider:hxdiscord.types.structTypes.Embed.EmbedProvider;
    public var author:hxdiscord.types.structTypes.Embed.EmbedAuthor;
    public var fields:Array<hxdiscord.types.structTypes.Embed.EmbedField>;

    /**
        Constructor
    **/

    public function new()
    {
        fields = new Array<hxdiscord.types.structTypes.Embed.EmbedField>();
    }

    /**
        Sets a title for the embed
        @param title Title
    **/
    public function setTitle(title:String)
    {
        this.title = title;
    }

    /**
        Sets the embed type
        @param type
    **/
    public function setType(type:String)
    {
        this.type = type;
    }
    
    /**
        Sets an embed description
        @param description The description 
    **/
    public function setDescription(description:String)
    {
        this.description = description;
    }

    /**
        Sets a URL to the embed
        @param url The URL
    **/
    public function setUrl(url:String)
    {
        this.url = url;
    }

    /**
        Sets the timestamp to the embed (ISO8601 ONLY)
        @param timestamp The ISO8601 timestamp
    **/
    public function setTimestamp(timestamp:String)
    {
        this.timestamp = timestamp;
    }

    /**
        Sets the color embed
        @param color The color (integer based)
    **/
    public function setColor(color:Int)
    {
        this.color = color;
    }
    
    /**
        Sets a footer to the embed
        @param footer The footer object
    **/
    public function setFooter(footer:hxdiscord.types.structTypes.Embed.EmbedFooter)
    {
        this.footer = footer;
    }

    /**
        Sets an image
        @param image The image object
    **/
    public function setImage(image:hxdiscord.types.structTypes.Embed.EmbedImage)
    {
        this.image = image;
    }
    
    /**
        Sets a thumbnail
        @param thumbnail The thumbnail object
    **/
    public function setThumbnail(thumbnail:hxdiscord.types.structTypes.Embed.EmbedThumbnail)
    {
        this.thumbnail = thumbnail;
    }

    /**
        Sets an embed video
        @param video The video object
    **/
    public function setVideo(video:hxdiscord.types.structTypes.Embed.EmbedVideo)
    {
        this.video = video;
    }

    /**
        Sets an embed provider
        @param provider The provider object
    **/
    public function setProvider(provider:hxdiscord.types.structTypes.Embed.EmbedProvider)
    {
        this.provider = provider;
    }

    /**
        Sets an embed author
        @param author The author object
    **/
    public function setAuthor(author:hxdiscord.types.structTypes.Embed.EmbedAuthor)
    {
        this.author = author;
    }

    /**
        Adds a field to the embed
        @param fields The field object
    **/
    public function addFields(fields:hxdiscord.types.structTypes.Embed.EmbedField)
    {
        this.fields.push(fields);
    }
}