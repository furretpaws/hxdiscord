package hxdiscord.types.structTypes;

typedef ApplicationCommand = {
    var type:hxdiscord.types.CommandType;
    var name:String;
    @:optional var name_localizations:Dynamic;
    var description:String;
    @:optional var description_localizations:Dynamic;
    @:optional var required:Bool;
    @:optional var options:Dynamic;
    @:optional var default_member_permission:String;
    @:optional var dm_permission:Bool;
    @:optional var default_permission:Bool;
    @:optional var nsfw:Bool;
    var version:String;
}

typedef ApplicationCommandOptionChoice = {
    var name:String;
    @:optional var name_localizations:Dynamic;
    var value:Dynamic;
}

typedef ApplicationCommandOption = {
    var type:hxdiscord.types.CommandType;
    var name:String;
    @:optional var name_localizations:Dynamic;
    var description:String;
    @:optional var description_localizations:Dynamic;
    @:optional var required:Bool;
    @:optional var choices:Array<ApplicationCommandOptionChoice>;
    @:optional var options:Array<ApplicationCommandOption>;
    @:optional var channel_types:Array<Int>;
    @:optional var min_value:Dynamic;
    @:optional var max_value:Dynamic;
    @:optional var min_length:Int;
    @:optional var max_length:Int;
    @:optional var autocomplete:Bool;
}