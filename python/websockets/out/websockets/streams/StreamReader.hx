/* This file is generated, do not edit! */
package websockets.streams;
@:pythonImport("websockets.streams", "StreamReader") extern class StreamReader {
	public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
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
	public function __eq__(value:Dynamic):Dynamic;
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
	/**
		Return hash(self).
	**/
	public function __hash__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new():Void;
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
	/**
		Tell whether the stream has ended and all data was read.
		
		This is a generator-based coroutine.
	**/
	public function at_eof():Dynamic;
	/**
		Discard all buffered data, but don't end the stream.
	**/
	public function discard():Dynamic;
	/**
		Write data to the stream.
		
		:meth:`feed_data` cannot be called after :meth:`feed_eof`.
		
		Args:
		    data: data to write.
		
		Raises:
		    EOFError: if the stream has ended.
	**/
	public function feed_data(data:Dynamic):Dynamic;
	/**
		End the stream.
		
		:meth:`feed_eof` cannot be called more than once.
		
		Raises:
		    EOFError: if the stream has ended.
	**/
	public function feed_eof():Dynamic;
	/**
		Read a given number of bytes from the stream.
		
		This is a generator-based coroutine.
		
		Args:
		    n: how many bytes to read.
		
		Raises:
		    EOFError: if the stream ends in less than ``n`` bytes.
	**/
	public function read_exact(n:Dynamic):Dynamic;
	/**
		Read a LF-terminated line from the stream.
		
		This is a generator-based coroutine.
		
		The return value includes the LF character.
		
		Args:
		    m: maximum number bytes to read; this is a security limit.
		
		Raises:
		    EOFError: if the stream ends without a LF.
		    RuntimeError: if the stream ends in more than ``m`` bytes.
	**/
	public function read_line(m:Dynamic):Dynamic;
	/**
		Read all bytes from the stream.
		
		This is a generator-based coroutine.
		
		Args:
		    m: maximum number bytes to read; this is a security limit.
		
		Raises:
		    RuntimeError: if the stream ends in more than ``m`` bytes.
	**/
	public function read_to_eof(m:Dynamic):Dynamic;
}