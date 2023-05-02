package haxe.websocket;

import sys.net.Socket as Socket;
import haxe.io.Bytes;
import sys.net.Host;
import sys.ssl.Socket as SocketSSL;
using StringTools;

class WebSocket {
    public var secure:Bool = false;
    public var alive:Bool = true;
    var state:State = State.Head;
    public var lastPong:Date;
    public var socketdata:BytesWS;
    public var payload:BytesWS = null;
    public var hostURL:String = "";
    @:noPrivateAccess
    public var path:String = "";
    public var socket:Socket;

    public function new(host:String) {
        if (!host.contains(":") || !host.contains("/")) {
            throw "Invalid URL";
        } else {
            var split = host.split(":");
            if (split[0] == "wss") {
                this.secure = true;
            } else if (split[0] == "ws") {
                this.secure = false;
            } else {
                throw "Invalid protocol";
            }
            if (host.contains("/")) {
                //it has a path then
                var split:String = host.split("/").slice(1).join(" ");
                path = split.replace(" ", "/");
            }
            var split:Array<String> = host.split("://");
            if (split[1].contains("/")) {
                var splitt:Array<String> = split[1].split("/");
                this.hostURL = splitt[0];
            } else {
                this.hostURL = split[1];
            }
            if (path.contains("/"+hostURL)) {
                var split = path.split("/"+hostURL);
                this.path = split[1];
            }
        }
        haxe.EntryPoint.addThread(p);
    }

    private function p() {
        socketdata = new BytesWS();
        if (secure) {
            socket = new SocketSSL();
            socket.connect(new Host(hostURL), 443);
        } else {
            socket = new Socket();
            socket.connect(new Host(hostURL), 80);
        }

        var bytes:Bytes = Bytes.ofString(Utils.generateInitialHandshake(this.secure, hostURL, path).toString());
        try {
            socket.output.writeFullBytes(bytes, 0, bytes.length);
        } catch (err:String) {
            onError(err);
            alive = false;
            this.socket.close();
        }
        var respond:Bool = false;
        var output:String = "";
        while (!respond) {
            try {
                var byteBuffer = Bytes.alloc(1024);
                var bytesRead:Int = socket.input.readBytes(byteBuffer, 0, 1024);
                var byteString = Bytes.alloc(bytesRead);
                byteString.blit(0, byteBuffer, 0, bytesRead);
                output = byteString.toString();

                if (output.length != 0) {
                    respond = true;
                }
            } catch (err) {
                trace(err);
                respond = true;
            }
        }
        if (output.contains("HTTP/1.1")) {
            var statusCode:Int = Std.parseInt(output.split("\r\n")[0].split(" ")[1]);
            if (statusCode != 101) {
                onError("Handshake Error: Status code isn't 101. Full response: \n\n" + output);
                this.socket.close();
                alive = false;
            } else {
                haxe.EntryPoint.runInMainThread(onOpen);
                handleBytes();
            }
        }
        var out = new BytesWS();
		try {
			var input = this.socket.input;
			while (alive) {
				var data = Bytes.alloc(1024);
				var readed = input.readBytes(data, 0, data.length);
				if (readed <= 0) break;
				out.writeBytes(data.sub(0, readed));
                var bytes:Bytes = out.readAllAvailableBytes();
		        if (bytes.length != 0) {
                    socketdata.writeBytes(bytes);
                    handleBytes();
                }
			}
		} catch (e:String) {
			onError(e);
            alive = false;
            this.socket.close();
		}
    }

