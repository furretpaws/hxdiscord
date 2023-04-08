package hxdiscord.net;

import haxe.Timer;
using StringTools;

class WebSocketConnection {
    var host = "";
    var ws:haxe.net.WebSocket;
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
        ws.onclose = (code:Int) -> {
            haxe.EntryPoint.runInMainThread(this.onClose.bind(code));
        }

        ws.onerror = (err:String) -> {
            haxe.EntryPoint.runInMainThread(this.onError.bind(err));
        }

        ws.requiredReconnect = () -> {
            requiredReconnect();
        }

        #if sys
        while (true) {
            ws.process();
            Sys.sleep(0.1);
        }
        #end
    }

    public inline function close():Void {
        ws.close();
    }

    public inline function send(message:String) {
        this.ws.sendString(message);
    }

    public inline function sendString(message:String) {
        this.ws.sendString(message);
    }

    public inline function sendJson(j:Dynamic) {
        this.ws.sendString(haxe.Json.stringify(j));
    }

    dynamic public function onClose(code:Int) { }
    dynamic public function requiredReconnect() { }
    dynamic public function onReady() { }
    dynamic public function onMessage(m) { }
    dynamic public function onError(err) { } //:3
}