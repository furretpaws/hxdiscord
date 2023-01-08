package hxdiscord.types.structTypes;

typedef GuildMember = {
    var guild_id:String;
    @:optional var roles:Array<String>;
    @:optional var premium_since:Bool;
    @:optional var pending:Bool;
    @:optional var nick:String;
    @:optional var mute:Bool;
    @:optional var joined_at:Bool;
    @:optional var flags:Int;
    @:optional var deaf:Bool;
    @:optional var communication_disabled_until:Bool;
    @:optional var avatar:Dynamic;
}