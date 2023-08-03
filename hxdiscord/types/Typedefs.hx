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
    @:optional var allowed_mentions:Dynamic;
}

typedef AuditLogChangeStructure = {
    new_value:Dynamic,
    old_value:Dynamic,
    key:String
}

typedef OptionalAuditEntryInfo = {
    application_id:String,
    auto_moderation_rule_name:String,
    auto_moderation_rule_trigger_type:String,
    channel_id:String,
    count:String,
    delete_member_days:String,
    id:String,
    members_removed:String,
    message_id:String,
    role_name:String,
    type:String
}

typedef AuditLogEntryStructure = {
    target_id:String,
    ?changes:Array<AuditLogChangeStructure>,
    user_id:String,
    id:String,
    action_type:Int,
    options:OptionalAuditEntryInfo,
    reason:String
}

typedef GuildBanAddEventFields = {
    guild_id:String,
    user:hxdiscord.types.structTypes.UserS
}

typedef GuildBanRemoveEventFields = {
    guild_id:String,
    user:hxdiscord.types.structTypes.UserS
}

typedef GuildMemberAdd = {
    guild_id:String
}

typedef GuildMemberRemove = {
    guild_id:String,
    user:hxdiscord.types.structTypes.UserS
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

typedef ThreadMemberUpdate = {
    guild_id:String
}

typedef ThreadMembersUpdate = {
    id:String,
    guild_id:String,
    member_count:Int,
    ?added_members:Array<ThreadMemberObject>,
    removed_member_ids:Array<String>
}

typedef ThreadMemberObject = {
    ?id:String,
    ?user_id:String,
    join_timestamp:String,
    flags:Int,
    ?member:hxdiscord.types.structTypes.GuildMember
}

typedef GuildCreate = {
    joined_at:String,
    large:Bool,
    ?unavailable:Bool,
    member_count:Int,
    voice_states:Array<Dynamic>,
    members:Array<hxdiscord.types.structTypes.GuildMember>,
    channels:Array<Channel>,
    threads:Array<Channel>,
    presences:Array<Dynamic>,
    stage_instances:Array<Dynamic>,
    guild_scheduled_events:Array<Dynamic>
}

typedef ComponentArray = {
    var type:Int;
    var style:Int;
    @:optional var name:String;
    @:optional var value:String;
    @:optional var components:Array<ComponentArray>;
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
    @:optional var custom_id:String;
    @:optional var title:String;
    @:optional var type:Int;
    @:optional var content:String;
    @:optional var embeds:Array<Embed>;
    @:optional var allowed_mentions:Any;
    @:optional var flags:Int;
    @:optional var components:Array<Dynamic>;
    @:optional var attachments:Array<Dynamic>;
}

typedef ChannelInvite = {
    var max_age:Int;
    var max_uses:Int;
    var temporary:Bool;
    var unique:Bool;
    var target_type:Int;
    var target_user_id:String;
    var target_application_id:String;
}

typedef ModifyGuildMemberParams = {
    @:optional var nick:String;
    @:optional var roles:Array<String>;
    @:optional var mute:Bool;
    @:optional var deaf:Bool;
    @:optional var channel_id:String;
    @:optional var communication_disabled_until:String;
    @:optional var flags:Int;
}

typedef ApplicationCommandPermissionsUpdate = {
    var guild_id:String;
    var action:Dynamic;
    var rule_id:String;
    var rule_trigger_type:Dynamic;
    var user_id:String;
    @:optional var channel_id:String;
    @:optional var message_id:String;
    @:optional var alert_system_message_id:String;
    @:optional var content:String;
    @:optional var matched_keyword:String;
    @:optional var matched_content:String;
}

typedef Channel = {
    var id:String;
    var type:Int;
    @:optional var guild_id:String;
    @:optional var position:Int;
    @:optional var permission_overwrites:Array<Dynamic>;
    @:optional var name:String;
    @:optional var topic:String;
    @:optional var nsfw:Bool;
    @:optional var last_message_id:String;
    @:optional var bitrate:Int;
    @:optional var user_limit:Int;
    @:optional var rate_limit_per_user:Int;
}