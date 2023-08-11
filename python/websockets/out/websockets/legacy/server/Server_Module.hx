/* This file is generated, do not edit! */
package websockets.legacy.server;
@:pythonImport("websockets.legacy.server") extern class Server_Module {
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
	static public function ExtensionHeader(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Generator.
	**/
	static public function Generator(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function HTTPResponse(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function HeadersLike(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function HeadersLikeOrCallable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	static public function Origin(x:Dynamic):Dynamic;
	/**
		A generic version of collections.abc.Sequence.
	**/
	static public function Sequence(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of set.
	**/
	static public function Set(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
		Build a ``Sec-WebSocket-Extensions`` header.
		
		This is the reverse of :func:`parse_extension`.
	**/
	static public function build_extension(extensions:Dynamic):Dynamic;
	/**
		Build a handshake response to send to the client.
		
		Update response headers passed in argument.
		
		Args:
		    headers: handshake response headers.
		    key: returned by :func:`check_request`.
	**/
	static public function build_response(headers:Dynamic, key:Dynamic):Dynamic;
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
		Check a handshake request received from the client.
		
		This function doesn't verify that the request is an HTTP/1.1 or higher GET
		request and doesn't perform ``Host`` and ``Origin`` checks. These controls
		are usually performed earlier in the HTTP request handling code. They're
		the responsibility of the caller.
		
		Args:
		    headers: handshake request headers.
		
		Returns:
		    str: ``key`` that must be passed to :func:`build_response`.
		
		Raises:
		    InvalidHandshake: if the handshake request is invalid;
		        then the server must return 400 Bad Request error.
	**/
	static public function check_request(headers:Dynamic):Dynamic;
	/**
		Enable Per-Message Deflate with default settings in server extensions.
		
		If the extension is already present, perhaps with non-default settings,
		the configuration isn't changed.
	**/
	static public function enable_server_permessage_deflate(extensions:Dynamic):Dynamic;
	/**
		Helper for the removal of the loop argument in Python 3.10.
	**/
	static public function loop_if_py_lt_38(loop:Dynamic):Dynamic;
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
		Read an HTTP/1.1 GET request and return ``(path, headers)``.
		
		``path`` isn't URL-decoded or validated in any way.
		
		``path`` and ``headers`` are expected to contain only ASCII characters.
		Other characters are represented with surrogate escapes.
		
		:func:`read_request` doesn't attempt to read the request body because
		WebSocket handshake requests don't have one. If the request contains a
		body, it may be read from ``stream`` after this coroutine returns.
		
		Args:
		    stream: input to read the request from
		
		Raises:
		    EOFError: if the connection is closed without a full HTTP request
		    SecurityError: if the request exceeds a security limit
		    ValueError: if the request isn't well formatted
	**/
	static public function read_request(stream:Dynamic):Dynamic;
	static public function remove_path_argument(ws_handler:Dynamic):Dynamic;
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
	/**
		Validate that ``subprotocols`` is suitable for :func:`build_subprotocol`.
	**/
	static public function validate_subprotocols(subprotocols:Dynamic):Dynamic;
}