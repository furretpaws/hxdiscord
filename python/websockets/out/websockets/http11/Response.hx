/* This file is generated, do not edit! */
package websockets.http11;
@:pythonImport("websockets.http11", "Response") extern class Response {
	static public var __annotations__ : Dynamic;
	public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	static public var __dataclass_fields__ : Dynamic;
	static public var __dataclass_params__ : Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	static public var __dict__ : Dynamic;
	/**
		Default dir() implementation.
	**/
	public function __dir__():Dynamic;
	static public var __doc__ : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(other:Dynamic):Dynamic;
	/**
		Default object formatter.
	**/
	public function __format__(format_spec:Dynamic):Dynamic;
	/**
		Return self>=value.
	**/
	public function __ge__(value:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattribute__(name:Dynamic):Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	static public var __hash__ : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__(status_code:Dynamic, reason_phrase:Dynamic, headers:Dynamic, ?body:Dynamic, ?_exception:Dynamic):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(status_code:Dynamic, reason_phrase:Dynamic, headers:Dynamic, ?body:Dynamic, ?_exception:Dynamic):Void;
	/**
		This method is called when a class is subclassed.
		
		The default implementation does nothing. It may be
		overridden to extend subclasses.
	**/
	public function __init_subclass__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	static public var __match_args__ : Dynamic;
	static public var __module__ : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Helper for pickle.
	**/
	public function __reduce__():Dynamic;
	/**
		Helper for pickle.
	**/
	public function __reduce_ex__(protocol:Dynamic):Dynamic;
	/**
		Return repr(self).
	**/
	public function __repr__():Dynamic;
	/**
		Implement setattr(self, name, value).
	**/
	public function __setattr__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		Size of object in memory, in bytes.
	**/
	public function __sizeof__():Dynamic;
	/**
		Return str(self).
	**/
	public function __str__():Dynamic;
	/**
		Abstract classes can override this to customize issubclass().
		
		This is invoked early on by abc.ABCMeta.__subclasscheck__().
		It should return True, False or NotImplemented.  If it returns
		NotImplemented, the normal algorithm is used.  Otherwise, it
		overrides the normal algorithm (and the outcome is cached).
	**/
	public function __subclasshook__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	static public var _exception : Dynamic;
	static public var body : Dynamic;
	public var exception : Dynamic;
	/**
		Parse a WebSocket handshake response.
		
		This is a generator-based coroutine.
		
		The reason phrase and headers are expected to contain only ASCII
		characters. Other characters are represented with surrogate escapes.
		
		Args:
		    read_line: generator-based coroutine that reads a LF-terminated
		        line or raises an exception if there isn't enough data.
		    read_exact: generator-based coroutine that reads the requested
		        bytes or raises an exception if there isn't enough data.
		    read_to_eof: generator-based coroutine that reads until the end
		        of the stream.
		
		Raises:
		    EOFError: if the connection is closed without a full HTTP response.
		    SecurityError: if the response exceeds a security limit.
		    LookupError: if the response isn't well formatted.
		    ValueError: if the response isn't well formatted.
	**/
	static public function parse(read_line:Dynamic, read_exact:Dynamic, read_to_eof:Dynamic):Dynamic;
	/**
		Serialize a WebSocket handshake response.
	**/
	public function serialize():Dynamic;
}