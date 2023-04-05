package hxdiscord.utils;

/**
    CONTENT: I WAS USING THE hxWebSockets LIBRARY BUT THIS IS NOT NEEDED ANYMORE 😭
**/

/**
    Unused, please do not bother checking this
**/

class SplitUnused
{
    public static function returnClean(type:String, text:String)
    {
        var thingtoreturn:String = null;
        switch (type)
        {
            case 'StrMessage':
                var textSp = text.split("(");
                var splitagain = textSp[1].split(")");
                thingtoreturn = splitagain[0];
        }
        return thingtoreturn;
    }
}