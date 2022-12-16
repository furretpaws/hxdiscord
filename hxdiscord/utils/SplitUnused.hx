package hxdiscord.utils;

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