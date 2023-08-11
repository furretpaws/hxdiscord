package hxdiscord.utils;

#if nodejs
import js.node.Url;
import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.http.IncomingMessage;
import js.SyncRequest;
#end

/**
    The HTTP class hxdiscord uses
    NOTE: If you're going to use http requests for any of your applications. It is extremely recommended to use this class, since it's supported for every language hxdiscord supports
**/

class Http {
    var url:String = "";
    var method:String = "";
    var headers:Array<Dynamic> = [];
    var postData:Dynamic = null;
    public var responseData:String;
    var response:String;
    /**
        Constructor
        @param url The URL you wanna request
    **/
    public function new(url:String) {
        this.url = url;
    }

    /**
        Set a method, it can be GET, POST, DELETE, PATCH, PUT.. (Case sensitive tho)
        @param method The method
    **/
    public function setMethod(method:String) {
        this.method = method;
    }

    /**
        Adds a header to your request
        @param val1 The first parameter
        @param val2 The second parameter
    **/
    public function addHeader(val1:String, val2:String) {
        var array:Array<String> = [];
        array.push(val1);
        array.push(val2);
        headers.push(array);
    }

    /**
        Add a header with an array
        @param header The array for the header (i.e ["User-Agent", "hxdiscord"])
    **/
    public function addHeaderByArray(header:Array<String>) {
        headers.push(header);
    }

    /**
        If you're going to send a HTTP request that's not a GET method, you'll have to use this
        Sets the POST data you wanna send
        @param postData The data
    **/
    public function setPostData(postData:String) {
        this.postData = postData;
    }

    /**
        Sets the POST data with bytes (Mostly used for uploading files)
        @param postData The data (but with bytes!)
    **/
    public function setPostBytes(postData:haxe.io.Bytes) {
        this.postData = postData;
    }

    /**
        Send the data
    **/
    public function send() {
        #if js
        var baseThing:String = "{}";
        var headersJson:Dynamic = haxe.Json.parse(baseThing);
        for (i in 0...headers.length) {
            Reflect.setProperty(headersJson, headers[i][0], headers[i][1]);
        }
        var request:SyncRequest = new SyncRequest(method, url, {
            headers: headersJson,
            body: postData
        });
        var data:String = "";
        data += request.getBody();
        responseData = data;
        onData(data);
        /*var headersMap = new Map<String, String>();

        for (i in 0...headers.length) {
            if (!headersMap.exists(headers[i][0])) {
                headersMap.set(headers[i][0], headers[i][1]);
            }
        }

        var headersDynamicAccess = new DynamicAccess<EitherType<String,Array<String>>>();
        for (h in headersMap.keys()) {
            headersDynamicAccess.set(h, headersMap.get(h));
        }

        var http = js.node.Http;
        var options = {
          hostname: Url.parse(this.url).host,
          path: Url.parse(this.url).path,
          method: this.method,
          headers: headersDynamicAccess
        };
        var req = js.node.Https.request(options, function(res:IncomingMessage) {
            var datas = "";
            res.on('data', (all) -> {
                datas += all;
                this.responseData = datas;
                onData(datas);
            });
            res.on('error', (e) -> {
                onError(e);
            });
        });
        if(["POST","PUT","PATCH","DELETE"].indexOf(method)>-1&&postData!=null)
            req.write(postData);
        req.end();*/
        #else
        var req:haxe.Http = new haxe.Http(url);
        for (i in 0...headers.length) {
            req.addHeader(headers[i][0], headers[i][1]); //i fucked up?????
        }
		var responseBytes = new haxe.io.BytesOutput();
        var didItFail:Bool = false;
        var data:String = "";

        if (postData != null) {
            if (Std.isOfType(postData, String)) {
                req.setPostData(postData);
            } else if (Std.isOfType(postData, haxe.io.Bytes)) {
                req.setPostBytes(postData);
            }
        }
    
    	req.onError = function(error:String) {
            data = error;
		};
    
		req.customRequest(false, responseBytes, this.method);
		var response = responseBytes.getBytes();
        if (data == null || data == "") {
            //do nothing
        } else {
            onError(data);
            trace(response);
        }
        onData(response.toString());
        #end
    }

