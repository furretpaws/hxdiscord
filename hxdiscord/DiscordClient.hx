package hxdiscord;

import hxdiscord.gateway.Gateway;
import hxdiscord.gateway.OpCode;
import hxdiscord.endpoints.Endpoints;

class DiscordClient
{
    var token:String = "";
    var debug:Bool;

    public function new (_token:String, _debug:Bool = false)
    {
        token = _token;
        debug = _debug;

        trace(Endpoints.getEndpointData(token, Endpoints.url, Endpoints.version, Endpoints.getGatewayBot));
    }
}