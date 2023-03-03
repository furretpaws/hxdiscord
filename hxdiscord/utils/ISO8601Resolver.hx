//i'm going to suffer a lot doing this (typed this before doing it)

package hxdiscord.utils;

using StringTools;

class ISO8601Resolver {
    public static function getActualISODate():String {
        return DateTools.format(Date.now(), "%Y-%m-%dT%H:%M:%S." + Std.string(haxe.Timer.stamp() * 10000).split(".")[1] + "Z"); //I DON'T KNOW IF THIS WORKS FOR JS, I'LL TRY TO FIX IT ONCE I ADD JS SUPPORT
    }

    public static function getCalculatedISODate(time:String, ?returnMilliseconds):String {
        var dateToReturn:String = "";
        if (!time.endsWith("s") && !time.endsWith("m") && !time.endsWith("h") && !time.endsWith("d") && !time.endsWith("w") && !time.endsWith("m") && !time.endsWith("y"))
        {
            throw "Either you specified an invalid parameter or you didn't specify it";
        }
        else
        {
            var lastThing:String = time.split("")[time.split("").length-1];
            var theOtherParameter:Float = Std.parseFloat(time.split(lastThing)[0]);
            var timeToAddInMS:Float = 0;
            var date:Date = new Date(Date.now().getUTCFullYear(), Date.now().getUTCMonth(), Date.now().getUTCDate(), Date.now().getUTCHours(), Date.now().getUTCMinutes(), Date.now().getUTCSeconds());
            switch(lastThing.toLowerCase()) {
                case "s": //seconds i think
                    timeToAddInMS = 1000;
                case "m":
                    timeToAddInMS = 60000;
                case "h":
                    timeToAddInMS = 3600000;
                case "d":
                    timeToAddInMS = 86400000;
                case "w":
                    timeToAddInMS = 24 * 60 * 60 * 1000;
                case "m":
                    timeToAddInMS = 2629800000;
                case "y":
                    timeToAddInMS = 2629800000 * 12;
            }
            if (returnMilliseconds) {
                dateToReturn = DateTools.format(DateTools.delta(date, timeToAddInMS * theOtherParameter), "%Y-%m-%dT%H:%M:%S." + Std.string(haxe.Timer.stamp() * 10000).split(".")[1] + "Z");
            }
            else
            {
                dateToReturn = DateTools.format(DateTools.delta(date, timeToAddInMS * theOtherParameter), "%Y-%m-%dT%H:%M:%S.000Z");
            }
        }
        return dateToReturn;
    }
}