package hxdiscord.gateway;

class Gateway
{
    public static var API_VERSION:String = "10";
    public static var GATEWAY_URL:String = "wss://gateway.discord.gg/?v="+API_VERSION+"&encoding=json";
    public static var GATEWAY_JSON:Dynamic = null;

    public static var heartbeat_interval:Dynamic = null;

    public static function preparePackage(pack:String)
    {
        var data = null;

        switch(pack)
        {
            case "heartbeat_package":
            data = {
                op: 1,
                d: null
            };
        }
        return haxe.Json.stringify(data);
    }
}