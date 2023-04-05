package hxdiscord.types.message;

/**
    Another Discord interaction, a button!
**/

import hxdiscord.types.structTypes.Emoji;

class Button {
    private var type:Int = 2;
    private var style:Int;
    private var label:String;
    private var emoji:Emoji;
    private var custom_id:String;
    private var url:String;
    private var disabled:Bool;

    /**
        Constructor
    **/
    public function new () { }

    /**
        Set the style of the button
        @param s The style, you can use the ButtonStyle.hx class for this
    **/
    public function setStyle(s:Int) {
        style = s;
    }

    /**
        Set the button label
        @param l The label
    **/
    public function setLabel(l:String) {
        label = l;
    }

    /**
        Set the emoji for the button
        @param e The emoji object
    **/
    public function setEmoji(e:Emoji) {
        emoji = e;
    }

    /**
        Set an ID for the button (Not needed if it's a URL button)
        @param c
    **/
    public function setCustomId(c:String) {
        custom_id = c;
    }

    /**
        Set an URL for the button, if you do please do not set a custom ID as it will fail
        @param u The URL
    **/
    public function setUrl(u:String) {
        url = u;
    }

    /**
        Whether it's a clickable button or not
    **/
    public function setEnabled(e:Bool) {
        disabled = !e;
    }
}