package hxdiscord.types.message;

/**
    Action rows are used for messages components, as they're mandatory
**/
class ActionRow {
    private var type:Int = 1;
    private var components:Array<Dynamic> = new Array<Dynamic>();

    /**
        Constructor
    **/
    public function new () { }

    /**
        Add a component to the action row
    **/
    public function addComponent(comp:Dynamic)
    {
        components.push(comp);
    }
}