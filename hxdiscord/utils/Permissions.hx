package hxdiscord.utils;

import haxe.Int64;

class Permissions {
    public static inline final _CREATE_INSTANT_INVITE:Int = 0x00000001;
    public static inline final _KICK_MEMBERS:Int = 0x00000002;
    public static inline final _BAN_MEMBERS:Int = 0x00000004;
    public static inline final _ADMINISTRATOR:Int = 0x00000008;
    public static inline final _MANAGE_CHANNELS:Int = 0x00000010;
    public static inline final _MANAGE_GUILD:Int = 0x00000020;
    public static inline final _ADD_REACTIONS:Int = 0x00000040;
    public static inline final _VIEW_AUDIT_LOG:Int = 0x00000080;
    public static inline final _VIEW_CHANNEL:Int = 0x00000400;
    public static inline final _SEND_MESSAGES:Int = 0x00000800;
    public static inline final _SEND_TTS_MESSAGES:Int = 0x00001000;
    public static inline final _MANAGE_MESSAGES:Int = 0x00002000;
    public static inline final _EMBED_LINKS:Int = 0x00004000;
    public static inline final _ATTACH_FILES:Int = 0x00008000;
    public static inline final _READ_MESSAGE_HISTORY:Int = 0x00010000;
    public static inline final _MENTION_EVERYONE:Int = 0x00020000;
    public static inline final _USE_EXTERNAL_EMOJIS:Int = 0x00040000;
    public static inline final _CONNECT:Int = 0x00100000;
    public static inline final _SPEAK:Int = 0x00200000;
    public static inline final _MUTE_MEMBERS:Int = 0x00400000;
    public static inline final _DEAFEN_MEMBERS:Int = 0x00800000;
    public static inline final _MOVE_MEMBERS:Int = 0x01000000;
    public static inline final _USE_VAD:Int = 0x02000000;
    public static inline final _PRIORITY_SPEAKER:Int = 0x00000100;
    public static inline final _CHANGE_NICKNAME:Int = 0x04000000;
    public static inline final _MANAGE_NICKNAMES:Int = 0x08000000;
    public static inline final _MANAGE_ROLES:Int = 0x10000000;
    public static inline final _MANAGE_WEBHOOKS:Int = 0x20000000;
    public static inline final _MANAGE_EMOJIS:Int = 0x40000000;

    public static function resolve(_int:Int64):Array<String>
    {
        var allIntents:Array<Int> = [_CREATE_INSTANT_INVITE, _KICK_MEMBERS, _BAN_MEMBERS, _ADMINISTRATOR, _MANAGE_CHANNELS, _MANAGE_GUILD, _ADD_REACTIONS, _VIEW_AUDIT_LOG, _VIEW_CHANNEL, _SEND_MESSAGES, _SEND_TTS_MESSAGES, _MANAGE_MESSAGES, _EMBED_LINKS, _ATTACH_FILES, _READ_MESSAGE_HISTORY, _MENTION_EVERYONE, _USE_EXTERNAL_EMOJIS, _CONNECT, _SPEAK, _MUTE_MEMBERS, _DEAFEN_MEMBERS, _MOVE_MEMBERS, _USE_VAD, _PRIORITY_SPEAKER, _CHANGE_NICKNAME, _MANAGE_NICKNAMES, _MANAGE_ROLES, _MANAGE_WEBHOOKS, _MANAGE_EMOJIS];
        var allIntentsList:Array<String> = [Permission.CREATE_INSTANT_INVITE, Permission.KICK_MEMBERS, Permission.BAN_MEMBERS, Permission.ADMINISTRATOR, Permission.MANAGE_CHANNELS, Permission.MANAGE_GUILD, Permission.ADD_REACTIONS, Permission.VIEW_AUDIT_LOG, Permission.VIEW_CHANNEL, Permission.SEND_MESSAGES, Permission.SEND_TTS_MESSAGES, Permission.MANAGE_MESSAGES, Permission.EMBED_LINKS, Permission.ATTACH_FILES, Permission.READ_MESSAGE_HISTORY, Permission.MENTION_EVERYONE, Permission.USE_EXTERNAL_EMOJIS, Permission.CONNECT, Permission.SPEAK, Permission.MUTE_MEMBERS, Permission.DEAFEN_MEMBERS, Permission.MOVE_MEMBERS, Permission.USE_VAD, Permission.PRIORITY_SPEAKER, Permission.CHANGE_NICKNAME, Permission.MANAGE_NICKNAMES, Permission.MANAGE_ROLES, Permission.MANAGE_WEBHOOKS, Permission.MANAGE_EMOJIS];
        var thingToReturn:Array<String> = [];
        
        for (i in 0...allIntents.length) {
            if ((_int & allIntents[i]) != 0) {
                thingToReturn.push(allIntentsList[i]);
            }
        }

        return thingToReturn;
    }

    public static function convert(perms:Array<Int>):Int
    {
        var permissionInt:Int = 0;
        if (perms == [])
        {
            throw "This function requires valid permissions.";
        }
        else
        {
            for (permission in perms) {
                permissionInt |= permission;
            }
        }
        return permissionInt;
    }
}

class Permission {
    public static inline final CREATE_INSTANT_INVITE:String = "CREATE_INSTANT_INVITE";
    public static inline final KICK_MEMBERS:String = "KICK_MEMBERS";
    public static inline final BAN_MEMBERS:String = "BAN_MEMBERS";
    public static inline final ADMINISTRATOR:String = "ADMINISTRATOR";
    public static inline final MANAGE_CHANNELS:String = "MANAGE_CHANNEL";
    public static inline final MANAGE_GUILD:String = "MANAGE_GUILD";
    public static inline final ADD_REACTIONS:String = "ADD_REACTIONS";
    public static inline final VIEW_AUDIT_LOG:String = "VIEW_AUDIT_LOG";
    public static inline final VIEW_CHANNEL:String = "VIEW_CHANNEL";
    public static inline final SEND_MESSAGES:String = "SEND_MESSAGES";
    public static inline final SEND_TTS_MESSAGES:String = "SEND_TTS_MESSAGES";
    public static inline final MANAGE_MESSAGES:String = "MANAGE_MESSAGES";
    public static inline final EMBED_LINKS:String = "EMBED_LINKS";
    public static inline final ATTACH_FILES:String = "ATTACH_FILES";
    public static inline final READ_MESSAGE_HISTORY:String = "READ_MESSAGE_HISTORY";
    public static inline final MENTION_EVERYONE:String = "MENTION_EVERYONE";
    public static inline final USE_EXTERNAL_EMOJIS:String = "USE_EXTERNAL_EMOJIS";
    public static inline final CONNECT:String = "CONNECT";
    public static inline final SPEAK:String = "SPEAK";
    public static inline final MUTE_MEMBERS:String  = "MUTE_MEMBERS";
    public static inline final DEAFEN_MEMBERS:String = "DEAFEN_MEMBERS";
    public static inline final MOVE_MEMBERS:String = "MOVE_MEMBERS";
    public static inline final USE_VAD:String = "USE_VAD";
    public static inline final PRIORITY_SPEAKER:String = "PRIORITY_SPEAKER";
    public static inline final CHANGE_NICKNAME:String = "CHANGE_NICKNAME";
    public static inline final MANAGE_NICKNAMES:String = "MANAGE_NICKNAMES";
    public static inline final MANAGE_ROLES:String = "MANAGE_ROLES";
    public static inline final MANAGE_WEBHOOKS:String = "MANAGE_WEBHOOKS";
    public static inline final MANAGE_EMOJIS:String = "MANAGE_EMOJIS";
}
