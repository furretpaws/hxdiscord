package hxdiscord.types;

import hxdiscord.types.structTypes.ApplicationCommand;
import hxdiscord.types.structTypes.ApplicationCommand.ApplicationCommandOption;
import hxdiscord.types.CommandType;

class ApplicationCommand {
    public var id:String;
    public var type:Int = 1;
    public var application_id:String;
    public var guild_id:String;
    public var name:String;
    public var name_localizations:String;
    public var description:String;
    public var description_localizations:String;
    public var options:Array<ApplicationCommandOption> = new Array<ApplicationCommandOption>();
    public var default_member_permissions:String;
    public var dm_permission:Bool;
    public var default_permission:Bool;
    public var nsfw:Bool;
    public var version:String;

    public function new() {}

    public function setName(name:String) { this.name = name; }
    public function setType(type:Int) { this.type = type; }
    public function setDescription(description:String) { this.description = description; }
    public function addOption(_option:ApplicationCommandOption)
    { 
        this.options.push(_option);
    }
}