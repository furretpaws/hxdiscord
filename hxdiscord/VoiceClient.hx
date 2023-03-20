/**
    FOR ANYONE WHO'S READING THIS (i hope so)
    I'M HAVING SOME SERIOUS TROUBLES DOING THIS, COLLABORATIONS ARE HIGHLY APPRECIATED
    I MAY REMOVE THIS AND MAKE AS IF NOTHING HAPPENED

    NOTE (12/03/2023): Don't expect this to be done in a few months or so. I just found out that Discord requires RTP packets, and there are no haxelibs available for it. So I will have to take my own on this
**/

package hxdiscord;

import hxdiscord.net.WebSocketConnection;
import hxdiscord.DiscordClient;
import sys.net.Host;
import sys.FileSystem;
import sys.io.File;
import haxe.Timer;
import sys.net.Address;
import sys.net.UdpSocket;

using StringTools;

class VoiceClient {
    var guild_id:String;
    var channel_id:String;
    var session_id:String;
    var websocket:WebSocketConnection;
    var hasCredentials:Bool = false;
    private var client:DiscordClient;
    var buf = haxe.io.Bytes.alloc(1024);
    var hb_interval:Int = 0;
    var user_id:String;
    var hb_timer:Timer;
    var udpConnection:UdpSocket;
    var ip:String = "";
    var port:Int = 0;
    var addr:Address;

    public function new(guild_id:String, channel_id:String, user_id:String) {
        this.guild_id = guild_id;
        this.channel_id = channel_id;
        this.session_id = "";
        this.user_id = user_id;
        /*trace("A new voice client instance has been created");
        trace("Awaiting for the gateway credentials..");*/
    }

    public function giveCredentials(d:Dynamic) {
        if (!hasCredentials) {
            /*trace("Credentials given!");
            trace("our credentials: " + haxe.Json.stringify(d));
            trace("session id: " + session_id);*/
            websocket = new WebSocketConnection("wss://" + d.endpoint);
            websocket.onMessage = (_) -> {
                var data:Dynamic = haxe.Json.parse(_);
                trace(_);
                switch (data.op) {
                    case 8: //hello
                        //here we have to send the payload thing
                        /*trace(this.session_id);
                        trace(this.guild_id);
                        trace(this.user_id);
                        trace(this.session_id);*/
                        hb_interval = data.d.heartbeat_interval;
                        websocket.sendJson(
                            {
                                op: 0,
                                d: {
                                    server_id: this.guild_id,
                                    user_id: this.user_id,
                                    session_id: this.session_id,
                                    token: d.token
                                }
                            }
                        );
                        hb_timer = new Timer(this.hb_interval);
                        hb_timer.run = function()
                        {
                            websocket.send(haxe.Json.stringify({
                                op: 8,
                                d: null
                            }));
                        }
                        //trace("DATA SENT?");
                    case 2:
                        ip = data.d.ip;
                        port = data.d.port;
                        websocket.sendJson({
                            op: 1,
                            d: {
                                protocol: "udp",
                                data: {
                                    address: data.d.ip,
                                    port: data.d.port,
                                    mode: "xsalsa20_poly1305_lite"
                                }
                            }
                        });
                    case 4:
                        udpConnection = new UdpSocket();

                        udpConnection.connect(new Host(ip), port);
                        trace("Connected to the server");

                        addr = new Address();
                        addr.host = Std.parseInt(ip);
                        addr.port = port;

                }
            }
            websocket.onClose = (_) -> {
                trace(_);
                this.destroy();
            }
            websocket.onError = (_) -> {
                trace("errored " + _);
                this.destroy();
            }
            hasCredentials = true;
        }
        else {
            trace("Credentials have already been given");
        }
    }

    public function play(path:String) {
        if (!FileSystem.exists(path)) {
            trace("The path of the file you have specified does not exist.");
        } else {
            if (!path.endsWith(".ogg")) {
                throw "[!] WARNING [!]\nPlaying files in hxdiscord for now it's a beta thing. You can only play .ogg files for now.";
            }
            else {
                trace("a");
                websocket.sendJson({
                    op: 5,
                    d: {
                        speaking: 5,
                        delay: 0,
                        ssrc: 1
                    }
                });

                /*var fileBytes = File.getBytes(path);
                var size = FileSystem.stat(path).size;

                var buf = haxe.io.Bytes.alloc(12 + size);
                buf.set(0, 0x80); // Versión: 2 (10), Padding: 0, Extension: 0, CSRC count: 0 (0000)
                buf.set(1, 0x78); // Marker: 0, Payload type: 120 (01111000) - perfil dinámico
                buf.setUInt16(2, 1); // Sequence number: 1
                buf.setInt32(4, 123456789); // Timestamp: algún valor arbitrario
                buf.setInt32(8, 987654321); // SSRC identifier: algún valor arbitrario

                fileBytes.blit(0, buf, 12, size);
                var len = udpConnection.sendTo(buf, 0, buf.length, addr);
                trace("Se enviaron " + len + " bytes");*/
            }
        }
    }

    public function destroy() {
        this.websocket.close();
        this.websocket = null;
        this.hb_timer.stop();
    }
}