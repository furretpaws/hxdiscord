/* This file is generated, do not edit! */
package websockets.frames;
@:pythonImport("websockets.frames", "Frame") extern class Frame {
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
	public function ___init__(opcode:Dynamic, data:Dynamic, ?fin:Dynamic, ?rsv1:Dynamic, ?rsv2:Dynamic, ?rsv3:Dynamic):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(opcode:Dynamic, data:Dynamic, ?fin:Dynamic, ?rsv1:Dynamic, ?rsv2:Dynamic, ?rsv3:Dynamic):Void;
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
		Return a human-readable represention of a frame.
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
	/**
		Check that reserved bits and opcode have acceptable values.
		
		Raises:
		    ProtocolError: if a reserved bit or the opcode is invalid.
	**/
	public function check():Dynamic;
	static public var fin : Dynamic;
	/**
		Parse a WebSocket frame.
		
		This is a generator-based coroutine.
		
		Args:
		    read_exact: generator-based coroutine that reads the requested
		        bytes or raises an exception if there isn't enough data.
		    mask: whether the frame should be masked i.e. whether the read
		        happens on the server side.
		    max_size: maximum payload size in bytes.
		    extensions: list of extensions, applied in reverse order.
		
		Raises:
		    EOFError: if the connection is closed without a full WebSocket frame.
		    UnicodeDecodeError: if the frame contains invalid UTF-8.
		    PayloadTooBig: if the frame's payload size exceeds ``max_size``.
		    ProtocolError: if the frame contains incorrect values.
	**/
	static public function parse(read_exact:Dynamic, mask:Dynamic, ?max_size:Dynamic, ?extensions:Dynamic):Dynamic;
	static public var rsv1 : Dynamic;
	static public var rsv2 : Dynamic;
	static public var rsv3 : Dynamic;
	/**
		Serialize a WebSocket frame.
		
		Args:
		    mask: whether the frame should be masked i.e. whether the write
		        happens on the client side.
		    extensions: list of extensions, applied in order.
		
		Raises:
		    ProtocolError: if the frame contains incorrect values.
	**/
	public function serialize(mask:Dynamic, ?extensions:Dynamic):Dynamic;
}