/* This file is generated, do not edit! */
package websockets.server;
@:pythonImport("websockets.server") extern class Server_Module {
	static public var CONNECTING : Dynamic;
	static public function ConnectionOption(x:Dynamic):Dynamic;
	static public function ExtensionHeader(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Generator.
	**/
	static public function Generator(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of list.
	**/
	static public function List(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function LoggerLike(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var OPEN : Dynamic;
	/**
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	static public function Origin(x:Dynamic):Dynamic;
	static public var SERVER : Dynamic;
	/**
		A generic version of collections.abc.Sequence.
	**/
	static public function Sequence(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function Subprotocol(x:Dynamic):Dynamic;
	/**
		Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
		
		Example: Tuple[T1, T2] is a tuple of two elements corresponding
		to type variables T1 and T2.  Tuple[int, float, str] is a tuple
		of an int, a float and a string.
		
		To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
	**/
	static public function Tuple(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function UpgradeProtocol(x:Dynamic):Dynamic;
	static public var __all__ : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Compute the value of the Sec-WebSocket-Accept header.
		
		Args:
		    key: value of the Sec-WebSocket-Key header.
	**/
	static public function accept_key(key:Dynamic):Dynamic;
	static public var annotations : Dynamic;
	/**
		Build a ``Sec-WebSocket-Extensions`` header.
		
		This is the reverse of :func:`parse_extension`.
	**/
	static public function build_extension(extensions:Dynamic):Dynamic;
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
		Parse a ``Connection`` header.
		
		Return a list of HTTP connection options.
		
		Args
		    header: value of the ``Connection`` header.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_connection(header:Dynamic):Dynamic;
	/**
		Parse a ``Sec-WebSocket-Extensions`` header.
		
		Return a list of WebSocket extensions and their parameters in this format::
		
		    [
		        (
		            'extension name',
		            [
		                ('parameter name', 'parameter value'),
		                ....
		            ]
		        ),
		        ...
		    ]
		
		Parameter values are :obj:`None` when no value is provided.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_extension(header:Dynamic):Dynamic;
	/**
		Parse a ``Sec-WebSocket-Protocol`` header.
		
		Return a list of WebSocket subprotocols.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_subprotocol(header:Dynamic):Dynamic;
	/**
		Parse an ``Upgrade`` header.
		
		Return a list of HTTP protocols.
		
		Args:
		    header: value of the ``Upgrade`` header.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_upgrade(header:Dynamic):Dynamic;
	/**
		Similar to :func:`serve`, but for listening on Unix sockets.
		
		This function builds upon the event
		loop's :meth:`~asyncio.loop.create_unix_server` method.
		
		It is only available on Unix.
		
		It's useful for deploying a server behind a reverse proxy such as nginx.
		
		Args:
		    path: file system path to the Unix socket.
	**/
	static public function unix_serve(ws_handler:Dynamic, ?path:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
}