    /**
        Also sends the data, but it's more haxe.Http syntaxed
        @param post Whether it's a POST request or not
    **/
    public function request(?post:Bool) {
        #if nodejs
        var headersMap = new Map<String, String>();

        var method:String = "";
        if (post)
            method = "POST";
        else
            method = "GET";

        for (i in 0...headers.length) {
            if (!headersMap.exists(headers[i][0])) {
                headersMap.set(headers[i][0], headers[i][1]);
            }
        }

        var headersDynamicAccess = new DynamicAccess<EitherType<String,Array<String>>>();
        for (h in headersMap.keys()) {
            headersDynamicAccess.set(h, headersMap.get(h));
        }

        var http = js.node.Http;
        var options = {
          hostname: Url.parse(this.url).host,
          path: Url.parse(this.url).path,
          method: this.method,
          headers: headersDynamicAccess
        };
        var req = js.node.Https.request(options, function(res:IncomingMessage) {
            var datas = "";
            res.on('data', (all) -> {
                datas += all;
                this.responseData = datas;
                onData(datas);
            });
            res.on('error', (e) -> {
                onError(e);
            });
        });
        if(["POST","PUT","PATCH","DELETE"].indexOf(method)>-1&&postData!=null)
            req.write(postData);
        req.end();
        #else
        var r = new haxe.Http(url);

        for (i in 0...headers.length) {
            r.addHeader(headers[i][0], headers[i][1]); //i fucked up?????
        }

        if (postData != null) {
            if (Std.isOfType(postData, String)) {
                r.setPostData(postData);
            } else if (Std.isOfType(postData, haxe.io.Bytes)) {
                r.setPostBytes(postData);
            }
        }

		r.onData = function(data:String)
		{
            onData(data);
		}

		r.onError = function(error)
		{
			onError(error);
		}

		r.request(post);
        #end
    }
    
    @:dox(hide)
    @:deprecated("Please don't use this. Use setMethod instead")
    public function customRequest(?post:Bool, ?output:haxe.io.BytesOutput, ?method:String) {
        #if nodejs
        var headersMap = new Map<String, String>();

        var method:String = "";
        if (post)
            method = "POST";
        else
            method = "GET";

        for (i in 0...headers.length) {
            if (!headersMap.exists(headers[i][0])) {
                headersMap.set(headers[i][0], headers[i][1]);
            }
        }

        var headersDynamicAccess = new DynamicAccess<EitherType<String,Array<String>>>();
        for (h in headersMap.keys()) {
            headersDynamicAccess.set(h, headersMap.get(h));
        }

        var http = js.node.Http;
        var options = {
          hostname: Url.parse(this.url).host,
          path: Url.parse(this.url).path,
          method: this.method,
          headers: headersDynamicAccess
        };
        var req = js.node.Https.request(options, function(res:IncomingMessage) {
            var datas = "";
            res.on('data', (all) -> {
                datas += all;
                this.responseData = datas;
                onData(datas);
            });
            res.on('error', (e) -> {
                onError(e);
            });
        });
        if(["POST","PUT","PATCH","DELETE"].indexOf(method)>-1&&postData!=null)
            req.write(postData);
        req.end();
        return responseData;
        #else
        var req:Http = new Http(url);
    
        for (i in 0...headers.length) {
            req.addHeader(headers[i][0], headers[i][1]); //i fucked up?????
        }

        if (postData != null) {
            if (Std.isOfType(postData, String)) {
                req.setPostData(postData);
            } else if (Std.isOfType(postData, haxe.io.Bytes)) {
                req.setPostBytes(postData);
            }
        }
    
    	req.onError = function(error:String) {
            this.responseData = req.responseData;
            onError(req.responseData);
		};

        req.onStatus = function(c:Int) {
            onStatus(c);
        }
    
		req.customRequest(false, output, method);
		return output;
        #end
    }

    /**
        Event hook for the incoming data
    **/
    dynamic public function onData(d:String) { }
    /**
        Event hook if any errors occur
    **/
    dynamic public function onError(d:String) { }
    /**
        Event hook for code status (Not sure if it works on every targets)
    **/
    dynamic public function onStatus(d:Int) { }
}