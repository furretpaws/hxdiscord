package hxdiscord.utils;
import hxdiscord.utils.Http;
import haxe.Json;
import haxe.io.BytesOutput;

/**
    NOTE: Please don't use this at all because it's useless.
**/

class Https
{
    public static function sendRequest(url:String, version:String, endpoint:String, path:String, token:String)
    {
        var discordAuth = null;
        if (path != null)
        {
            discordAuth = new Http(url + version + endpoint + path);
        }
        else
        {
            discordAuth = new Http(url + version + endpoint);
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

		discordAuth.send();

        discordAuth.setMethod("GET");

        return data;
    }

    public static function sendNormalRequest(url:String, ?token:String, ?id:String, ?data:String)
    {
        var r:Http;

        r = new Http(url + "?data=" + StringTools.urlEncode(data));
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
        r.setMethod("GET");
		r.send();
    }

    public static function sendDeleteRequest(url:String)
    {
        var r:Http;

        r = new Http(url);
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
        r.setMethod("DELETE");
		r.send();
    }

    public static function sendEmptyPutRequest(url:String)
    {
        var r:Http;

        r = new Http(url);
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
        r.setMethod("PUT");
        r.send();
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
        req.setMethod("PUT");
    
		req.send();
		var response = responseBytes.getBytes();
    
    	trace(Json.parse(response.toString()));
    }

    public static function sendPostData(url:String, data:Dynamic)
    {
        var r:Http;

        r = new Http(url);
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
        r.setMethod("POST");
        r.send();
    }
}