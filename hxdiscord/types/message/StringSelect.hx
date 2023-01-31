package hxdiscord.types.message;

import hxdiscord.types.message.Option;

class StringSelect {
    private var type:Int = 3;

    private var custom_id:String;
    private var options:Array<Option> = new Array<Option>();
    private var channel_types:Array<Int> = new Array<Int>();
    private var placeholder:String;
    private var min_values:Int;
    private var max_values:Int;
    private var disabled:Bool;

    public function new() { #if cpp max_values = 1; min_values = 0; #end }

    public function setCustomId(custom_id:String) {
        this.custom_id = custom_id;
    }

    public function addOption(option:Option) {
        options.push(option);
    }

    public function setPlaceholder(placeholder:String) {
        this.placeholder = placeholder;
    }

    public function setMinValues(min_values:Int) {
        this.min_values = min_values;
    }

    public function setMaxValues(max_values:Int) {
        this.max_values = max_values;
    }

    public function setEnabled(e:Bool) {
        disabled = !e;
    }
}