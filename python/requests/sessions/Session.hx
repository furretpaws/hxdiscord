/* This file is generated, do not edit! */
package requests.sessions;
@:pythonImport("requests.sessions", "Session") extern class Session {
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
	public function __enter__():Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic):Dynamic;
	public function __exit__(?args:python.VarArgs<Dynamic>):Dynamic;
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
	public function ___init__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new():Void;
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
		Closes all adapters and as such the session
	**/
	public function close():Dynamic;
	/**
		Sends a DELETE request. Returns :class:`Response` object.
		
		:param url: URL for the new :class:`Request` object.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:rtype: requests.Response
	**/
	public function delete(url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a GET request. Returns :class:`Response` object.
		
		:param url: URL for the new :class:`Request` object.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:rtype: requests.Response
	**/
	public function get(url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Returns the appropriate connection adapter for the given URL.
		
		:rtype: requests.adapters.BaseAdapter
	**/
	public function get_adapter(url:Dynamic):Dynamic;
	/**
		Receives a Response. Returns a redirect URI or ``None``
	**/
	public function get_redirect_target(resp:Dynamic):Dynamic;
	/**
		Sends a HEAD request. Returns :class:`Response` object.
		
		:param url: URL for the new :class:`Request` object.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:rtype: requests.Response
	**/
	public function head(url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Check the environment and merge it with some settings.
		
		:rtype: dict
	**/
	public function merge_environment_settings(url:Dynamic, proxies:Dynamic, stream:Dynamic, verify:Dynamic, cert:Dynamic):Dynamic;
	/**
		Registers a connection adapter to a prefix.
		
		Adapters are sorted in descending order by prefix length.
	**/
	public function mount(prefix:Dynamic, adapter:Dynamic):Dynamic;
	/**
		Sends a OPTIONS request. Returns :class:`Response` object.
		
		:param url: URL for the new :class:`Request` object.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:rtype: requests.Response
	**/
	public function options(url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a PATCH request. Returns :class:`Response` object.
		
		:param url: URL for the new :class:`Request` object.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:rtype: requests.Response
	**/
	public function patch(url:Dynamic, ?data:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a POST request. Returns :class:`Response` object.
		
		:param url: URL for the new :class:`Request` object.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param json: (optional) json to send in the body of the :class:`Request`.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:rtype: requests.Response
	**/
	public function post(url:Dynamic, ?data:Dynamic, ?json:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Constructs a :class:`PreparedRequest <PreparedRequest>` for
		transmission and returns it. The :class:`PreparedRequest` has settings
		merged from the :class:`Request <Request>` instance and those of the
		:class:`Session`.
		
		:param request: :class:`Request` instance to prepare with this
		    session's settings.
		:rtype: requests.PreparedRequest
	**/
	public function prepare_request(request:Dynamic):Dynamic;
	/**
		Sends a PUT request. Returns :class:`Response` object.
		
		:param url: URL for the new :class:`Request` object.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:rtype: requests.Response
	**/
	public function put(url:Dynamic, ?data:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		When being redirected we may want to strip authentication from the
		request to avoid leaking credentials. This method intelligently removes
		and reapplies authentication where possible to avoid credential loss.
	**/
	public function rebuild_auth(prepared_request:Dynamic, response:Dynamic):Dynamic;
	/**
		When being redirected we may want to change the method of the request
		based on certain specs or browser behavior.
	**/
	public function rebuild_method(prepared_request:Dynamic, response:Dynamic):Dynamic;
	/**
		This method re-evaluates the proxy configuration by considering the
		environment variables. If we are redirected to a URL covered by
		NO_PROXY, we strip the proxy configuration. Otherwise, we set missing
		proxy keys for this URL (in case they were stripped by a previous
		redirect).
		
		This method also replaces the Proxy-Authorization header where
		necessary.
		
		:rtype: dict
	**/
	public function rebuild_proxies(prepared_request:Dynamic, proxies:Dynamic):Dynamic;
	/**
		Constructs a :class:`Request <Request>`, prepares it and sends it.
		Returns :class:`Response <Response>` object.
		
		:param method: method for the new :class:`Request` object.
		:param url: URL for the new :class:`Request` object.
		:param params: (optional) Dictionary or bytes to be sent in the query
		    string for the :class:`Request`.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param json: (optional) json to send in the body of the
		    :class:`Request`.
		:param headers: (optional) Dictionary of HTTP Headers to send with the
		    :class:`Request`.
		:param cookies: (optional) Dict or CookieJar object to send with the
		    :class:`Request`.
		:param files: (optional) Dictionary of ``'filename': file-like-objects``
		    for multipart encoding upload.
		:param auth: (optional) Auth tuple or callable to enable
		    Basic/Digest/Custom HTTP Auth.
		:param timeout: (optional) How long to wait for the server to send
		    data before giving up, as a float, or a :ref:`(connect timeout,
		    read timeout) <timeouts>` tuple.
		:type timeout: float or tuple
		:param allow_redirects: (optional) Set to True by default.
		:type allow_redirects: bool
		:param proxies: (optional) Dictionary mapping protocol or protocol and
		    hostname to the URL of the proxy.
		:param stream: (optional) whether to immediately download the response
		    content. Defaults to ``False``.
		:param verify: (optional) Either a boolean, in which case it controls whether we verify
		    the server's TLS certificate, or a string, in which case it must be a path
		    to a CA bundle to use. Defaults to ``True``. When set to
		    ``False``, requests will accept any TLS certificate presented by
		    the server, and will ignore hostname mismatches and/or expired
		    certificates, which will make your application vulnerable to
		    man-in-the-middle (MitM) attacks. Setting verify to ``False``
		    may be useful during local development or testing.
		:param cert: (optional) if String, path to ssl client cert file (.pem).
		    If Tuple, ('cert', 'key') pair.
		:rtype: requests.Response
	**/
	public function request(method:Dynamic, url:Dynamic, ?params:Dynamic, ?data:Dynamic, ?headers:Dynamic, ?cookies:Dynamic, ?files:Dynamic, ?auth:Dynamic, ?timeout:Dynamic, ?allow_redirects:Dynamic, ?proxies:Dynamic, ?hooks:Dynamic, ?stream:Dynamic, ?verify:Dynamic, ?cert:Dynamic, ?json:Dynamic):Dynamic;
	/**
		Receives a Response. Returns a generator of Responses or Requests.
	**/
	public function resolve_redirects(resp:Dynamic, req:Dynamic, ?stream:Dynamic, ?timeout:Dynamic, ?verify:Dynamic, ?cert:Dynamic, ?proxies:Dynamic, ?yield_requests:Dynamic, ?adapter_kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Send a given PreparedRequest.
		
		:rtype: requests.Response
	**/
	public function send(request:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Decide whether Authorization header should be removed when redirecting
	**/
	public function should_strip_auth(old_url:Dynamic, new_url:Dynamic):Dynamic;
}