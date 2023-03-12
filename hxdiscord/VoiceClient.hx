/**
    FOR ANYONE WHO'S READING THIS (i hope so)
    I'M HAVING SOME SERIOUS TROUBLES DOING THIS, COLLABORATIONS ARE HIGHLY APPRECIATED
    I MAY REMOVE THIS AND PRETEND NOTHING HAPPENED
**/

package hxdiscord;

import hxdiscord.net.WebSocketConnection;
import hxdiscord.DiscordClient;
import haxe.Timer;

class VoiceClient {
    var guild_id:String;
    var channel_id:String;
    var session_id:String;
    var websocket:WebSocketConnection;
    var hasCredentials:Bool = false;
    private var client:DiscordClient;
    var hb_interval:Int = 0;
    var user_id:String;
    var hb_timer:Timer;

    public function new(guild_id:String, channel_id:String, client:DiscordClient) {
        this.guild_id = guild_id;
        this.channel_id = channel_id;
        this.session_id = "";
        this.client = client;
        this.user_id = client.accId;
        trace("A new voice client instance has been created");
        trace("Awaiting for the gateway credentials..");
    }

    public function giveCredentials(d:Dynamic) {
        if (!hasCredentials) {
            trace("Credentials given!");
            trace("our credentials: " + haxe.Json.stringify(d));
            trace("session id: " + session_id);
            websocket = new WebSocketConnection("wss://" + d.endpoint);
            websocket.onMessage = (_) -> {
                var data:Dynamic = haxe.Json.parse(_);
                trace(_);
                switch (data.op) {
                    case 8: //hello
                        //here we have to send the payload thing
                        websocket.sendJson(
                            {
                                op: 0,
                                d: {
                                    server_id: this.guild_id,
                                    user_id: this.user_id,
                                    session_id: session_id,
                                    token: d.token
                                }
                            }
                        );
                        trace("DATA SENT?");
                }
            }
            websocket.onClose = (_) -> {
                trace(_);
            }
            websocket.onError = (_) -> {
                trace("errored " + _);
            }
            hasCredentials = true;
        }
        else {
            trace("Credentials have already been given");
        }
    }
}
