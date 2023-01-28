package hxdiscord.types;

import hxdiscord.types.structTypes.*;

typedef MessageCreate = {
    @:optional var content:String;
    @:optional var embeds:Array<Embed>;
    @:optional var nonce:Int;
    @:optional var tts:Bool;
    @:optional var components:Dynamic;
    @:optional var file:String;
    @:optional var message_reference:Any;
    @:optional var attachments:Array<Dynamic>;
}

typedef ModifyGuildParams = {
    @:optional var name:String;
    @:optional var region:String;
    @:optional var verification_level:String;
    @:optional var default_message_notifications:Int;
    @:optional var explicit_content_filter:String;
    @:optional var afk_channel_id:String;
    @:optional var afk_timeout:String;
    @:optional var owner_id:String;
    @:optional var system_channel_id:String;
    @:optional var system_channel_flags:String;
    @:optional var rules_channel_id:String;
    @:optional var public_updates_channel_id:String;
    @:optional var preferred_locale:String;
    @:optional var features:Array<String>;
    @:optional var description:String;
    @:optional var premium_progress_bar_enabled:Bool;
}

typedef ModifyGuildRoleParams = {
    @:optional var name:String;
    @:optional var permissions:String;
    @:optional var color:Int;
    @:optional var hoist:Bool;
    @:optional var icon:Dynamic;
    @:optional var unicode_emoji:String;
    @:optional var mentionable:Bool;
}

typedef ComponentArray = {
    var type:Int;
    var style:Int;
    @:optional var label:String;
    @:optional var emoji:Dynamic;
    @:optional var custom_id:String;
    @:optional var url:String;
    @:optional var disabled:Bool;
}

typedef Component = {
    var type:Int;
    var components:Array<ComponentArray>;
}

typedef InteractionCallback = {
    @:optional var tts:Bool;
    @:optional var content:String;
    @:optional var embeds:Array<Embed>;
    @:optional var allowed_mentions:Any;
    @:optional var flags:Int;
    @:optional var components:Array<Component>;
    @:optional var attachments:Array<Dynamic>;
}