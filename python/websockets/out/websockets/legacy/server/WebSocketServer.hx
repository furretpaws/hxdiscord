/* This file is generated, do not edit! */
package websockets.legacy.server;
@:pythonImport("websockets.legacy.server", "WebSocketServer") extern class WebSocketServer {
	public function __aenter__():Dynamic;
	public function __aexit__(exc_type:Dynamic, exc_value:Dynamic, traceback:Dynamic):Dynamic;
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
	public function ___init__(?logger:Dynamic):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?logger:Dynamic):Void;
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
		Implementation of :meth:`close`.
		
		This calls :meth:`~asyncio.Server.close` on the underlying
		:class:`~asyncio.Server` object to stop accepting new connections and
		then closes open connections with close code 1001.
	**/
	public function _close():Dynamic;
	/**
		Close the server.
		
		This method:
		
		* closes the underlying :class:`~asyncio.Server`;
		* rejects new WebSocket connections with an HTTP 503 (service
		  unavailable) error; this happens when the server accepted the TCP
		  connection but didn't complete the WebSocket opening handshake prior
		  to closing;
		* closes open WebSocket connections with close code 1001 (going away).
		
		:meth:`close` is idempotent.
	**/
	public function close():Dynamic;
	/**
		See :meth:`asyncio.Server.get_loop`.
	**/
	public function get_loop():Dynamic;
	/**
		See :meth:`asyncio.Server.is_serving`.
	**/
	public function is_serving():Dynamic;
	/**
		Register a connection with this server.
	**/
	public function register(protocol:Dynamic):Dynamic;
	/**
		See :meth:`asyncio.Server.serve_forever`.
		
		Typical use::
		
		    server = await serve(...)
		    # this coroutine doesn't return
		    # canceling it stops the server
		    await server.serve_forever()
		
		This is an alternative to using :func:`serve` as an asynchronous context
		manager. Shutdown is triggered by canceling :meth:`serve_forever`
		instead of exiting a :func:`serve` context.
	**/
	public function serve_forever():Dynamic;
	/**
		See :attr:`asyncio.Server.sockets`.
	**/
	public var sockets : Dynamic;
	/**
		See :meth:`asyncio.Server.start_serving`.
		
		Typical use::
		
		    server = await serve(..., start_serving=False)
		    # perform additional setup here...
		    # ... then start the server
		    await server.start_serving()
	**/
	public function start_serving():Dynamic;
	/**
		Unregister a connection with this server.
	**/
	public function unregister(protocol:Dynamic):Dynamic;
	/**
		Wait until the server is closed.
		
		When :meth:`wait_closed` returns, all TCP connections are closed and
		all connection handlers have returned.
		
		To ensure a fast shutdown, a connection handler should always be
		awaiting at least one of:
		
		* :meth:`~WebSocketServerProtocol.recv`: when the connection is closed,
		  it raises :exc:`~websockets.exceptions.ConnectionClosedOK`;
		* :meth:`~WebSocketServerProtocol.wait_closed`: when the connection is
		  closed, it returns.
		
		Then the connection handler is immediately notified of the shutdown;
		it can clean up and exit.
	**/
	public function wait_closed():Dynamic;
	/**
		Attach to a given :class:`~asyncio.Server`.
		
		Since :meth:`~asyncio.loop.create_server` doesn't support injecting a
		custom ``Server`` class, the easiest solution that doesn't rely on
		private :mod:`asyncio` APIs is to:
		
		- instantiate a :class:`WebSocketServer`
		- give the protocol factory a reference to that instance
		- call :meth:`~asyncio.loop.create_server` with the factory
		- attach the resulting :class:`~asyncio.Server` with this method
	**/
	public function wrap(server:Dynamic):Dynamic;
}