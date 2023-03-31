/* This file is generated, do not edit! */
package websockets.headers;
@:pythonImport("websockets.headers") extern class Headers_Module {
	/**
		Callable type; Callable[[int], str] is a function of (int) -> str.
		
		The subscription syntax must always be used with exactly two
		values: the argument list and the return type.  The argument list
		must be a list of types or ellipsis; the return type must be a single type.
		
		There is no syntax to indicate optional or keyword arguments,
		such function types are rarely used as callback types.
	**/
	static public function Callable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function ConnectionOption(x:Dynamic):Dynamic;
	static public function ExtensionHeader(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function ExtensionName(x:Dynamic):Dynamic;
	static public function ExtensionParameter(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of list.
	**/
	static public function List(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Sequence.
	**/
	static public function Sequence(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function Subprotocol(x:Dynamic):Dynamic;
	static public var T : Dynamic;
	/**
		Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
		
		Example: Tuple[T1, T2] is a tuple of two elements corresponding
		to type variables T1 and T2.  Tuple[int, float, str] is a tuple
		of an int, a float and a string.
		
		To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
	**/
	static public function Tuple(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function UpgradeProtocol(x:Dynamic):Dynamic;
	static public var _OWS_re : Dynamic;
	static public var __all__ : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _protocol_re : Dynamic;
	static public var _quotable_re : Dynamic;
	static public var _quote_re : Dynamic;
	static public var _quoted_string_re : Dynamic;
	static public var _token68_re : Dynamic;
	static public var _token_re : Dynamic;
	static public var _unquote_re : Dynamic;
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
		Build an extension definition.
		
		This is the reverse of :func:`parse_extension_item`.
	**/
	static public function build_extension_item(name:Dynamic, parameters:Dynamic):Dynamic;
	/**
		Build a ``Sec-WebSocket-Extensions`` header.
		
		This is the reverse of :func:`parse_extension`.
	**/
	static public function build_extension_list(extensions:Dynamic):Dynamic;
	/**
		Build a ``Host`` header.
	**/
	static public function build_host(host:Dynamic, port:Dynamic, secure:Dynamic):Dynamic;
	/**
		Format ``value`` as a quoted string.
		
		This is the reverse of :func:`parse_quoted_string`.
	**/
	static public function build_quoted_string(value:Dynamic):Dynamic;
	/**
		Build a ``Sec-WebSocket-Protocol`` header.
		
		This is the reverse of :func:`parse_subprotocol`.
	**/
	static public function build_subprotocol(subprotocols:Dynamic):Dynamic;
	/**
		Build a ``Sec-WebSocket-Protocol`` header.
		
		This is the reverse of :func:`parse_subprotocol`.
	**/
	static public function build_subprotocol_list(subprotocols:Dynamic):Dynamic;
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
	/**
		Parse optional whitespace from ``header`` at the given position.
		
		Return the new position.
		
		The whitespace itself isn't returned because it isn't significant.
	**/
	static public function parse_OWS(header:Dynamic, pos:Dynamic):Dynamic;
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
		Parse a Connection option from ``header`` at the given position.
		
		Return the protocol value and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_connection_option(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
	/**
		Check that parsing reached the end of header.
	**/
	static public function parse_end(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
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
		Parse an extension definition from ``header`` at the given position.
		
		Return an ``(extension name, parameters)`` pair, where ``parameters`` is a
		list of ``(name, value)`` pairs, and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_extension_item(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
	/**
		Parse a single extension parameter from ``header`` at the given position.
		
		Return a ``(name, value)`` pair and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_extension_item_param(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
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
	static public function parse_extension_list(header:Dynamic):Dynamic;
	/**
		Parse a comma-separated list from ``header`` at the given position.
		
		This is appropriate for parsing values with the following grammar:
		
		    1#item
		
		``parse_item`` parses one item.
		
		``header`` is assumed not to start or end with whitespace.
		
		(This function is designed for parsing an entire header value and
		:func:`~websockets.http.read_headers` strips whitespace from values.)
		
		Return a list of items.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_list(parse_item:Dynamic, header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
	/**
		Parse a quoted string from ``header`` at the given position.
		
		Return the unquoted value and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_quoted_string(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
	/**
		Parse a ``Sec-WebSocket-Protocol`` header.
		
		Return a list of WebSocket subprotocols.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_subprotocol(header:Dynamic):Dynamic;
	/**
		Parse a subprotocol from ``header`` at the given position.
		
		Return the subprotocol value and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_subprotocol_item(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
	/**
		Parse a ``Sec-WebSocket-Protocol`` header.
		
		Return a list of WebSocket subprotocols.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_subprotocol_list(header:Dynamic):Dynamic;
	/**
		Parse a token from ``header`` at the given position.
		
		Return the token value and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_token(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
	/**
		Parse a token68 from ``header`` at the given position.
		
		Return the token value and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_token68(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
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
		Parse an Upgrade protocol from ``header`` at the given position.
		
		Return the protocol value and the new position.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_upgrade_protocol(header:Dynamic, pos:Dynamic, header_name:Dynamic):Dynamic;
	/**
		Return the next character from ``header`` at the given position.
		
		Return :obj:`None` at the end of ``header``.
		
		We never need to peek more than one character ahead.
	**/
	static public function peek_ahead(header:Dynamic, pos:Dynamic):Dynamic;
	/**
		Validate that ``subprotocols`` is suitable for :func:`build_subprotocol`.
	**/
	static public function validate_subprotocols(subprotocols:Dynamic):Dynamic;
}