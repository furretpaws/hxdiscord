package hxdiscord.net;

import haxe.Json;
import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import haxe.io.BytesInput;
import haxe.io.BufferInput;
import haxe.Utf8;
import haxe.zip.Uncompress;

import haxe.net.WebSocket;

class WebSocketConnection { 
    private static var ZLIB_SUFFIX = "0000ffff";
    private static var BUFFER_SIZE = 1024*1024; //1kb

    private static var ws:WebSocket;
    
    var queue:Array<String> = new Array<String>();
    var ready = false;
    private static var host:String;
    
    public function new(_host) { 
        host = _host;
        haxe.MainLoop.addThread(create);
    }

    function create() {
        ws = WebSocket.create(host, [], null, false);
        ws.onopen = function() {
            ready = true;
            haxe.EntryPoint.runInMainThread(function(){
                for(m in queue) {
                    send(m);
                }
            });
            haxe.EntryPoint.runInMainThread(onReady);
        }
        ws.onmessageString = function(m) { 
            haxe.EntryPoint.runInMainThread(this.onMessage.bind(m));
        }

        var buf = new BytesBuffer();
        
        var z = new Uncompress();
        z.setFlushMode(haxe.zip.FlushMode.SYNC);
        ws.onmessageBytes = function(bytes) {
            // buf.addBytes(m,0,m.length);
            try{
                // var bytes = buf.getBytes();
                if( bytes.toHex().length < 8 || bytes.toHex().substr(-8) != ZLIB_SUFFIX ){
                    var buf = new BytesBuffer();
                    buf.addBytes(bytes,0,bytes.length);
                    return;
                }

                var res = new BytesBuffer();
                
                var chnk = {done:false,write:0,read:0};
                var p = 0;
                var len = bytes.length;
                while(p<len){
                    var chbuf = Bytes.alloc(BUFFER_SIZE);
                    chnk = z.execute(bytes,p,chbuf,0);
                    p += chnk.read;
                    res.addBytes(chbuf,0,chnk.write);
                }

                var msg = res.getBytes().toString();
                haxe.EntryPoint.runInMainThread(this.onMessage.bind(msg));
            }catch(e:Dynamic){
                trace(Std.string(e)+haxe.CallStack.toString(haxe.CallStack.exceptionStack()));

            }
        }
        
        ws.onerror = onError;
        ws.onclose = _onClose;

        #if sys
        while (ws.readyState != Closed) {
            ws.process();
            Sys.sleep(0.1);
        }
        #end
    }

    public inline function close(){
        ws.close();
    }
    
    public inline function sendJson(d:Dynamic) {
        this.send(Json.stringify(d));
    }
    
    public inline function send(m:String) {
        if(!ready)
            queue.push(m);
        else
            ws.sendString(m);     
    }


    private function _onClose() {
        ready = false;
        onClose();
    }

    dynamic public function onClose() { }

    dynamic public function onReady() { }

    dynamic public function onError(s) { }

    dynamic public function onMessage(m) { }

}
