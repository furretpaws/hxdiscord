package hxdiscord.utils;
import haxe.Http;
import haxe.Json;
import haxe.io.BytesOutput;

class Https
{
    public static function sendRequest(url:String, version:String, endpoint:String, path:String, token:String)
    {
        var discordAuth = null;
        if (path != null)
        {
            discordAuth = new haxe.Http(url + version + endpoint + path);
        }
        else
        {
            discordAuth = new haxe.Http(url + version + endpoint);
        }

        /*trace(url + version + endpoint + path);
        trace(token);*/

        var data:String = "";

        discordAuth.addHeader("Authorization", "Bot " + token);

		discordAuth.onData = function(_data:String)
		{
			data = _data;
		}

		discordAuth.onError = function(error)
		{
			throw("An error has occurred: " + error);
		}

		discordAuth.request();

        return data;
    }

    public static function sendNormalRequest(url:String, ?token:String, ?id:String, ?data:String)
    {
        var r:haxe.Http;

        r = new haxe.Http(url + "?data=" + StringTools.urlEncode(data));
        trace(url + "?data=" + StringTools.urlEncode(data));
        r.addHeader("Authorization", "Bot " + token);
		r.onData = function(_data:String)
		{
			if (DiscordClient.debug)
            {
                trace(_data);
            }
		}
		r.onError = function(error)
		{
			throw("An error has occurred: " + error);
		}
		r.request();
    }

    public static function sendDeleteRequest(url:String)
    {
        var r:haxe.Http;

        r = new haxe.Http(url);
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
		r.onData = function(_data:String)
		{
            if (DiscordClient.debug)
            {
                trace(_data);
            }
		}
		r.onError = function(error)
		{
			trace("An error has occurred: " + error);
            trace(r.responseData);
		}
		r.customRequest(true, null, haxe.http.HttpMethod.Delete);
    }

    public static function sendEmptyPutRequest(url:String)
    {
        var r:haxe.Http;

        r = new haxe.Http(url);
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        r.onData = function(_data:String)
        {
            if (DiscordClient.debug)
            {
                trace(_data);
            }
        }
        r.onError = function(error)
        {
            trace("An error has occurred: " + error);
            trace(r.responseData);
        }
        r.customRequest(true, null, haxe.http.HttpMethod.Put);
    }

    public static function sendPutData(url:String, data:Any)
    {
        var req:Http = new Http(url);
		var responseBytes = new BytesOutput();
    
		req.setPostData(Json.stringify(data)); 
		req.addHeader("Content-type", "application/json");
        req.addHeader("Authorization", "Bot " + DiscordClient.token);
    
    	req.onError = function(error:String) {
			trace("An error has occurred: " + error);
            trace(req.responseData);
		};
		
		req.onStatus = function(status:Int) {
			trace(status);
		};
    
		req.customRequest( true, responseBytes, "PUT" );
		var response = responseBytes.getBytes();
    
    	trace(Json.parse(response.toString()));
    }

    public static function sendPostData(url:String, data:Dynamic)
    {
        var r:haxe.Http;

        r = new haxe.Http(url);
        r.addHeader("Content-Type", "application/json");
        r.addHeader("Authorization", "Bot " + DiscordClient.token);
        r.setPostData(haxe.Json.stringify(data));
        r.onData = function(_data:String)
        {
            if (DiscordClient.debug)
            {
                trace(_data);
            }
        }
        r.onError = function(error)
        {
            throw("An error has occurred: " + error);
        }
        r.request(true);
    }
}