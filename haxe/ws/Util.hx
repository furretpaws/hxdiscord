package haxe.ws;
import haxe.ws.uuid.Uuid;

class Util {
    public static function generateUUID():String {
        return Uuid.v1();
    }
}