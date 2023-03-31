/* This file is generated, do not edit! */
package websockets.frames;
@:pythonImport("websockets.frames") extern class Frames_Module {
	static public var BytesLike : Dynamic;
	static public var CLOSE_CODES : Dynamic;
	static public var CTRL_OPCODES : Dynamic;
	/**
		Callable type; Callable[[int], str] is a function of (int) -> str.
		
		The subscription syntax must always be used with exactly two
		values: the argument list and the return type.  The argument list
		must be a list of types or ellipsis; the return type must be a single type.
		
		There is no syntax to indicate optional or keyword arguments,
		such function types are rarely used as callback types.
	**/
	static public function Callable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var DATA_OPCODES : Dynamic;
	static public function Data(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var EXTERNAL_CLOSE_CODES : Dynamic;
	/**
		A generic version of collections.abc.Generator.
	**/
	static public function Generator(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var OK_CLOSE_CODES : Dynamic;
	static public var OP_BINARY : Dynamic;
	static public var OP_CLOSE : Dynamic;
	static public var OP_CONT : Dynamic;
	static public var OP_PING : Dynamic;
	static public var OP_PONG : Dynamic;
	static public var OP_TEXT : Dynamic;
	/**
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Sequence.
	**/
	static public function Sequence(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
		
		Example: Tuple[T1, T2] is a tuple of two elements corresponding
		to type variables T1 and T2.  Tuple[int, float, str] is a tuple
		of an int, a float and a string.
		
		To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
	**/
	static public function Tuple(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var __all__ : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var annotations : Dynamic;
	/**
		Apply masking to the data of a WebSocket message.
	**/
	static public function apply_mask(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Convert a string or byte-like object to bytes.
		
		This function is designed for ping and pong frames.
		
		If ``data`` is a :class:`str`, return a :class:`bytes` object encoding
		``data`` in UTF-8.
		
		If ``data`` is a bytes-like object, return a :class:`bytes` object.
		
		Raises:
		    TypeError: if ``data`` doesn't have a supported type.
	**/
	static public function prepare_ctrl(data:Dynamic):Dynamic;
	/**
		Convert a string or byte-like object to an opcode and a bytes-like object.
		
		This function is designed for data frames.
		
		If ``data`` is a :class:`str`, return ``OP_TEXT`` and a :class:`bytes`
		object encoding ``data`` in UTF-8.
		
		If ``data`` is a bytes-like object, return ``OP_BINARY`` and a bytes-like
		object.
		
		Raises:
		    TypeError: if ``data`` doesn't have a supported type.
	**/
	static public function prepare_data(data:Dynamic):Dynamic;
}