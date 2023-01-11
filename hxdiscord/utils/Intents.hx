package hxdiscord.utils;

enum abstract Intents(Int) from Int to Int {
    final GUILDS:Int = 1 << 0;
    final GUILD_MEMBERS:Int = 1 << 1;
    final GUILD_BANS:Int = 1 << 2;
    final GUILD_EMOJIS_AND_STICKERS:Int = 1 << 3;
    final GUILD_INTEGRATIONS:Int = 1 << 4;
    final GUILD_WEBHOOKS:Int = 1 << 5;
    final GUILD_INVITES:Int = 1 << 6;
    final GUILD_VOICE_STATES:Int = 1 << 7;
    final GUILD_PRESENCES:Int = 1 << 8;
    final GUILD_MESSAGES:Int = 1 << 9;
    final GUILD_MESSAGES_REACTIONS:Int = 1 << 10;
    final GUILD_MESSAGE_TYPING:Int = 1 << 11;
    final DIRECT_MESSAGES:Int = 1 << 12;
    final DIRECT_MESSAGES_REACTIONS:Int = 1 << 13;
    final DIRECT_MESSAGE_TYPING:Int = 1 << 14;
    final MESSAGE_CONTENT:Int = 1 << 15;
    final GUILD_SCHEDULED_EVENTS:Int = 1 << 16;
    final AUTO_MODERATION_CONFIGURATION:Int = 1 << 20;
    final AUTO_MODERATION_EXECUTION:Int = 1 << 21;
    final ALL:Int = 3276799;
}
