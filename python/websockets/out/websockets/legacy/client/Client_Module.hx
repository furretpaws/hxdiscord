/* This file is generated, do not edit! */
package websockets.legacy.client;
@:pythonImport("websockets.legacy.client") extern class Client_Module {
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
		A generic version of collections.abc.AsyncIterator.
	**/
	static public function AsyncIterator(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Callable type; Callable[[int], str] is a function of (int) -> str.
		
		The subscription syntax must always be used with exactly two
		values: the argument list and the return type.  The argument list
		must be a list of types or ellipsis; the return type must be a single type.
		
		There is no syntax to indicate optional or keyword arguments,
		such function types are rarely used as callback types.
	**/
	static public function Callable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function ExtensionHeader(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Generator.
	**/
	static public function Generator(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function HeadersLike(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of list.
	**/
	static public function List(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function LoggerLike(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
	/**
		Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
		
		Example: Tuple[T1, T2] is a tuple of two elements corresponding
		to type variables T1 and T2.  Tuple[int, float, str] is a tuple
		of an int, a float and a string.
		
		To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
	**/
	static public function Tuple(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A special construct usable to annotate class objects.
		
		For example, suppose we have the following classes::
		
		  class User: ...  # Abstract base for User classes
		  class BasicUser(User): ...
		  class ProUser(User): ...
		  class TeamUser(User): ...
		
		And a function that takes a class argument that's a subclass of
		User and returns an instance of the corresponding class::
		
		  U = TypeVar('U', bound=User)
		  def new_user(user_class: Type[U]) -> U:
		      user = user_class()
		      # (Here we could write the user object to a database)
		      return user
		
		  joe = new_user(BasicUser)
		
		At this point the type checker knows that joe has type BasicUser.
	**/
	static public function Type(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var USER_AGENT : Dynamic;
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
		Build a handshake request to send to the server.
		
		Update request headers passed in argument.
		
		Args:
		    headers: handshake request headers.
		
		Returns:
		    str: ``key`` that must be passed to :func:`check_response`.
	**/
	static public function build_request(headers:Dynamic):Dynamic;
	/**
		Build a ``Sec-WebSocket-Protocol`` header.
		
		This is the reverse of :func:`parse_subprotocol`.
	**/
	static public function build_subprotocol(subprotocols:Dynamic):Dynamic;
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
		Check a handshake response received from the server.
		
		This function doesn't verify that the response is an HTTP/1.1 or higher
		response with a 101 status code. These controls are the responsibility of
		the caller.
		
		Args:
		    headers: handshake response headers.
		    key: returned by :func:`build_request`.
		
		Raises:
		    InvalidHandshake: if the handshake response is invalid.
	**/
	static public function check_response(headers:Dynamic, key:Dynamic):Dynamic;
	/**
		Enable Per-Message Deflate with default settings in client extensions.
		
		If the extension is already present, perhaps with non-default settings,
		the configuration isn't changed.
	**/
	static public function enable_client_permessage_deflate(extensions:Dynamic):Dynamic;
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
		Read an HTTP/1.1 response and return ``(status_code, reason, headers)``.
		
		``reason`` and ``headers`` are expected to contain only ASCII characters.
		Other characters are represented with surrogate escapes.
		
		:func:`read_request` doesn't attempt to read the response body because
		WebSocket handshake responses don't have one. If the response contains a
		body, it may be read from ``stream`` after this coroutine returns.
		
		Args:
		    stream: input to read the response from
		
		Raises:
		    EOFError: if the connection is closed without a full HTTP response
		    SecurityError: if the response exceeds a security limit
		    ValueError: if the response isn't well formatted
	**/
	static public function read_response(stream:Dynamic):Dynamic;
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
		Validate that ``subprotocols`` is suitable for :func:`build_subprotocol`.
	**/
	static public function validate_subprotocols(subprotocols:Dynamic):Dynamic;
}