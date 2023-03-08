package hxdiscord.types;

import hxdiscord.types.structTypes.ApplicationCommand;
import hxdiscord.types.structTypes.ApplicationCommand.ApplicationCommandOption;
import hxdiscord.types.CommandType;

class ApplicationCommand {
    public var id:String;
    public var type:Int = 1;
    public var application_id:String = null;
    public var guild_id:String = null;
    public var name:String = null;
    public var name_localizations:String = null;
    public var description:String = null;
    public var description_localizations:String;
    public var options:Array<ApplicationCommandOption> = new Array<ApplicationCommandOption>();
    public var default_member_permissions:String = null;
    public var dm_permission:Bool = null;
    public var default_permission:Bool = null;
    public var nsfw:Bool = null;
    public var version:String = null;

    public function new() {}

    public function setName(name:String) { this.name = name; }
    public function setType(type:Int) { this.type = type; }
    public function setDescription(description:String) { this.description = description; }
    public function addOption(_option:ApplicationCommandOption)
    { 
        this.options.push(_option);
    }
}