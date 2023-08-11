/* This file is generated, do not edit! */
package websockets.http11;
@:pythonImport("websockets.http11") extern class Http11_Module {
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
		A generic version of collections.abc.Generator.
	**/
	static public function Generator(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var MAX_BODY : Dynamic;
	static public var MAX_HEADERS : Dynamic;
	static public var MAX_LINE : Dynamic;
	/**
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _token_re : Dynamic;
	static public var _value_re : Dynamic;
	static public var annotations : Dynamic;
	/**
		Decode a bytestring for interpolating into an error message.
	**/
	static public function d(value:Dynamic):Dynamic;
	/**
		Parse HTTP headers.
		
		Non-ASCII characters are represented with surrogate escapes.
		
		Args:
		    read_line: generator-based coroutine that reads a LF-terminated line
		        or raises an exception if there isn't enough data.
		
		Raises:
		    EOFError: if the connection is closed without complete headers.
		    SecurityError: if the request exceeds a security limit.
		    ValueError: if the request isn't well formatted.
	**/
	static public function parse_headers(read_line:Dynamic):Dynamic;
	/**
		Parse a single line.
		
		CRLF is stripped from the return value.
		
		Args:
		    read_line: generator-based coroutine that reads a LF-terminated line
		        or raises an exception if there isn't enough data.
		
		Raises:
		    EOFError: if the connection is closed without a CRLF.
		    SecurityError: if the response exceeds a security limit.
	**/
	static public function parse_line(read_line:Dynamic):Dynamic;
}