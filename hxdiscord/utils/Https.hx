package hxdiscord.utils;

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