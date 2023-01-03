package hxdiscord.types.structTypes;

typedef InteractionS = {
    var username:String;
    var public_flags:Int;
    var id:String;
    var discriminator:String;
    var avatar_decoration:Dynamic;
    var avatar:String;
    var member:Member;
    var channel_id:String;
    var name:String;
    var intId:String;
    var options:Array<Dynamic>;
    var type:Int;
    var data:InteractionData;
    var token:String;
}

typedef InteractionResolvedData = {
    @:optional var users:Array<User>;
    @:optional var members:Dynamic;
    @:optional var roles:Dynamic;
    @:optional var channels:Dynamic;
    @:optional var messages:Dynamic;
    @:optional var attachments:Array<Attachment>;
}

typedef InteractionData = {
    var id:String;
    var name:String;
    var type:Int;
    var resolved:InteractionResolvedData;
}

typedef User = {
    var username:String;
    var public_flags:Int;
    var id:String;
    var discriminator:String;
    var avatar_decoration:String;
    var avatar:String;
}

typedef Member = {
    var user:User;
    var roles:Array<String>;
    var premium_since:Dynamic;
    var permissions:String;
    var pending:Bool;
    var nick:String;
    var mute:Bool;
    var joined_at:String;
    var is_pending:Bool;
    var flags:Int;
    var deaf:Bool;
    var communication_disabled_until:Dynamic;
    var avatar:Dynamic;
}