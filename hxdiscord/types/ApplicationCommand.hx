/**
    Application commands! Another Discord Interaction
**/

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
    public var default_permission:Bool = true;
    public var nsfw:Bool;
    public var version:String;

    /**
        The constructor
    **/
    public function new() {
        #if (!neko)
        if (default_member_permissions == null)
        {
            Reflect.deleteField(this, "default_member_permissions");
        }
        #end
    }

    /**
        Set the name for the Application Command
        (NOTE: Slash commands cannot contain upper case letters neither spaces, or else it won't be added)
        @param name The name for the command
    **/
    public function setName(name:String) { this.name = name; }
    /**
        Set the Application Command type
        @param type The type (Set to 1 by default, see the Discord API for more information)
    **/
    public function setType(type:Int) { this.type = type; }
    /**
        Set the command description, it usually appears on slash commands
        @param description The description
    **/
    public function setDescription(description:String) { this.description = description; }
    /**
        Add an option (used in slash commands)
        @param _option The option object
    **/
    public function addOption(_option:ApplicationCommandOption)
    { 
        this.options.push(_option);
    }
}