/* This file is generated, do not edit! */
package requests.adapters;
@:pythonImport("requests.adapters", "HTTPAdapter") extern class HTTPAdapter {
	static public var __attrs__ : Dynamic;
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
	public function __getstate__():Dynamic;
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
	public function ___init__(?pool_connections:Dynamic, ?pool_maxsize:Dynamic, ?max_retries:Dynamic, ?pool_block:Dynamic):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?pool_connections:Dynamic, ?pool_maxsize:Dynamic, ?max_retries:Dynamic, ?pool_block:Dynamic):Void;
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
	public function __setstate__(state:Dynamic):Dynamic;
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
		Add any headers needed by the connection. As of v2.0 this does
		nothing by default, but is left for overriding by users that subclass
		the :class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		This should not be called from user code, and is only exposed for use
		when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		:param request: The :class:`PreparedRequest <PreparedRequest>` to add headers to.
		:param kwargs: The keyword arguments from the call to send().
	**/
	public function add_headers(request:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Builds a :class:`Response <requests.Response>` object from a urllib3
		response. This should not be called from user code, and is only exposed
		for use when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`
		
		:param req: The :class:`PreparedRequest <PreparedRequest>` used to generate the response.
		:param resp: The urllib3 response object.
		:rtype: requests.Response
	**/
	public function build_response(req:Dynamic, resp:Dynamic):Dynamic;
	/**
		Verify a SSL certificate. This method should not be called from user
		code, and is only exposed for use when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		:param conn: The urllib3 connection object associated with the cert.
		:param url: The requested URL.
		:param verify: Either a boolean, in which case it controls whether we verify
		    the server's TLS certificate, or a string, in which case it must be a path
		    to a CA bundle to use
		:param cert: The SSL certificate to verify.
	**/
	public function cert_verify(conn:Dynamic, url:Dynamic, verify:Dynamic, cert:Dynamic):Dynamic;
	/**
		Disposes of any internal state.
		
		Currently, this closes the PoolManager and any active ProxyManager,
		which closes any pooled connections.
	**/
	public function close():Dynamic;
	/**
		Returns a urllib3 connection for the given URL. This should not be
		called from user code, and is only exposed for use when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		:param url: The URL to connect to.
		:param proxies: (optional) A Requests-style dictionary of proxies used on this request.
		:rtype: urllib3.ConnectionPool
	**/
	public function get_connection(url:Dynamic, ?proxies:Dynamic):Dynamic;
	/**
		Initializes a urllib3 PoolManager.
		
		This method should not be called from user code, and is only
		exposed for use when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		:param connections: The number of urllib3 connection pools to cache.
		:param maxsize: The maximum number of connections to save in the pool.
		:param block: Block when no free connections are available.
		:param pool_kwargs: Extra keyword arguments used to initialize the Pool Manager.
	**/
	public function init_poolmanager(connections:Dynamic, maxsize:Dynamic, ?block:Dynamic, ?pool_kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Returns a dictionary of the headers to add to any request sent
		through a proxy. This works with urllib3 magic to ensure that they are
		correctly sent to the proxy, rather than in a tunnelled request if
		CONNECT is being used.
		
		This should not be called from user code, and is only exposed for use
		when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		:param proxy: The url of the proxy being used for this request.
		:rtype: dict
	**/
	public function proxy_headers(proxy:Dynamic):Dynamic;
	/**
		Return urllib3 ProxyManager for the given proxy.
		
		This method should not be called from user code, and is only
		exposed for use when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		:param proxy: The proxy to return a urllib3 ProxyManager for.
		:param proxy_kwargs: Extra keyword arguments used to configure the Proxy Manager.
		:returns: ProxyManager
		:rtype: urllib3.ProxyManager
	**/
	public function proxy_manager_for(proxy:Dynamic, ?proxy_kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Obtain the url to use when making the final request.
		
		If the message is being sent through a HTTP proxy, the full URL has to
		be used. Otherwise, we should only use the path portion of the URL.
		
		This should not be called from user code, and is only exposed for use
		when subclassing the
		:class:`HTTPAdapter <requests.adapters.HTTPAdapter>`.
		
		:param request: The :class:`PreparedRequest <PreparedRequest>` being sent.
		:param proxies: A dictionary of schemes or schemes and hosts to proxy URLs.
		:rtype: str
	**/
	public function request_url(request:Dynamic, proxies:Dynamic):Dynamic;
	/**
		Sends PreparedRequest object. Returns Response object.
		
		:param request: The :class:`PreparedRequest <PreparedRequest>` being sent.
		:param stream: (optional) Whether to stream the request content.
		:param timeout: (optional) How long to wait for the server to send
		    data before giving up, as a float, or a :ref:`(connect timeout,
		    read timeout) <timeouts>` tuple.
		:type timeout: float or tuple or urllib3 Timeout object
		:param verify: (optional) Either a boolean, in which case it controls whether
		    we verify the server's TLS certificate, or a string, in which case it
		    must be a path to a CA bundle to use
		:param cert: (optional) Any user-provided SSL certificate to be trusted.
		:param proxies: (optional) The proxies dictionary to apply to the request.
		:rtype: requests.Response
	**/
	public function send(request:Dynamic, ?stream:Dynamic, ?timeout:Dynamic, ?verify:Dynamic, ?cert:Dynamic, ?proxies:Dynamic):Dynamic;
}