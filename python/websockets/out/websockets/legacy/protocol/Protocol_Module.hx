/* This file is generated, do not edit! */
package websockets.legacy.protocol;
@:pythonImport("websockets.legacy.protocol") extern class Protocol_Module {
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
		A generic version of collections.abc.AsyncIterable.
	**/
	static public function AsyncIterable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.AsyncIterator.
	**/
	static public function AsyncIterator(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
	static public function Data(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.deque.
	**/
	static public function Deque(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of dict.
	**/
	static public function Dict(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Iterable.
	**/
	static public function Iterable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of list.
	**/
	static public function List(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function LoggerLike(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Mapping.
	**/
	static public function Mapping(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
	static public function Subprotocol(x:Dynamic):Dynamic;
	/**
		Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
		
		Example: Tuple[T1, T2] is a tuple of two elements corresponding
		to type variables T1 and T2.  Tuple[int, float, str] is a tuple
		of an int, a float and a string.
		
		To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
	**/
	static public function Tuple(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Union type; Union[X, Y] means either X or Y.
		
		To define a union, use e.g. Union[int, str].  Details:
		- The arguments must be types and there must be at least one.
		- None as an argument is a special case and is replaced by
		  type(None).
		- Unions of unions are flattened, e.g.::
		
		    Union[Union[int, str], float] == Union[int, str, float]
		
		- Unions of a single argument vanish, e.g.::
		
		    Union[int] == int  # The constructor actually returns int
		
		- Redundant arguments are skipped, e.g.::
		
		    Union[int, str, int] == Union[int, str]
		
		- When comparing unions, the argument order is ignored, e.g.::
		
		    Union[int, str] == Union[str, int]
		
		- You cannot subclass or instantiate a union.
		- You can use Optional[X] as a shorthand for Union[X, None].
	**/
	static public function Union(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
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
		Broadcast a message to several WebSocket connections.
		
		A string (:class:`str`) is sent as a Text_ frame. A bytestring or
		bytes-like object (:class:`bytes`, :class:`bytearray`, or
		:class:`memoryview`) is sent as a Binary_ frame.
		
		.. _Text: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.6
		.. _Binary: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.6
		
		:func:`broadcast` pushes the message synchronously to all connections even
		if their write buffers are overflowing. There's no backpressure.
		
		:func:`broadcast` skips silently connections that aren't open in order to
		avoid errors on connections where the closing handshake is in progress.
		
		If you broadcast messages faster than a connection can handle them,
		messages will pile up in its write buffer until the connection times out.
		Keep low values for ``ping_interval`` and ``ping_timeout`` to prevent
		excessive memory usage by slow connections when you use :func:`broadcast`.
		
		Unlike :meth:`~websockets.server.WebSocketServerProtocol.send`,
		:func:`broadcast` doesn't support sending fragmented messages. Indeed,
		fragmentation is useful for sending large messages without buffering
		them in memory, while :func:`broadcast` buffers one copy per connection
		as fast as possible.
		
		Args:
		    websockets (Iterable[WebSocketCommonProtocol]): WebSocket connections
		        to which the message will be sent.
		    message (Data): message to send.
		
		Raises:
		    RuntimeError: if a connection is busy sending a fragmented message.
		    TypeError: if ``message`` doesn't have a supported type.
	**/
	static public function broadcast(websockets:Dynamic, message:Dynamic):Dynamic;
	/**
		Cast a value to a type.
		
		This returns the value unchanged.  To the type checker this
		signals that the return value has the designated type, but at
		runtime we intentionally don't check anything (we want this
		to be as fast as possible).
	**/
	@:native("cast")
	static public function _cast(typ:Dynamic, val:Dynamic):Dynamic;
	/**
		Helper for the removal of the loop argument in Python 3.10.
	**/
	static public function loop_if_py_lt_38(loop:Dynamic):Dynamic;
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