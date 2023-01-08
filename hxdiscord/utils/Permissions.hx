package hxdiscord.utils;

class Permissions {
    public static var CREATE_INSTANT_INVITE:Int = 0x00000001;
    public static var KICK_MEMBERS:Int          = 0x00000002;
    public static var BAN_MEMBERS:Int           = 0x00000004;
    public static var ADMINISTRATOR:Int         = 0x00000008;
    public static var MANAGE_CHANNELS:Int       = 0x00000010;
    public static var MANAGE_GUILD:Int          = 0x00000020;
    public static var ADD_REACTIONS:Int         = 0x00000040;
    public static var VIEW_AUDIT_LOG:Int        = 0x00000080;
    public static var VIEW_CHANNEL:Int          = 0x00000400;
    public static var SEND_MESSAGES:Int         = 0x00000800;
    public static var SEND_TTS_MESSAGES:Int     = 0x00001000;
    public static var MANAGE_MESSAGES:Int       = 0x00002000;
    public static var EMBED_LINKS:Int           = 0x00004000;
    public static var ATTACH_FILES:Int          = 0x00008000;
    public static var READ_MESSAGE_HISTORY:Int  = 0x00010000;
    public static var MENTION_EVERYONE:Int      = 0x00020000;
    public static var USE_EXTERNAL_EMOJIS:Int   = 0x00040000;
    public static var CONNECT:Int               = 0x00100000;
    public static var SPEAK:Int                 = 0x00200000;
    public static var MUTE_MEMBERS:Int          = 0x00400000;
    public static var DEAFEN_MEMBERS:Int        = 0x00800000;
    public static var MOVE_MEMBERS:Int          = 0x01000000;
    public static var USE_VAD:Int               = 0x02000000;
    public static var PRIORITY_SPEAKER:Int      = 0x00000100;
    public static var CHANGE_NICKNAME:Int       = 0x04000000;
    public static var MANAGE_NICKNAMES:Int      = 0x08000000;
    public static var MANAGE_ROLES:Int          = 0x10000000;
    public static var MANAGE_WEBHOOKS:Int       = 0x20000000;
    public static var MANAGE_EMOJIS:Int         = 0x40000000;

}