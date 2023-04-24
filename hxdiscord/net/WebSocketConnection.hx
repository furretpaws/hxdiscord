package hxdiscord.net;

import haxe.Timer;
using StringTools;

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
        while (ws.readyState != Closed) {
            try {
                if (ws.readyState != Closed) {
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
            onClose(1001);
        }
    }

    public inline function sendString(message:String) {
        try {
            this.ws.sendString(message);
        } catch (err) {
            trace("Close required since faulty websocket");
            close();
            onClose(1001);
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