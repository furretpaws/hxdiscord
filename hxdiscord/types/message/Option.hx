package hxdiscord.types.message;

import hxdiscord.types.structTypes.Emoji;

class Option {
    private var label:String;
    private var value:String;
    private var description:String;
    private var emoji:Emoji;
    private var _default:String;

    public function new() { }

    public function setLabel(label:String) {
        this.label = label;
    }

    public function setValue(value:String) {
        this.value = value;
    }

    public function setDescription(description:String) {
        this.description = description;
    }

    public function setEmoji(emoji:Emoji) {
        this.emoji = emoji;
    }

    public function setDefault(_default:String) {
        this._default = _default;
    }
}