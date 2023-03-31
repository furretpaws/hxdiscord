/* This file is generated, do not edit! */
package websockets;
@:pythonImport("websockets") extern class Websockets_Module {
	static public function Data(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function ExtensionHeader(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function ExtensionParameter(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function LoggerLike(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function Origin(x:Dynamic):Dynamic;
	static public function Subprotocol(x:Dynamic):Dynamic;
	static public var __all__ : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __path__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var __version__ : Dynamic;
	static public var annotations : Dynamic;
	/**
		Protocol factory that enforces HTTP Basic Auth.
		
		:func:`basic_auth_protocol_factory` is designed to integrate with
		:func:`~websockets.server.serve` like this::
		
		    websockets.serve(
		        ...,
		        create_protocol=websockets.basic_auth_protocol_factory(
		            realm="my dev server",
		            credentials=("hello", "iloveyou"),
		        )
		    )
		
		Args:
		    realm: indicates the scope of protection. It should contain only ASCII
		        characters because the encoding of non-ASCII characters is
		        undefined. Refer to section 2.2 of :rfc:`7235` for details.
		    credentials: defines hard coded authorized credentials. It can be a
		        ``(username, password)`` pair or a list of such pairs.
		    check_credentials: defines a coroutine that verifies credentials.
		        This coroutine receives ``username`` and ``password`` arguments
		        and returns a :class:`bool`. One of ``credentials`` or
		        ``check_credentials`` must be provided but not both.
		    create_protocol: factory that creates the protocol. By default, this
		        is :class:`BasicAuthWebSocketServerProtocol`. It can be replaced
		        by a subclass.
		Raises:
		    TypeError: if the ``credentials`` or ``check_credentials`` argument is
		        wrong.
	**/
	static public function basic_auth_protocol_factory(?realm:Dynamic, ?credentials:Dynamic, ?check_credentials:Dynamic, ?create_protocol:Dynamic):Dynamic;
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
		Provide lazy, module-level imports.
		
		Typical use::
		
		    __getattr__, __dir__ = lazy_import(
		        globals(),
		        aliases={
		            "<name>": "<source module>",
		            ...
		        },
		        deprecated_aliases={
		            ...,
		        }
		    )
		
		This function defines ``__getattr__`` and ``__dir__`` per :pep:`562`.
	**/
	static public function lazy_import(namespace:Dynamic, ?aliases:Dynamic, ?deprecated_aliases:Dynamic):Dynamic;
	/**
		Parse and validate a WebSocket URI.
		
		Args:
		    uri: WebSocket URI.
		
		Returns:
		    WebSocketURI: Parsed WebSocket URI.
		
		Raises:
		    InvalidURI: if ``uri`` isn't a valid WebSocket URI.
	**/
	static public function parse_uri(uri:Dynamic):Dynamic;
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