package hxdiscord.types;

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
    public function new(d:hxdiscord.types.structTypes.GuildMember, gi:String) {
        this.id = d.id;
        this.nick = d.nick;
        this.user = new User(d.user);
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
    public function ban(?reason:String):Bool {
        return hxdiscord.endpoints.Endpoints.createGuildBan(user.id, guild_id, reason);
    }

    public function kick(?reason:String):Bool {
        return hxdiscord.endpoints.Endpoints.removeGuildMember(user.id, guild_id, reason);
    }

    public function modify(d:hxdiscord.types.Typedefs.ModifyGuildMemberParams):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, d);
    }

    public function setNick(n:String):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            nick: n
        });
    }

    public function setRoles(r:Array<String>):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            roles: r
        });
    }

    public function setMute(b:Bool):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            mute: b
        });
    }

    public function setDeaf(b:Bool):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            deaf: b
        });
    }

    public function moveVoiceChannel(id:String):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            channel_id: id
        });
    }

    public function setTimeout(d:String):Bool {
        var daTime:String = hxdiscord.utils.ISO8601Resolver.getCalculatedISODate(d);
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            communication_disabled_until: daTime
        });
    }

    public function setFlags(f:Int):Bool {
        return hxdiscord.endpoints.Endpoints.modifyGuildMember(guild_id, user.id, {
            flags: f
        });
    }
}