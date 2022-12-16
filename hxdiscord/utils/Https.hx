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

        trace(url + version + endpoint + path);
        trace(token);

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
}