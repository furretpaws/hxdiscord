/* This file is generated, do not edit! */
package websockets.client;
@:pythonImport("websockets.client") extern class Client_Module {
	static public var CLIENT : Dynamic;
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
	/**
		A generic version of collections.abc.Sequence.
	**/
	static public function Sequence(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function Subprotocol(x:Dynamic):Dynamic;
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
		Build an ``Authorization`` header for HTTP Basic Auth.
		
		This is the reverse of :func:`parse_authorization_basic`.
	**/
	static public function build_authorization_basic(username:Dynamic, password:Dynamic):Dynamic;
	/**
		Build a ``Sec-WebSocket-Extensions`` header.
		
		This is the reverse of :func:`parse_extension`.
	**/
	static public function build_extension(extensions:Dynamic):Dynamic;
	/**
		Build a ``Host`` header.
	**/
	static public function build_host(host:Dynamic, port:Dynamic, secure:Dynamic):Dynamic;
	/**
		Build a ``Sec-WebSocket-Protocol`` header.
		
		This is the reverse of :func:`parse_subprotocol`.
	**/
	static public function build_subprotocol(subprotocols:Dynamic):Dynamic;
	/**
		Generate a random key for the Sec-WebSocket-Key header.
	**/
	static public function generate_key():Dynamic;
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
		Similar to :func:`connect`, but for connecting to a Unix socket.
		
		This function builds upon the event loop's
		:meth:`~asyncio.loop.create_unix_connection` method.
		
		It is only available on Unix.
		
		It's mainly useful for debugging servers listening on Unix sockets.
		
		Args:
		    path: file system path to the Unix socket.
		    uri: URI of the WebSocket server; the host is used in the TLS
		        handshake for secure connections and in the ``Host`` header.
	**/
	static public function unix_connect(?path:Dynamic, ?uri:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
}