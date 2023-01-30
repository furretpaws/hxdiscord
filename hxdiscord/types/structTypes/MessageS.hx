package hxdiscord.types.structTypes;

typedef MessageS = {
    var id:String;
    var channel_id:String;
    @:optional var author:User;
    @:optional var content:String;
    @:optional var timestamp:String;
    @:optional var edited_timestamp:String;
    @:optional var tts:Bool;
    @:optional var mention_everyone:Bool;
    @:optional var mentions:Array<UserS>;
    @:optional var mention_roles:Array<String>;
    @:optional var member:GuildMember;
    var guild_id:String;
    @:optional var attachments:Array<Attachment>;
    @:optional var referenced_message:MessageS;
    @:optional var message_reference:MessageReference;
    @:optional var embeds:Array<Embed>;
    //@:optional var reactions:Array<Reaction>;
    @:optional var nonce:String;
    @:optional var pinned:Bool;
    @:optional var webhook_id:String;
    @:optional var type:Int;
    /*@:optional var activity:MessageActivity;
    @:optional var application:MessageApplication;*/
}

typedef MessageReference = {
    @:optional var message_id:String;
    @:optional var channel_id:String;
    @:optional var guild_id:String;
    @:optional var fail_if_not_exists:Bool;
}