package hxdiscord.types.structTypes;

typedef WelcomeScreen = {
    @:optional var description:String;
    var welcome_channels:Array<WelcomeChannels>;
}

typedef WelcomeChannels = {
    var channel_id:String;
    var description:String;
    var emoji_id:String;
    var emoji_name:String;
}