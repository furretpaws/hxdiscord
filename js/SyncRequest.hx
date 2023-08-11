package js;

#if (js&&nodejs)
@:jsRequire("sync-request")

extern class SyncRequest {
    public function new(method:String, url:String, ?options:Dynamic):Void;
    public var body:String;
    public var headers:Map<String, String>;
    public var statusCode:Int;
    public var statusMessage:String;
    public function getBody():String;
}
#end