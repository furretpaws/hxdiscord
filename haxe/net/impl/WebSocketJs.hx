package haxe.net.impl;

import haxe.io.Bytes;
import haxe.net.WebSocket;
#if haxe4
import js.lib.ArrayBuffer;
#else
import js.html.ArrayBuffer;
#end

#if nodejs
// Please note that you need to have `websocket` module installed along with your nodejs app:
// https://github.com/theturtle32/WebSocket-Node
@:jsRequire('websocket', 'w3cwebsocket')
extern class W3CWebSocket extends js.html.WebSocket {}
#else
import js.html.WebSocket as W3CWebSocket;
#end

class WebSocketJs extends WebSocket {
	private var impl:W3CWebSocket;

	public function new(url:String, protocols:Array<String> = null) {
		super();

		if (protocols != null) {
			impl = new W3CWebSocket(url, protocols);
		} else {
			impl = new W3CWebSocket(url);
		}
		impl.onopen = function(e:js.html.Event) {
			this.onopen();
		};
		impl.onclose = function(e:js.html.Event) {
			this.onclose(e);
		};
		impl.onerror = function(e:js.html.Event) {
			this.onerror('error');
		};
		impl.onmessage = function(e:js.html.MessageEvent) {
			var m = e.data;
			if (Std.is(m, String)) {
				this.onmessageString(m);
			} else if (Std.is(m, ArrayBuffer)) {
				this.onmessageBytes(Bytes.ofData(cast (m,ArrayBuffer)));
			} else if (Std.is(m, js.html.Blob)) {
				var arrayBuffer:ArrayBuffer;
				var fileReader = new js.html.FileReader();
				fileReader.onload = function() {
					arrayBuffer = fileReader.result;
					this.onmessageBytes(Bytes.ofData(arrayBuffer));
				}
				fileReader.readAsArrayBuffer(cast(m, js.html.Blob));
			} else {
				// ArrayBuffer
				trace('Unhandled websocket onmessage ' + m);
			}
		};
	}

	override public function sendString(message:String) {
		this.impl.send(message);
	}

	override public function sendBytes(message:Bytes) {
		//	Separate message data, because 'message.getData().length' not equal 'message.length'
		message = message.sub(0, message.length);
		this.impl.send(message.getData());
	}

	override public function close() {
		this.impl.close();
	}

	override function get_readyState():ReadyState {
		return switch (this.impl.readyState) {
			case js.html.WebSocket.OPEN: ReadyState.Open;
			case js.html.WebSocket.CLOSED: ReadyState.Closed;
			case js.html.WebSocket.CLOSING: ReadyState.Closing;
			case js.html.WebSocket.CONNECTING: ReadyState.Connecting;
			default: throw 'Unexpected websocket state';
		}
	}
}
