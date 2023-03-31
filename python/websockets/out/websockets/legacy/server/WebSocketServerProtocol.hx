/* This file is generated, do not edit! */
package websockets.legacy.server;
@:pythonImport("websockets.legacy.server", "WebSocketServerProtocol") extern class WebSocketServerProtocol {
	/**
		Iterate on incoming messages.
		
		The iterator  exits normally when the connection is closed with the
		close code 1000 (OK) or 1001(going away). It raises
		a :exc:`~websockets.exceptions.ConnectionClosedError` exception when
		the connection is closed with any other code.
	**/
	public function __aiter__():Dynamic;
	static public var __annotations__ : Dynamic;
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
	public function ___init__(ws_handler:Dynamic, ws_server:Dynamic, ?logger:Dynamic, ?origins:Dynamic, ?extensions:Dynamic, ?subprotocols:Dynamic, ?extra_headers:Dynamic, ?server_header:Dynamic, ?process_request:Dynamic, ?select_subprotocol:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(ws_handler:Dynamic, ws_server:Dynamic, ?logger:Dynamic, ?origins:Dynamic, ?extensions:Dynamic, ?subprotocols:Dynamic, ?extra_headers:Dynamic, ?server_header:Dynamic, ?process_request:Dynamic, ?select_subprotocol:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Void;
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
	static public var __slots__ : Dynamic;
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
	public function _drain():Dynamic;
	public function _drain_helper():Dynamic;
	/**
		Raise ConnectionClosed in pending keepalive pings.
		
		They'll never receive a pong once the connection is closed.
	**/
	public function abort_pings():Dynamic;
	/**
		Perform the closing handshake.
		
		:meth:`close` waits for the other end to complete the handshake and
		for the TCP connection to terminate. As a consequence, there's no need
		to await :meth:`wait_closed` after :meth:`close`.
		
		:meth:`close` is idempotent: it doesn't do anything once the
		connection is closed.
		
		Wrapping :func:`close` in :func:`~asyncio.create_task` is safe, given
		that errors during connection termination aren't particularly useful.
		
		Canceling :meth:`close` is discouraged. If it takes too long, you can
		set a shorter ``close_timeout``. If you don't want to wait, let the
		Python process exit, then the OS will take care of closing the TCP
		connection.
		
		Args:
		    code: WebSocket close code.
		    reason: WebSocket close reason.
	**/
	public function close(?code:Dynamic, ?reason:Dynamic):Dynamic;
	/**
		WebSocket close code, defined in `section 7.1.5 of RFC 6455`_.
		
		.. _section 7.1.5 of RFC 6455:
		    https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.5
		
		:obj:`None` if the connection isn't closed yet.
	**/
	public var close_code : Dynamic;
	/**
		7.1.1. Close the WebSocket Connection
		
		When the opening handshake succeeds, :meth:`connection_open` starts
		this coroutine in a task. It waits for the data transfer phase to
		complete then it closes the TCP connection cleanly.
		
		When the opening handshake fails, :meth:`fail_connection` does the
		same. There's no data transfer phase in that case.
	**/
	public function close_connection():Dynamic;
	/**
		WebSocket close reason, defined in `section 7.1.6 of RFC 6455`_.
		
		.. _section 7.1.6 of RFC 6455:
		    https://www.rfc-editor.org/rfc/rfc6455.html#section-7.1.6
		
		:obj:`None` if the connection isn't closed yet.
	**/
	public var close_reason : Dynamic;
	/**
		Close the TCP connection.
	**/
	public function close_transport():Dynamic;
	/**
		:obj:`True` when the connection is closed; :obj:`False` otherwise.
		
		Be aware that both :attr:`open` and :attr:`closed` are :obj:`False`
		during the opening and closing sequences.
	**/
	public var closed : Dynamic;
	public function connection_closed_exc():Dynamic;
	/**
		7.1.4. The WebSocket Connection is Closed.
	**/
	public function connection_lost(exc:Dynamic):Dynamic;
	/**
		Register connection and initialize a task to handle it.
	**/
	public function connection_made(transport:Dynamic):Dynamic;
	/**
		Callback when the WebSocket opening handshake completes.
		
		Enter the OPEN state and start the data transfer phase.
	**/
	public function connection_open():Dynamic;
	/**
		Called when some data is received.
		
		The argument is a bytes object.
	**/
	public function data_received(data:Dynamic):Dynamic;
	public function drain():Dynamic;
	/**
		Check that the WebSocket connection is open.
		
		Raise :exc:`~websockets.exceptions.ConnectionClosed` if it isn't.
	**/
	public function ensure_open():Dynamic;
	/**
		Close the transport after receiving EOF.
		
		The WebSocket protocol has its own closing handshake: endpoints close
		the TCP or TLS connection after sending and receiving a close frame.
		
		As a consequence, they never need to write after receiving EOF, so
		there's no reason to keep the transport open by returning :obj:`True`.
		
		Besides, that doesn't work on TLS connections.
	**/
	public function eof_received():Dynamic;
	/**
		7.1.7. Fail the WebSocket Connection
		
		This requires:
		
		1. Stopping all processing of incoming data, which means cancelling
		   :attr:`transfer_data_task`. The close code will be 1006 unless a
		   close frame was received earlier.
		
		2. Sending a close frame with an appropriate code if the opening
		   handshake succeeded and the other side is likely to process it.
		
		3. Closing the connection. :meth:`close_connection` takes care of
		   this once :attr:`transfer_data_task` exits after being canceled.
		
		(The specification describes these steps in the opposite order.)
	**/
	public function fail_connection(?code:Dynamic, ?reason:Dynamic):Dynamic;
	/**
		Handle the lifecycle of a WebSocket connection.
		
		Since this method doesn't have a caller able to handle exceptions, it
		attempts to log relevant ones and guarantees that the TCP connection is
		closed before exiting.
	**/
	public function handler():Dynamic;
	/**
		Perform the server side of the opening handshake.
		
		Args:
		    origins: list of acceptable values of the Origin HTTP header;
		        include :obj:`None` if the lack of an origin is acceptable.
		    extensions: list of supported extensions, in order in which they
		        should be tried.
		    subprotocols: list of supported subprotocols, in order of
		        decreasing preference.
		    extra_headers: arbitrary HTTP headers to add to the response when
		        the handshake succeeds.
		
		Returns:
		    str: path of the URI of the request.
		
		Raises:
		    InvalidHandshake: if the handshake fails.
	**/
	public function handshake(?origins:Dynamic, ?available_extensions:Dynamic, ?available_subprotocols:Dynamic, ?extra_headers:Dynamic):Dynamic;
	public var host : Dynamic;
	static public var is_client : Dynamic;
	/**
		Send a Ping frame and wait for a Pong frame at regular intervals.
		
		This coroutine exits when the connection terminates and one of the
		following happens:
		
		- :meth:`ping` raises :exc:`ConnectionClosed`, or
		- :meth:`close_connection` cancels :attr:`keepalive_ping_task`.
	**/
	public function keepalive_ping():Dynamic;
	/**
		Local address of the connection.
		
		For IPv4 connections, this is a ``(host, port)`` tuple.
		
		The format of the address depends on the address family;
		see :meth:`~socket.socket.getsockname`.
		
		:obj:`None` if the TCP connection isn't established yet.
	**/
	public var local_address : Dynamic;
	/**
		:obj:`True` when the connection is open; :obj:`False` otherwise.
		
		This attribute may be used to detect disconnections. However, this
		approach is discouraged per the EAFP_ principle. Instead, you should
		handle :exc:`~websockets.exceptions.ConnectionClosed` exceptions.
		
		.. _EAFP: https://docs.python.org/3/glossary.html#term-eafp
	**/
	public var open : Dynamic;
	/**
		Called when the transport's buffer goes over the high-water mark.
		
		Pause and resume calls are paired -- pause_writing() is called
		once when the buffer goes strictly over the high-water mark
		(even if subsequent writes increases the buffer size even
		more), and eventually resume_writing() is called once when the
		buffer size reaches the low-water mark.
		
		Note that if the buffer size equals the high-water mark,
		pause_writing() is not called -- it must go strictly over.
		Conversely, resume_writing() is called when the buffer size is
		equal or lower than the low-water mark.  These end conditions
		are important to ensure that things go as expected when either
		mark is zero.
		
		NOTE: This is the only Protocol callback that is not called
		through EventLoop.call_soon() -- if it were, it would have no
		effect when it's most needed (when the app keeps writing
		without yielding until pause_writing() is called).
	**/
	public function pause_writing():Dynamic;
	/**
		Send a Ping_.
		
		.. _Ping: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.5.2
		
		A ping may serve as a keepalive, as a check that the remote endpoint
		received all messages up to this point, or to measure :attr:`latency`.
		
		Canceling :meth:`ping` is discouraged. If :meth:`ping` doesn't return
		immediately, it means the write buffer is full. If you don't want to
		wait, you should close the connection.
		
		Canceling the :class:`~asyncio.Future` returned by :meth:`ping` has no
		effect.
		
		Args:
		    data (Optional[Data]): payload of the ping; a string will be
		        encoded to UTF-8; or :obj:`None` to generate a payload
		        containing four random bytes.
		
		Returns:
		    ~asyncio.Future[float]: A future that will be completed when the
		    corresponding pong is received. You can ignore it if you don't
		    intend to wait. The result of the future is the latency of the
		    connection in seconds.
		
		    ::
		
		        pong_waiter = await ws.ping()
		        # only if you want to wait for the corresponding pong
		        latency = await pong_waiter
		
		Raises:
		    ConnectionClosed: when the connection is closed.
		    RuntimeError: if another ping was sent with the same data and
		        the corresponding pong wasn't received yet.
	**/
	public function ping(?data:Dynamic):Dynamic;
	/**
		Send a Pong_.
		
		.. _Pong: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.5.3
		
		An unsolicited pong may serve as a unidirectional heartbeat.
		
		Canceling :meth:`pong` is discouraged. If :meth:`pong` doesn't return
		immediately, it means the write buffer is full. If you don't want to
		wait, you should close the connection.
		
		Args:
		    data (Data): payload of the pong; a string will be encoded to
		        UTF-8.
		
		Raises:
		    ConnectionClosed: when the connection is closed.
	**/
	public function pong(?data:Dynamic):Dynamic;
	public var port : Dynamic;
	/**
		Handle the Sec-WebSocket-Extensions HTTP request header.
		
		Accept or reject each extension proposed in the client request.
		Negotiate parameters for accepted extensions.
		
		Return the Sec-WebSocket-Extensions HTTP response header and the list
		of accepted extensions.
		
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
		    headers: request headers.
		    extensions: optional list of supported extensions.
		
		Raises:
		    InvalidHandshake: to abort the handshake with an HTTP 400 error.
	**/
	static public function process_extensions(headers:Dynamic, available_extensions:Dynamic):Dynamic;
	/**
		Handle the Origin HTTP request header.
		
		Args:
		    headers: request headers.
		    origins: optional list of acceptable origins.
		
		Raises:
		    InvalidOrigin: if the origin isn't acceptable.
	**/
	static public function process_origin(headers:Dynamic, ?origins:Dynamic):Dynamic;
	/**
		Intercept the HTTP request and return an HTTP response if appropriate.
		
		You may override this method in a :class:`WebSocketServerProtocol`
		subclass, for example:
		
		* to return a HTTP 200 OK response on a given path; then a load
		  balancer can use this path for a health check;
		* to authenticate the request and return a HTTP 401 Unauthorized or a
		  HTTP 403 Forbidden when authentication fails.
		
		You may also override this method with the ``process_request``
		argument of :func:`serve` and :class:`WebSocketServerProtocol`. This
		is equivalent, except ``process_request`` won't have access to the
		protocol instance, so it can't store information for later use.
		
		:meth:`process_request` is expected to complete quickly. If it may run
		for a long time, then it should await :meth:`wait_closed` and exit if
		:meth:`wait_closed` completes, or else it could prevent the server
		from shutting down.
		
		Args:
		    path: request path, including optional query string.
		    request_headers: request headers.
		
		Returns:
		    Optional[Tuple[http.HTTPStatus, HeadersLike, bytes]]: :obj:`None`
		    to continue the WebSocket handshake normally.
		
		    An HTTP response, represented by a 3-uple of the response status,
		    headers, and body, to abort the WebSocket handshake and return
		    that HTTP response instead.
	**/
	public function process_request(path:Dynamic, request_headers:Dynamic):Dynamic;
	/**
		Handle the Sec-WebSocket-Protocol HTTP request header.
		
		Return Sec-WebSocket-Protocol HTTP response header, which is the same
		as the selected subprotocol.
		
		Args:
		    headers: request headers.
		    available_subprotocols: optional list of supported subprotocols.
		
		Raises:
		    InvalidHandshake: to abort the handshake with an HTTP 400 error.
	**/
	public function process_subprotocol(headers:Dynamic, available_subprotocols:Dynamic):Dynamic;
	/**
		Read a single data frame from the connection.
		
		Process control frames received before the next data frame.
		
		Return :obj:`None` if a close frame is encountered before any data frame.
	**/
	public function read_data_frame(max_size:Dynamic):Dynamic;
	/**
		Read a single frame from the connection.
	**/
	public function read_frame(max_size:Dynamic):Dynamic;
	/**
		Read request line and headers from the HTTP request.
		
		If the request contains a body, it may be read from ``self.reader``
		after this coroutine returns.
		
		Raises:
		    InvalidMessage: if the HTTP message is malformed or isn't an
		        HTTP/1.1 GET request.
	**/
	public function read_http_request():Dynamic;
	/**
		Read a single message from the connection.
		
		Re-assemble data frames if the message is fragmented.
		
		Return :obj:`None` when the closing handshake is started.
	**/
	public function read_message():Dynamic;
	/**
		Receive the next message.
		
		When the connection is closed, :meth:`recv` raises
		:exc:`~websockets.exceptions.ConnectionClosed`. Specifically, it
		raises :exc:`~websockets.exceptions.ConnectionClosedOK` after a normal
		connection closure and
		:exc:`~websockets.exceptions.ConnectionClosedError` after a protocol
		error or a network failure. This is how you detect the end of the
		message stream.
		
		Canceling :meth:`recv` is safe. There's no risk of losing the next
		message. The next invocation of :meth:`recv` will return it.
		
		This makes it possible to enforce a timeout by wrapping :meth:`recv`
		in :func:`~asyncio.wait_for`.
		
		Returns:
		    Data: A string (:class:`str`) for a Text_ frame. A bytestring
		    (:class:`bytes`) for a Binary_ frame.
		
		    .. _Text: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.6
		    .. _Binary: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.6
		
		Raises:
		    ConnectionClosed: when the connection is closed.
		    RuntimeError: if two coroutines call :meth:`recv` concurrently.
	**/
	public function recv():Dynamic;
	/**
		Remote address of the connection.
		
		For IPv4 connections, this is a ``(host, port)`` tuple.
		
		The format of the address depends on the address family;
		see :meth:`~socket.socket.getpeername`.
		
		:obj:`None` if the TCP connection isn't established yet.
	**/
	public var remote_address : Dynamic;
	/**
		Called when the transport's buffer drains below the low-water mark.
		
		See pause_writing() for details.
	**/
	public function resume_writing():Dynamic;
	public var secure : Dynamic;
	/**
		Pick a subprotocol among those offered by the client.
		
		If several subprotocols are supported by the client and the server,
		the default implementation selects the preferred subprotocol by
		giving equal value to the priorities of the client and the server.
		If no subprotocol is supported by the client and the server, it
		proceeds without a subprotocol.
		
		This is unlikely to be the most useful implementation in practice.
		Many servers providing a subprotocol will require that the client
		uses that subprotocol. Such rules can be implemented in a subclass.
		
		You may also override this method with the ``select_subprotocol``
		argument of :func:`serve` and :class:`WebSocketServerProtocol`.
		
		Args:
		    client_subprotocols: list of subprotocols offered by the client.
		    server_subprotocols: list of subprotocols available on the server.
		
		Returns:
		    Optional[Subprotocol]: Selected subprotocol.
		
		    :obj:`None` to continue without a subprotocol.
	**/
	public function select_subprotocol(client_subprotocols:Dynamic, server_subprotocols:Dynamic):Dynamic;
	/**
		Send a message.
		
		A string (:class:`str`) is sent as a Text_ frame. A bytestring or
		bytes-like object (:class:`bytes`, :class:`bytearray`, or
		:class:`memoryview`) is sent as a Binary_ frame.
		
		.. _Text: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.6
		.. _Binary: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.6
		
		:meth:`send` also accepts an iterable or an asynchronous iterable of
		strings, bytestrings, or bytes-like objects to enable fragmentation_.
		Each item is treated as a message fragment and sent in its own frame.
		All items must be of the same type, or else :meth:`send` will raise a
		:exc:`TypeError` and the connection will be closed.
		
		.. _fragmentation: https://www.rfc-editor.org/rfc/rfc6455.html#section-5.4
		
		:meth:`send` rejects dict-like objects because this is often an error.
		(If you want to send the keys of a dict-like object as fragments, call
		its :meth:`~dict.keys` method and pass the result to :meth:`send`.)
		
		Canceling :meth:`send` is discouraged. Instead, you should close the
		connection with :meth:`close`. Indeed, there are only two situations
		where :meth:`send` may yield control to the event loop and then get
		canceled; in both cases, :meth:`close` has the same effect and is
		more clear:
		
		1. The write buffer is full. If you don't want to wait until enough
		   data is sent, your only alternative is to close the connection.
		   :meth:`close` will likely time out then abort the TCP connection.
		2. ``message`` is an asynchronous iterator that yields control.
		   Stopping in the middle of a fragmented message will cause a
		   protocol error and the connection will be closed.
		
		When the connection is closed, :meth:`send` raises
		:exc:`~websockets.exceptions.ConnectionClosed`. Specifically, it
		raises :exc:`~websockets.exceptions.ConnectionClosedOK` after a normal
		connection closure and
		:exc:`~websockets.exceptions.ConnectionClosedError` after a protocol
		error or a network failure.
		
		Args:
		    message (Union[Data, Iterable[Data], AsyncIterable[Data]): message
		        to send.
		
		Raises:
		    ConnectionClosed: when the connection is closed.
		    TypeError: if ``message`` doesn't have a supported type.
	**/
	public function send(message:Dynamic):Dynamic;
	static public var side : Dynamic;
	/**
		Read incoming messages and put them in a queue.
		
		This coroutine runs in a task until the closing handshake is started.
	**/
	public function transfer_data():Dynamic;
	/**
		Wait until the connection is closed.
		
		This coroutine is identical to the :attr:`closed` attribute, except it
		can be awaited.
		
		This can make it easier to detect connection termination, regardless
		of its cause, in tasks that interact with the WebSocket connection.
	**/
	public function wait_closed():Dynamic;
	/**
		Wait until the TCP connection is closed or ``self.close_timeout`` elapses.
		
		Return :obj:`True` if the connection is closed and :obj:`False`
		otherwise.
	**/
	public function wait_for_connection_lost():Dynamic;
	/**
		Write a close frame if and only if the connection state is OPEN.
		
		This dedicated coroutine must be used for writing close frames to
		ensure that at most one close frame is sent on a given connection.
	**/
	public function write_close_frame(close:Dynamic, ?data:Dynamic):Dynamic;
	public function write_frame(fin:Dynamic, opcode:Dynamic, data:Dynamic, ?_state:Dynamic):Dynamic;
	public function write_frame_sync(fin:Dynamic, opcode:Dynamic, data:Dynamic):Dynamic;
	/**
		Write status line and headers to the HTTP response.
		
		This coroutine is also able to write a response body.
	**/
	public function write_http_response(status:Dynamic, headers:Dynamic, ?body:Dynamic):Dynamic;
}