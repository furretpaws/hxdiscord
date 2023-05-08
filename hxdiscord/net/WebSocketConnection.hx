package hxdiscord.net;

import haxe.Timer;
import haxe.ws.Log;
using StringTools;

#if (sys&&!nodejs)
class WebSocketConnection {
    var host = "";
    var ws:haxe.ws.WebSocket;
    var destroyed:Bool = false;
    var errored:Bool = false;
    public function new(host:String) {
        trace("oh");
        this.host = host;
        create();
    }

    function create() {
        sys.thread.Thread.create(()->{
            Log.mask = Log.INFO | Log.DEBUG | Log.DATA;
            Sys.getChar(true);
            ws = new haxe.ws.WebSocket(host);
            ws.onopen = function() {
                onReady();
            }
            ws.onmessage = function(message:haxe.ws.Types.MessageType) {
                switch(message) {
                    case StrMessage(content):
                        onMessage(content);
                    case BytesMessage(content):
                        //no
                }
            }
            ws.onclose = () -> {
                onClose(1);
            }

            ws.onerror = (err:String) -> {
                onError(err);
            }
        });
    }

    public inline function close():Void {
        ws.close();
    }

    public inline function send(message:String) {
        try {
            this.ws.send(message);
        } catch (err) {
            trace("Close required since faulty websocket");
            close();
            //onClose(1001);
        }
    }

    public inline function sendString(message:String) {
        try {
            this.ws.send(message);
        } catch (err) {
            trace("Close required since faulty websocket");
            close();
            //onClose(1001);
        }
    }

    public inline function sendJson(j:Dynamic) {
        try {
            this.ws.send(haxe.Json.stringify(j));
        } catch (err) {
            trace("Close required since faulty websocket");
            close();
            onClose(1001);
        }
    }

    dynamic public function destroy() {
        this.ws = null;
        destroyed = true;
    }
    dynamic public function onClose(code) { }
    dynamic public function onReady() { }
    dynamic public function onMessage(m:String) { }
    dynamic public function onError(err) { } //:3
}
#else
class WebSocketConnection {
    var host = "";
    var ws:haxe.net.WebSocket;
    var destroyed:Bool = false;
    var errored:Bool = false;
    public function new(host:String) {
        this.host = host;
        haxe.MainLoop.addThread(create);
    }

    function create() {
        ws = haxe.net.WebSocket.create(host, [], null, false);
        ws.onopen = function() {
            haxe.EntryPoint.runInMainThread(onReady);
        }
        ws.onmessageString = function(message) {
            #if (js&&nodejs)
            haxe.EntryPoint.runInMainThread(this.onMessage.bind(message.toString()));
            #else
            haxe.EntryPoint.runInMainThread(this.onMessage.bind(message));
            #end
        }
        ws.onclose = (code:Dynamic) -> {
            haxe.EntryPoint.runInMainThread(this.onClose.bind(code));
        }

        ws.onerror = (err:String) -> {
            haxe.EntryPoint.runInMainThread(this.onError.bind(err));
        }

        #if sys
        while (!destroyed) {
            try {
                if (!destroyed) {
                    ws.process();
                    Sys.sleep(0.1);
                }
            } catch (err) {
                onError(Std.string(err));
            }
        }
        #end
    }

    public inline function close():Void {
        ws.close();
    }

    public inline function send(message:String) {
        try {
            this.ws.sendString(message);
        } catch (err) {
            trace("Close required since faulty websocket");
            close();
            //onClose(1001);
        }
    }

    public inline function sendString(message:String) {
        try {
            this.ws.sendString(message);
        } catch (err) {
            trace("Close required since faulty websocket");
            close();
            //onClose(1001);
        }
    }

    public inline function sendJson(j:Dynamic) {
        try {
            this.ws.sendString(haxe.Json.stringify(j));
        } catch (err) {
            trace("Close required since faulty websocket");
            close();
            onClose(1001);
        }
    }

    dynamic public function destroy() {
        this.ws = null;
        destroyed = true;
    }
    dynamic public function onClose(code) { }
    dynamic public function onReady() { }
    dynamic public function onMessage(m) { }
    dynamic public function onError(err) { } //:3
}
#end