    var opcode:Opcode;
    var isMasked:Bool;
    var frameIsBinary:Bool = false;
    var mask:Bytes;
    var partialLength:Int;
    var length:Int;
    var isFinal:Bool;
    private function handleBytes() {
            if (payload == null) payload = new BytesWS();
            var tempBytes = new BytesWS();
            switch (state) {
                case State.Head:
                    if (socketdata.available < 2) return;
                    
                    var b0 = socketdata.readByte();
                    var b1 = socketdata.readByte();

                    isFinal = ((b0 >> 7) & 1) != 0;
                    opcode = cast(((b0 >> 0) & 0xF), Opcode);
                    frameIsBinary = if (opcode == Opcode.Text) false; else if (opcode == Opcode.Binary) true; else frameIsBinary;
                    partialLength = ((b1 >> 0) & 0x7F);
                    isMasked = ((b1 >> 7) & 1) != 0;

                    this.state = State.HeadExtraLength;
                    handleBytes();
                case State.HeadExtraLength:
                    if (partialLength == 126) {
                        if (socketdata.available < 2) return;
                        length = socketdata.readUnsignedShort();
                    } else if (partialLength == 127) {
                        if (socketdata.available < 8) return;
                        var tmp = socketdata.readUnsignedInt();
                        if(tmp != 0) throw 'message too long';
                        length = socketdata.readUnsignedInt();
                    } else {
                        length = partialLength;
                    }
                    this.state = State.HeadExtraMask;
                    handleBytes();
                case State.HeadExtraMask:
                    if (isMasked) {
                        if (socketdata.available < 4) return;
                        mask = socketdata.readBytes(4);
                    }
                    this.state = State.Body;
                    handleBytes();
                case State.Body:
                    if (socketdata.available < length) return;
                    payload.writeBytes(socketdata.readBytes(length));

                    switch (opcode) {
                        case Opcode.Binary | Opcode.Text | Opcode.Continuation:
                            if (isFinal) {
                                var messageData = payload.readAllAvailableBytes();
                                var unmakedMessageData = (isMasked) ? applyMask(messageData, mask) : messageData;
                                if (frameIsBinary) {
                                    //TODO
                                } else {
                                    haxe.EntryPoint.runInMainThread(this.onStringData.bind(Utf8Encoder.decode(unmakedMessageData)));
                                }
                                payload = null;
                            }
                        case Opcode.Ping:
                            //onPing.dispatch(null);
                            sendFrame(payload.readAllAvailableBytes(), Opcode.Pong);
                        case Opcode.Pong:
                            //onPong.dispatch(null);
                            lastPong = Date.now();
                        case Opcode.Close:
                            var b1 = payload.readByte();
                            var b2 = payload.readByte();
                            var code = (b1<<8) + (b2);
                            haxe.MainLoop.runInMainThread(onClose.bind(code));
                            alive = false;
                            try {
                                socket.close();
                            } catch(_:Dynamic) {}
                    }
                    if(this.state != State.Closed) this.state = State.Head;
                default:
                    return;
            }
    }

    public function writeBytes(bytes:Bytes) {
        try {
            socket.output.write(bytes);
            socket.output.flush();
        } catch (err:String) {
            onError("An error has occurred while write data to the WebSocket. " + err);
            alive = false;
            this.socket.close();
        }
    }

    public function sendString(message:String) {
        try {
            if (!alive) {
                haxe.MainLoop.runInMainThread(onClose.bind(1011));
                alive = false;
                this.socket.close();
            } else {
                sendFrame(Utf8Encoder.encode(message), Opcode.Binary);
            }
        } catch (err:String) {
            onError(err);
            alive = false;
            this.socket.close();
        }
    }

    public function send(bytes:Bytes) {
        try {
            if (!alive) {
                haxe.MainLoop.runInMainThread(onClose.bind(1011));
                alive = false;
                this.socket.close();
            } else {
                sendFrame(bytes, Opcode.Binary);
            }
        } catch (err:String) {
            onError(err);
            alive = false;
            this.socket.close();
        }
    }

