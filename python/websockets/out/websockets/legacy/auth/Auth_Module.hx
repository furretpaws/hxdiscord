/* This file is generated, do not edit! */
package websockets.legacy.auth;
@:pythonImport("websockets.legacy.auth") extern class Auth_Module {
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
	static public function Credentials(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function HTTPResponse(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Iterable.
	**/
	static public function Iterable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
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
		Build a ``WWW-Authenticate`` header for HTTP Basic Auth.
		
		Args:
		    realm: identifier of the protection space.
	**/
	static public function build_www_authenticate_basic(realm:Dynamic):Dynamic;
	/**
		Cast a value to a type.
		
		This returns the value unchanged.  To the type checker this
		signals that the return value has the designated type, but at
		runtime we intentionally don't check anything (we want this
		to be as fast as possible).
	**/
	@:native("cast")
	static public function _cast(typ:Dynamic, val:Dynamic):Dynamic;
	static public function is_credentials(value:Dynamic):Dynamic;
	/**
		Parse an ``Authorization`` header for HTTP Basic Auth.
		
		Return a ``(username, password)`` tuple.
		
		Args:
		    header: value of the ``Authorization`` header.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
		    InvalidHeaderValue: on unsupported inputs.
	**/
	static public function parse_authorization_basic(header:Dynamic):Dynamic;
}