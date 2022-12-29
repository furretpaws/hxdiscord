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
    /*@:optional var attachments:Array<Attachment>;
    @:optional var embeds:Array<Embed>;
    @:optional var reactions:Array<Reaction>;*/
    @:optional var nonce:String;
    @:optional var pinned:Bool;
    @:optional var webhook_id:String;
    @:optional var type:Int;
    /*@:optional var activity:MessageActivity;
    @:optional var application:MessageApplication;*/
}