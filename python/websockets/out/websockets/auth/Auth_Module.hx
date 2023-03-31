/* This file is generated, do not edit! */
package websockets.auth;
@:pythonImport("websockets.auth") extern class Auth_Module {
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
}