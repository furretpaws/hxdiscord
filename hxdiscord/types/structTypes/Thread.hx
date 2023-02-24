package hxdiscord.types.structTypes;

typedef FromMessage = {
    var name:String;
    var auto_archive_duration:Int;
    @:optional var rate_limit_per_user:Int;
}

typedef WithoutMessage = {
    var name:String;
    var auto_archive_duration:Int;
    @:optional var type:Int;
    @:optional var invitable:Bool;
    @:optional var rate_limit_per_user:Int;
}

typedef ForumChannel = {
    var name:String;
    @:optional var auto_archive_duration:Int;
    @:optional var rate_limit_per_user:Int;
    var message:Typedefs.MessageCreate; //highly doubt this would work but still why should we not try it? lmao
    @:optional var applied_tags:Array<String>;
}