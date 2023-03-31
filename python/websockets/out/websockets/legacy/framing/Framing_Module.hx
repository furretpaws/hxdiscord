/* This file is generated, do not edit! */
package websockets.legacy.framing;
@:pythonImport("websockets.legacy.framing") extern class Framing_Module {
	/**
		Special type indicating an unconstrained type.
		
		- Any is compatible with every type.
		- Any assumed to have all methods.
		- All values assumed to be instances of Any.
		
		Note that all the above statements are true from the point of view of
		static type checkers. At runtime, Any should not be used with instance
		or class checks.
	**/
	static public function Any(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Awaitable.
	**/
	static public function Awaitable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Callable type; Callable[[int], str] is a function of (int) -> str.
		
		The subscription syntax must always be used with exactly two
		values: the argument list and the return type.  The argument list
		must be a list of types or ellipsis; the return type must be a single type.
		
		There is no syntax to indicate optional or keyword arguments,
		such function types are rarely used as callback types.
	**/
	static public function Callable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Typed version of namedtuple.
		
		Usage in Python versions >= 3.6::
		
		    class Employee(NamedTuple):
		        name: str
		        id: int
		
		This is equivalent to::
		
		    Employee = collections.namedtuple('Employee', ['name', 'id'])
		
		The resulting class has an extra __annotations__ attribute, giving a
		dict that maps field names to types.  (The field names are also in
		the _fields attribute, which is part of the namedtuple API.)
		Alternative equivalent keyword syntax is also accepted::
		
		    Employee = NamedTuple('Employee', name=str, id=int)
		
		In Python versions <= 3.5 use::
		
		    Employee = NamedTuple('Employee', [('name', str), ('id', int)])
	**/
	static public function NamedTuple(typename:Dynamic, ?fields:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
	static public function encode_data(data:Dynamic):Dynamic;
	/**
		Parse the payload from a close frame.
		
		Returns:
		    Tuple[int, str]: close code and reason.
		
		Raises:
		    ProtocolError: if data is ill-formed.
		    UnicodeDecodeError: if the reason isn't valid UTF-8.
	**/
	static public function parse_close(data:Dynamic):Dynamic;
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
	/**
		Serialize the payload for a close frame.
	**/
	static public function serialize_close(code:Dynamic, reason:Dynamic):Dynamic;
}