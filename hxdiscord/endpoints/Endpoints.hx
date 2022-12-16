package hxdiscord.endpoints;

import hxdiscord.utils.Https;
import hxdiscord.DiscordClient;

class Endpoints
{
    public static var url:String = "https://discord.com/api/";
    public static var version:String = "v10";

    public var getUser:String = "/users/";

    public var getGateway:String = "/gateway";
    public static var getGatewayBot:String = "/gateway/bot";
    public static function getEndpointData(?token:String, _url:String, _version:String, _endpointPath:String, ?_args:String) //idk if that's the correct term to call it
    {
        return Https.sendRequest(_url, _version, _endpointPath, _args, token);
    }
}