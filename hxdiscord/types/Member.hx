package hxdiscord.types;
import hxdiscord.endpoints.Endpoints;

class Member {
    public var nick:String;
    public var avatar:String;
    public var roles:Array<String>;
    public var joined_at:String;
    public var premium_since:String;
    public var deaf:Bool;
    public var mute:Bool;
    public var user:User;
    public var flags:Int;
    public var pending:Bool;
    public var permissions:String;
    public var communication_disabled_until:String;
    public var guild_id:String;
    public var id:String;
    public var permissionsBitwise:Array<String> = [];
    /**
        Constructor
    **/
    public function new(d:hxdiscord.types.structTypes.GuildMember, gi:String) {
        this.id = d.id;
        this.nick = d.nick;
        this.user = new User(null, Endpoints.getUser(d.id));
        this.avatar = d.avatar;
        this.roles = d.roles;
        this.joined_at = d.joined_at;
        this.premium_since = d.premium_since;
        this.deaf = d.deaf;
        this.flags = d.flags;
        this.pending = d.pending;
        this.permissions = d.permissions;
        this.communication_disabled_until = d.communication_disabled_until;
        this.guild_id = gi;
    }
    /**
        Bans the user
        @param reason Reason
    **/
    public function ban(?reason:String):Bool {
        return hxdiscord.endpoints.Endpoints.createGuildBan(user.id, guild_id, reason);
    }

    /**
        Kick a user
        @param reason Reason
    **/
    public function kick(?reason:String):Bool {
        return hxdiscord.endpoints.Endpoints.removeGuildMember(user.id, guild_id, reason);
    }

    /**
        Modify a user
        @param d JSON object (see Discord API or the typedef for more info)
    **/
    public function modify(d:hxdiscord.types.Typedefs.ModifyGuildMemberParams):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, d);
    }

    /**
        Set a custom nick
        @param n The nick you wanna set
    **/

    public function setNick(n:String):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            nick: n
        });
    }

    /**
        Set roles to the member
        @param r An array full of role ids
    **/
    public function setRoles(r:Array<String>):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            roles: r
        });
    }

    /**
        Whether you wanna mute or unmute a user from voice channels
        @param b Mute or unmute
    **/

    public function setMute(b:Bool):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            mute: b
        });
    }

    /**
        Whether you wanna deafen or unmute a user from voice channels
        @param b Deaf or not
    **/

    public function setDeaf(b:Bool):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            deaf: b
        });
    }

    /**
        Moves a user from a voice channel to another
        @param id The ID of the channel
    **/

    public function moveVoiceChannel(id:String):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            channel_id: id
        });
    }

    /**
        Set a timeout to the user
        @param d The time (i.e 5m, 10m, 1h)
    **/

    public function setTimeout(d:String):Bool {
        var daTime:String = hxdiscord.utils.ISO8601Resolver.getCalculatedISODate(d);
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            communication_disabled_until: daTime
        });
    }

    /**
        Set user flags
        @param f Flags
    **/

    public function setFlags(f:Int):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            flags: f
        });
    }
}