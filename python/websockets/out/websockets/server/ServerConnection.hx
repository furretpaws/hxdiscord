/* This file is generated, do not edit! */
package websockets.server;
@:pythonImport("websockets.server", "ServerConnection") extern class ServerConnection {
	public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	static public var __dict__ : Dynamic;
	/**
		Default dir() implementation.
	**/
	public function __dir__():Dynamic;
	static public var __doc__ : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic):Dynamic;
	/**
		Default object formatter.
	**/
	public function __format__(format_spec:Dynamic):Dynamic;
	/**
		Return self>=value.
	**/
	public function __ge__(value:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattribute__(name:Dynamic):Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	/**
		Return hash(self).
	**/
	public function __hash__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__(?origins:Dynamic, ?extensions:Dynamic, ?subprotocols:Dynamic, ?state:Dynamic, ?max_size:Dynamic, ?logger:Dynamic):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?origins:Dynamic, ?extensions:Dynamic, ?subprotocols:Dynamic, ?state:Dynamic, ?max_size:Dynamic, ?logger:Dynamic):Void;
	/**
		This method is called when a class is subclassed.
		
		The default implementation does nothing. It may be
		overridden to extend subclasses.
	**/
	public function __init_subclass__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	static public var __module__ : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Helper for pickle.
	**/
	public function __reduce__():Dynamic;
	/**
		Helper for pickle.
	**/
	public function __reduce_ex__(protocol:Dynamic):Dynamic;
	/**
		Return repr(self).
	**/
	public function __repr__():Dynamic;
	/**
		Implement setattr(self, name, value).
	**/
	public function __setattr__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		Size of object in memory, in bytes.
	**/
	public function __sizeof__():Dynamic;
	/**
		Return str(self).
	**/
	public function __str__():Dynamic;
	/**
		Abstract classes can override this to customize issubclass().
		
		This is invoked early on by abc.ABCMeta.__subclasscheck__().
		It should return True, False or NotImplemented.  If it returns
		NotImplemented, the normal algorithm is used.  Otherwise, it
		overrides the normal algorithm (and the outcome is cached).
	**/
	public function __subclasshook__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	/**
		Create a handshake response to accept the connection.
		
		If the connection cannot be established, the handshake response
		actually rejects the handshake.
		
		You must send the handshake response with :meth:`send_response`.
		
		You can modify it before sending it, for example to add HTTP headers.
		
		Args:
		    request: WebSocket handshake request event received from the client.
		
		Returns:
		    Response: WebSocket handshake response event to send to the client.
	**/
	public function accept(request:Dynamic):Dynamic;
	/**
		`WebSocket close code`_.
		
		.. _WebSocket close code:
		    https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.5
		
		:obj:`None` if the connection isn't closed yet.
	**/
	public var close_code : Dynamic;
	/**
		Exception to raise when trying to interact with a closed connection.
		
		Don't raise this exception while the connection :attr:`state`
		is :attr:`~websockets.connection.State.CLOSING`; wait until
		it's :attr:`~websockets.connection.State.CLOSED`.
		
		Indeed, the exception includes the close code and reason, which are
		known only once the connection is closed.
		
		Raises:
		    AssertionError: if the connection isn't closed yet.
	**/
	public var close_exc : Dynamic;
	/**
		Tell if the TCP connection is expected to close soon.
		
		Call this method immediately after any of the ``receive_*()`` or
		:meth:`fail` methods.
		
		If it returns :obj:`True`, schedule closing the TCP connection after a
		short timeout if the other side hasn't already closed it.
		
		Returns:
		    bool: Whether the TCP connection is expected to close soon.
	**/
	public function close_expected():Dynamic;
	/**
		`WebSocket close reason`_.
		
		.. _WebSocket close reason:
		    https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.6
		
		:obj:`None` if the connection isn't closed yet.
	**/
	public var close_reason : Dynamic;
	/**
		Obtain data to send to the network.
		
		Call this method immediately after any of the ``receive_*()``,
		``send_*()``, or :meth:`fail` methods.
		
		Write resulting data to the connection.
		
		The empty bytestring :data:`~websockets.connection.SEND_EOF` signals
		the end of the data stream. When you receive it, half-close the TCP
		connection.
		
		Returns:
		    List[bytes]: Data to write to the connection.
	**/
	public function data_to_send():Dynamic;
	/**
		Discard incoming data.
		
		This coroutine replaces :meth:`parse`:
		
		- after receiving a close frame, during a normal closure (1.4);
		- after sending a close frame, during an abnormal closure (7.1.7).
	**/
	public function discard():Dynamic;
	/**
		Fetch events generated from data received from the network.
		
		Call this method immediately after any of the ``receive_*()`` methods.
		
		Process resulting events, likely by passing them to the application.
		
		Returns:
		    List[Event]: Events read from the connection.
	**/
	public function events_received():Dynamic;
	/**
		`Fail the WebSocket connection`_.
		
		.. _Fail the WebSocket connection:
		    https://datatracker.ietf.org/doc/html/rfc6455#section-7.1.7
		
		Parameters:
		    code: close code
		    reason: close reason
		
		Raises:
		    ProtocolError: if the code isn't valid.
	**/
	public function fail(code:Dynamic, ?reason:Dynamic):Dynamic;
	/**
		Parse incoming data into frames.
		
		:meth:`receive_data` and :meth:`receive_eof` run this generator
		coroutine until it needs more data or reaches EOF.
	**/
	public function parse():Dynamic;
	/**
		Handle the Sec-WebSocket-Extensions HTTP request header.
		
		Accept or reject each extension proposed in the client request.
		Negotiate parameters for accepted extensions.
		
		:rfc:`6455` leaves the rules up to the specification of each
		:extension.
		
		To provide this level of flexibility, for each extension proposed by
		the client, we check for a match with each extension available in the
		server configuration. If no match is found, the extension is ignored.
		
		If several variants of the same extension are proposed by the client,
		it may be accepted several times, which won't make sense in general.
		Extensions must implement their own requirements. For this purpose,
		the list of previously accepted extensions is provided.
		
		This process doesn't allow the server to reorder extensions. It can
		only select a subset of the extensions proposed by the client.
		
		Other requirements, for example related to mandatory extensions or the
		order of extensions, may be implemented by overriding this method.
		
		Args:
		    headers: WebSocket handshake request headers.
		
		Returns:
		    Tuple[Optional[str], List[Extension]]: ``Sec-WebSocket-Extensions``
		    HTTP response header and list of accepted extensions.
		
		Raises:
		    InvalidHandshake: to abort the handshake with an HTTP 400 error.
	**/
	public function process_extensions(headers:Dynamic):Dynamic;
	/**
		Handle the Origin HTTP request header.
		
		Args:
		    headers: WebSocket handshake request headers.
		
		Returns:
		   Optional[Origin]: origin, if it is acceptable.
		
		Raises:
		    InvalidOrigin: if the origin isn't acceptable.
	**/
	public function process_origin(headers:Dynamic):Dynamic;
	/**
		Check a handshake request and negotiate extensions and subprotocol.
		
		This function doesn't verify that the request is an HTTP/1.1 or higher
		GET request and doesn't check the ``Host`` header. These controls are
		usually performed earlier in the HTTP request handling code. They're
		the responsibility of the caller.
		
		Args:
		    request: WebSocket handshake request received from the client.
		
		Returns:
		    Tuple[str, Optional[str], Optional[str]]:
		    ``Sec-WebSocket-Accept``, ``Sec-WebSocket-Extensions``, and
		    ``Sec-WebSocket-Protocol`` headers for the handshake response.
		
		Raises:
		    InvalidHandshake: if the handshake request is invalid;
		        then the server must return 400 Bad Request error.
	**/
	public function process_request(request:Dynamic):Dynamic;
	/**
		Handle the Sec-WebSocket-Protocol HTTP request header.
		
		Args:
		    headers: WebSocket handshake request headers.
		
		Returns:
		   Optional[Subprotocol]: Subprotocol, if one was selected; this is
		   also the value of the ``Sec-WebSocket-Protocol`` response header.
		
		Raises:
		    InvalidHandshake: to abort the handshake with an HTTP 400 error.
	**/
	public function process_subprotocol(headers:Dynamic):Dynamic;
	/**
		Receive data from the network.
		
		After calling this method:
		
		- You must call :meth:`data_to_send` and send this data to the network.
		- You should call :meth:`events_received` and process resulting events.
		
		Raises:
		    EOFError: if :meth:`receive_eof` was called earlier.
	**/
	public function receive_data(data:Dynamic):Dynamic;
	/**
		Receive the end of the data stream from the network.
		
		After calling this method:
		
		- You must call :meth:`data_to_send` and send this data to the network.
		- You aren't expected to call :meth:`events_received`; it won't return
		  any new events.
		
		Raises:
		    EOFError: if :meth:`receive_eof` was called earlier.
	**/
	public function receive_eof():Dynamic;
	/**
		Process an incoming frame.
	**/
	public function recv_frame(frame:Dynamic):Dynamic;
	/**
		Create a handshake response to reject the connection.
		
		A short plain text response is the best fallback when failing to
		establish a WebSocket connection.
		
		You must send the handshake response with :meth:`send_response`.
		
		You can modify it before sending it, for example to alter HTTP headers.
		
		Args:
		    status: HTTP status code.
		    text: HTTP response body; will be encoded to UTF-8.
		
		Returns:
		    Response: WebSocket handshake response event to send to the client.
	**/
	public function reject(status:Dynamic, text:Dynamic):Dynamic;
	/**
		Pick a subprotocol among those offered by the client.
		
		If several subprotocols are supported by the client and the server,
		the default implementation selects the preferred subprotocols by
		giving equal value to the priorities of the client and the server.
		
		If no common subprotocol is supported by the client and the server, it
		proceeds without a subprotocol.
		
		This is unlikely to be the most useful implementation in practice, as
		many servers providing a subprotocol will require that the client uses
		that subprotocol.
		
		Args:
		    client_subprotocols: list of subprotocols offered by the client.
		    server_subprotocols: list of subprotocols available on the server.
		
		Returns:
		    Optional[Subprotocol]: Subprotocol, if a common subprotocol was
		    found.
	**/
	public function select_subprotocol(client_subprotocols:Dynamic, server_subprotocols:Dynamic):Dynamic;
	/**
		Send a `Binary frame`_.
		
		.. _Binary frame:
		    https://datatracker.ietf.org/doc/html/rfc6455#section-5.6
		
		Parameters:
		    data: payload containing arbitrary binary data.
		    fin: FIN bit; set it to :obj:`False` if this is the first frame of
		        a fragmented message.
		
		Raises:
		    ProtocolError: if a fragmented message is in progress.
	**/
	public function send_binary(data:Dynamic, ?fin:Dynamic):Dynamic;
	/**
		Send a `Close frame`_.
		
		.. _Close frame:
		    https://datatracker.ietf.org/doc/html/rfc6455#section-5.5.1
		
		Parameters:
		    code: close code.
		    reason: close reason.
		
		Raises:
		    ProtocolError: if a fragmented message is being sent, if the code
		        isn't valid, or if a reason is provided without a code
	**/
	public function send_close(?code:Dynamic, ?reason:Dynamic):Dynamic;
	/**
		Send a `Continuation frame`_.
		
		.. _Continuation frame:
		    https://datatracker.ietf.org/doc/html/rfc6455#section-5.6
		
		Parameters:
		    data: payload containing the same kind of data
		        as the initial frame.
		    fin: FIN bit; set it to :obj:`True` if this is the last frame
		        of a fragmented message and to :obj:`False` otherwise.
		
		Raises:
		    ProtocolError: if a fragmented message isn't in progress.
	**/
	public function send_continuation(data:Dynamic, fin:Dynamic):Dynamic;
	public function send_eof():Dynamic;
	public function send_frame(frame:Dynamic):Dynamic;
	/**
		Send a `Ping frame`_.
		
		.. _Ping frame:
		    https://datatracker.ietf.org/doc/html/rfc6455#section-5.5.2
		
		Parameters:
		    data: payload containing arbitrary binary data.
	**/
	public function send_ping(data:Dynamic):Dynamic;
	/**
		Send a `Pong frame`_.
		
		.. _Pong frame:
		    https://datatracker.ietf.org/doc/html/rfc6455#section-5.5.3
		
		Parameters:
		    data: payload containing arbitrary binary data.
	**/
	public function send_pong(data:Dynamic):Dynamic;
	/**
		Send a handshake response to the client.
		
		Args:
		    response: WebSocket handshake response event to send.
	**/
	public function send_response(response:Dynamic):Dynamic;
	/**
		Send a `Text frame`_.
		
		.. _Text frame:
		    https://datatracker.ietf.org/doc/html/rfc6455#section-5.6
		
		Parameters:
		    data: payload containing text encoded with UTF-8.
		    fin: FIN bit; set it to :obj:`False` if this is the first frame of
		        a fragmented message.
		
		Raises:
		    ProtocolError: if a fragmented message is in progress.
	**/
	public function send_text(data:Dynamic, ?fin:Dynamic):Dynamic;
	/**
		WebSocket connection state.
		
		Defined in 4.1, 4.2, 7.1.3, and 7.1.4 of :rfc:`6455`.
	**/
	public var state : Dynamic;
}