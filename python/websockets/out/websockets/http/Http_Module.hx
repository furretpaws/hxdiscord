/* This file is generated, do not edit! */
package websockets.http;
@:pythonImport("websockets.http") extern class Http_Module {
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
	static public var websockets_version : Dynamic;
}