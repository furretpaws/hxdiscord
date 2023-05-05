package hxdiscord.cache;
import hxdiscord.endpoints.Endpoints;

/**
    Maybe it's not the best way to do this but I wanna try. If I see that this does not go well then I'll find another way
    Also, I'm going to cache ONLY guild members, including their roles and permissions (for now)

    If you're reading the documentation, please ignore this
**/

class CachedData {
    var dc:hxdiscord.DiscordClient;
    public function new(dc:hxdiscord.DiscordClient) {this.dc = dc;}
    /*public var guild_members:Array<hxdiscord.types.Member> = [];
    public var guilds:Array<Dynamic> = [];
    public var roles:Array<Dynamic> = [];*/
    public var guild_members:Map<String, hxdiscord.types.Member> = new Map<String, hxdiscord.types.Member>();
    public var guilds:Map<String, Dynamic> = new Map<String, Dynamic>();
    public var guilds_roles:Map<String, Dynamic> = new Map<String, Dynamic>();
    public var roles:Map<String, Dynamic> = new Map<String, Dynamic>();
    /*public function cacheMemberAndRoles(gid:String, uid:String) {
        var member:hxdiscord.types.Member = null;
        hxdiscord.endpoints.Endpoints.getGuildMember(gid, uid, (m) -> {member = m;}, null);
        var foundRoles:Bool = false;
        var dataRoles:Dynamic = null;
        if (roles.length == 0) {
            var r:Dynamic = Endpoints.getRoles(gid);
            roles.push([gid, r]);
            dataRoles = r;
            foundRoles = true;
        } else {
            for (i in 0...roles.length) {
                if (roles[i][0] == gid) {
                    dataRoles = roles[i][1];
                    foundRoles = true;
                }
            }
        }
        if (!foundRoles) {
            dataRoles = Endpoints.getRoles(gid);
        }

        dataRoles = haxe.Json.parse(dataRoles);

        for (i in 0...member.roles.length)
        {
            for (x in 0...dataRoles.length)
            {
                if (member.roles[i] == dataRoles[x].id)
                {
                    member.permissionsBitwise.push(dataRoles[x].permissions);
                }
            }
        }
        if (guild_members.length == 0) {
            guild_members.push(member);
        } else {
            for (i in 0...guild_members.length) {
                var found:Bool = false;
                if (guild_members[i].user.id == member.user.id && guild_members[i].guild_id == gid) {
                    found = true;
                }
                if (found) {
                    guild_members.remove(guild_members[i]);
                    guild_members.push(member);
                } else {
                    guild_members.push(member);
                }
            }
        }
    }*/
}