    private function prepareFrame(data:Bytes, type:Opcode, isFinal:Bool):Bytes {
        var out = new BytesWS();

        //Chrome: VM321:1 WebSocket connection to 'ws://localhost:8000/' failed: A server must not mask any frames that it sends to the client.
        var isMasked = true; //false; // All clients messages must be masked: http://tools.ietf.org/html/rfc6455#section-5.1
        var mask = generateMask();
        var sizeMask = (isMasked ? 0x80 : 0x00);

        @:privateAccess
        out.writeByte(type.toInt() | (isFinal ? 0x80 : 0x00));

        if (data.length < 126) {
            out.writeByte(data.length | sizeMask);
        } else if (data.length < 65536) {
            out.writeByte(126 | sizeMask);
            out.writeShort(data.length);
        } else {
            out.writeByte(127 | sizeMask);
            out.writeInt(0);
            out.writeInt(data.length);
        }

        if (isMasked) out.writeBytes(mask);

        out.writeBytes(isMasked ? applyMask(data, mask) : data);
        return out.readAllAvailableBytes();
    }

    public function sendFrame(data:Bytes, opcode:Opcode) {
        writeBytes(prepareFrame(data, opcode, true));
    }

    static private function generateMask() {
        var maskData = Bytes.alloc(4);
        maskData.set(0, Std.random(256));
        maskData.set(1, Std.random(256));
        maskData.set(2, Std.random(256));
        maskData.set(3, Std.random(256));
        return maskData;
    }

    static private function applyMask(payload:Bytes, mask:Bytes) {
        var maskedPayload = Bytes.alloc(payload.length);
        for (n in 0 ... payload.length) maskedPayload.set(n, payload.get(n) ^ mask.get(n % mask.length));
        return maskedPayload;
    }

    public function close(code:Int) {
        haxe.MainLoop.runInMainThread(onClose.bind(code));
        alive = false;
        this.socket.close();
    }

    dynamic public function onStringData(d:String) {

    }

    dynamic public function onClose(code:Int) {

    }

    dynamic public function onOpen() {

    }

    dynamic public function onError(err:String) {

    }
}

@:enum abstract Opcode(Int) {
    var Continuation = 0;
    var Text = 1;
    var Binary = 2;
    var Close = 8;
    var Ping = 9;
    var Pong = 0x0A;

    @:to function toInt() {
        return this;
    }
}

class Utils {
    public static function generateInitialHandshake(secure:Bool, host:String, ?path:String):StringBuf {
        var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890±!@#$%^&*()_+-=";
        var key:String = "";
        var encryptedKey:String = "";
        for (i in 0...24) {
            key += chars.split("")[Std.random(chars.split("").length)];
        }
        encryptedKey = haxe.crypto.Base64.encode(haxe.io.Bytes.ofString(key));
        var socketRequest:StringBuf = new StringBuf();
        if (path == null || path == "") {
            socketRequest.add("GET / HTTP/1.1\r\n");
        } else {
            socketRequest.add("GET " + path + " HTTP/1.1\r\n");
        }
        if (secure) {
            socketRequest.add("Host: " + host + ":443\r\n");
        } else {
            socketRequest.add("Host: " + host + ":80\r\n");
        }
        socketRequest.add("User-Agent: hxws\r\n");
        socketRequest.add("Upgrade: websocket\r\n");
        socketRequest.add("Sec-WebSocket-Version: 13\r\n");
        socketRequest.add("Sec-WebSocket-Key: " + encryptedKey + "\r\n");
        socketRequest.add("Pragma: no-cache\r\n");
        socketRequest.add("Connection: upgrade\r\n");
        socketRequest.add("Cache-Control: no-cache\r\n\r\n");

        return socketRequest;
    }
}

class Utf8Encoder {
    static public function encode(str:String):Bytes {
        // @TODO: Proper utf8 encoding!
        return Bytes.ofString(str);
    }

    static public function decode(data:Bytes):String {
        // @TODO: Proper utf8 decoding!
        return data.toString();
    }
}


enum State {
    Handshake;
    ServerHandshake;
    Head;
    HeadExtraLength;
    HeadExtraMask;
    Body;
    Closed;
}