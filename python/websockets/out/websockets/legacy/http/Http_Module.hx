/* This file is generated, do not edit! */
package websockets.legacy.http;
@:pythonImport("websockets.legacy.http") extern class Http_Module {
	static public var MAX_HEADERS : Dynamic;
	static public var MAX_LINE : Dynamic;
	/**
		Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
		
		Example: Tuple[T1, T2] is a tuple of two elements corresponding
		to type variables T1 and T2.  Tuple[int, float, str] is a tuple
		of an int, a float and a string.
		
		To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
	**/
	static public function Tuple(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public var __all__ : Dynamic;
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
		Read HTTP headers from ``stream``.
		
		Non-ASCII characters are represented with surrogate escapes.
	**/
	static public function read_headers(stream:Dynamic):Dynamic;
	/**
		Read a single line from ``stream``.
		
		CRLF is stripped from the return value.
	**/
	static public function read_line(stream:Dynamic):Dynamic;
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
}