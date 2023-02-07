package hxdiscord.types.message;

class TextInput {
    public var type:Int = 4;
    public var custom_id:String;
    public var style:Int = 1;
    public var label:String;
    public var min_length:Int = 0;
    public var max_length:Int = 1;
    public var required:Bool;
    public var value:String;
    public var placeholder:String;

    public function new() { }

    public function setCustomId(custom_id:String) {
        this.custom_id = custom_id;
    }

    public function setStyle(style:Int) {
        this.style = style;
    }

    public function setLabel(label:String) {
        this.label = label;
    }

    public function setMinLength(min_length:Int) {
        this.min_length = min_length;
    }

    public function setMaxLength(max_length:Int) {
        this.max_length = max_length;
    }

    public function setRequired(required:Bool) {
        this.required = required;
    }

    public function setValue(value:String) {
        this.value = value;
    }

    public function setPlaceholder(placeholder:String) {
        this.placeholder = placeholder;
    }
}