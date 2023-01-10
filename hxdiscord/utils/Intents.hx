package hxdiscord.utils;

class Intents {
    public static inline final GUILDS:Int = 1 << 0;
    public static inline final GUILD_MEMBERS:Int = 1 << 1;
    public static inline final GUILD_BANS:Int = 1 << 2;
    public static inline final GUILD_EMOJIS_AND_STICKERS:Int = 1 << 3;
    public static inline final GUILD_INTEGRATIONS:Int = 1 << 4;
    public static inline final GUILD_WEBHOOKS:Int = 1 << 5;
    public static inline final GUILD_INVITES:Int = 1 << 6;
    public static inline final GUILD_VOICE_STATES:Int = 1 << 7;
    public static inline final GUILD_PRESENCES:Int = 1 << 8;
    public static inline final GUILD_MESSAGES:Int = 1 << 9;
    public static inline final GUILD_MESSAGES_REACTIONS:Int = 1 << 10;
    public static inline final GUILD_MESSAGE_TYPING:Int = 1 << 11;
    public static inline final DIRECT_MESSAGES:Int = 1 << 12;
    public static inline final DIRECT_MESSAGES_REACTIONS:Int = 1 << 13;
    public static inline final DIRECT_MESSAGE_TYPING:Int = 1 << 14;
    public static inline final MESSAGE_CONTENT:Int = 1 << 15;
    public static inline final GUILD_SCHEDULED_EVENTS:Int = 1 << 16;
    public static inline final AUTO_MODERATION_CONFIGURATION:Int = 1 << 20;
    public static inline final AUTO_MODERATION_EXECUTION:Int = 1 << 21;
    public static inline final ALL:Int = 3276799;
}
