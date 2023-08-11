/* This file is generated, do not edit! */
package websockets.legacy.handshake;
@:pythonImport("websockets.legacy.handshake") extern class Handshake_Module {
	static public function ConnectionOption(x:Dynamic):Dynamic;
	/**
		A generic version of list.
	**/
	static public function List(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
	static public function accept(key:Dynamic):Dynamic;
	static public var annotations : Dynamic;
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
		Build a handshake response to send to the client.
		
		Update response headers passed in argument.
		
		Args:
		    headers: handshake response headers.
		    key: returned by :func:`check_request`.
	**/
	static public function build_response(headers:Dynamic, key:Dynamic):Dynamic;
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
		Parse an ``Upgrade`` header.
		
		Return a list of HTTP protocols.
		
		Args:
		    header: value of the ``Upgrade`` header.
		
		Raises:
		    InvalidHeaderFormat: on invalid inputs.
	**/
	static public function parse_upgrade(header:Dynamic):Dynamic;
}