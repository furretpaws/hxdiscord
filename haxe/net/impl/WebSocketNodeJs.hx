package haxe.net.impl;

import haxe.io.Bytes;
import haxe.net.WebSocket;
import haxe.extern.EitherType;

//By RAIDANDFADE. (yeah this was taken from haxicord, thank you raidandfade)
class WebSocketNodeJs extends WebSocket {
    private var impl:NodeJsWS;

    public function new(url:String, options = null) {
        super();

        impl = new NodeJsWS(url);

        impl.on("open",function(){
            this.onopen();
        });

        impl.on("close",function(c,r){
            this.onclose(c);
        });

        impl.on("error",function(e){
            this.onerror(e);
        });

        impl.on("message",function(e:EitherType< String, EitherType< js.node.buffer.Buffer, EitherType< js.lib.ArrayBuffer, Array< js.node.buffer.Buffer >>>>) {
            var m = e;
            if (Std.is(m, String)) {
                this.onmessageString(m);
            } else if (Std.is(m, js.lib.ArrayBuffer)) {
                //haxe.io.Int8Array
                //js.html.ArrayBuffer
                trace('Unhandled websocket onmessage ' + m);
            } else if (Std.is(m, js.node.Buffer)) {
                //i've got an idea :)
                //this.onmessageBytes(Bytes.ofData(m)); // <- Screw this
                var datas = "";
                datas += m;
                this.onmessageString(datas);
            } else {
                //ArrayBuffer but bigger
                trace('Unhandled websocket onmessage ' + m);
            }
        });
    }

    override public function sendString(message:String) {
        this.impl.send(message);
    }

    override public function sendBytes(message:Bytes) {
//	Separate message data, because 'message.getData().length' not equal 'message.length'
	// message = message.sub(0, message.length);
        this.impl.send(message.getData());
    }
	
	override public function close() {
		this.impl.close();
	}
	
	override function get_readyState():ReadyState {
		return switch(this.impl.readyState) {
    		case js.html.WebSocket.OPEN: ReadyState.Open;
			case js.html.WebSocket.CLOSED: ReadyState.Closed;
			case js.html.WebSocket.CLOSING: ReadyState.Closing;
			case js.html.WebSocket.CONNECTING: ReadyState.Connecting;
			default: throw 'Unexpected websocket state';
		}
	}
}