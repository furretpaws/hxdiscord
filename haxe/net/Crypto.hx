package haxe.net;

import haxe.io.Bytes;

#if python
@:pythonImport("os")
extern class RandomOs
{
	static public function urandom(count:Int):Array<Int>;
}
#end

class Crypto {
    // workaround for windows platform
    public static function getRandomString(length:Int, ?charactersToUse = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"): String
    {
        var str = "";
        for (i in 0...length){
            str += charactersToUse.charAt( Math.floor((Math.random() *  (Date.now().getTime() % (charactersToUse.length) ) )));
        }
        return str;
    }

}
