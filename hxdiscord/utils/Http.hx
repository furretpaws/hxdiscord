package hxdiscord.utils;

#if nodejs
import js.node.Url;
import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.http.IncomingMessage;
#end

class Http {
    var url:String = "";
    var method:String = "";
    var headers:Array<Dynamic> = [];
    var postData:Dynamic = null;
    public var responseData:String;
    var response:String;
    public function new(url:String) {
        this.url = url;
    }

    public function setMethod(method:String) {
        this.method = method;
    }

    public function addHeader(val1:String, val2:String) {
        var array:Array<String> = [];
        array.push(val1);
        array.push(val2);
        headers.push(array);
    }

    public function addHeaderByArray(header:Array<String>) {
        headers.push(header);
    }

    public function setPostData(postData:String) {
        this.postData = postData;
    }

    public function setPostBytes(postData:haxe.io.Bytes) {
        this.postData = postData;
    }

    public function send() {
        #if nodejs
        var headersMap = new Map<String, String>();

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
        if (data != null || data != "") {
            //do nothing
        } else {
            onError(data);
        }
        onData(response.toString());
        #end
    }

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

    dynamic public function onData(d:String) { }
    dynamic public function onError(d:String) { }
    dynamic public function onStatus(d:Int) { }
}