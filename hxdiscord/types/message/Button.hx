package hxdiscord.types.message;

import hxdiscord.types.structTypes.Emoji;

class Button {
    private var type:Int = 2;
    private var style:Int;
    private var label:String;
    private var emoji:Emoji;
    private var custom_id:String;
    private var url:String;
    private var disabled:Bool;

    public function new () { }

    public function setStyle(s:Int) {
        style = s;
    }

    public function setLabel(l:String) {
        label = l;
    }

    public function setEmoji(e:Emoji) {
        emoji = e;
    }

    public function setCustomId(c:String) {
        custom_id = c;
    }

    public function setUrl(u:String) {
        url = u;
    }

    public function setEnabled(e:Bool) {
        disabled = !e;
    }
}