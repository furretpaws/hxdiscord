/* This file is generated, do not edit! */
package requests.sessions;
@:pythonImport("requests.sessions") extern class Sessions_Module {
	static public var DEFAULT_PORTS : Dynamic;
	static public var DEFAULT_REDIRECT_LIMIT : Dynamic;
	static public var REDIRECT_STATI : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Returns a Basic Auth string.
	**/
	static public function _basic_auth_str(username:Dynamic, password:Dynamic):Dynamic;
	static public var codes : Dynamic;
	/**
		Returns a CookieJar from a key/value dictionary.
		
		:param cookie_dict: Dict of key/values to insert into CookieJar.
		:param cookiejar: (optional) A cookiejar to add the cookies to.
		:param overwrite: (optional) If False, will not replace cookies
		    already in the jar with new ones.
		:rtype: CookieJar
	**/
	static public function cookiejar_from_dict(cookie_dict:Dynamic, ?cookiejar:Dynamic, ?overwrite:Dynamic):Dynamic;
	/**
		:rtype: requests.structures.CaseInsensitiveDict
	**/
	static public function default_headers():Dynamic;
	static public function default_hooks():Dynamic;
	/**
		Dispatches a hook dictionary on a given piece of data.
	**/
	static public function dispatch_hook(key:Dynamic, hooks:Dynamic, hook_data:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Extract the cookies from the response into a CookieJar.
		
		:param jar: cookielib.CookieJar (not necessarily a RequestsCookieJar)
		:param request: our own requests.Request object
		:param response: urllib3.HTTPResponse object
	**/
	static public function extract_cookies_to_jar(jar:Dynamic, request:Dynamic, response:Dynamic):Dynamic;
	/**
		Given a url with authentication components, extract them into a tuple of
		username,password.
		
		:rtype: (str,str)
	**/
	static public function get_auth_from_url(url:Dynamic):Dynamic;
	/**
		Return a dict of environment proxies.
		
		:rtype: dict
	**/
	static public function get_environ_proxies(url:Dynamic, ?no_proxy:Dynamic):Dynamic;
	/**
		Returns the Requests tuple auth for a given url from netrc.
	**/
	static public function get_netrc_auth(url:Dynamic, ?raise_errors:Dynamic):Dynamic;
	/**
		Add cookies to cookiejar and returns a merged CookieJar.
		
		:param cookiejar: CookieJar object to add the cookies to.
		:param cookies: Dictionary or CookieJar object to be added.
		:rtype: CookieJar
	**/
	static public function merge_cookies(cookiejar:Dynamic, cookies:Dynamic):Dynamic;
	/**
		Properly merges both requests and session hooks.
		
		This is necessary because when request_hooks == {'response': []}, the
		merge breaks Session hooks entirely.
	**/
	static public function merge_hooks(request_hooks:Dynamic, session_hooks:Dynamic, ?dict_class:Dynamic):Dynamic;
	/**
		Determines appropriate setting for a given request, taking into account
		the explicit setting on that request, and the setting in the session. If a
		setting is a dictionary, they will be merged together using `dict_class`
	**/
	static public function merge_setting(request_setting:Dynamic, session_setting:Dynamic, ?dict_class:Dynamic):Dynamic;
	/**
		perf_counter() -> float
		
		Performance counter for benchmarking.
	**/
	static public function preferred_clock(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Re-quote the given URI.
		
		This function passes the given URI through an unquote/quote cycle to
		ensure that it is fully and consistently quoted.
		
		:rtype: str
	**/
	static public function requote_uri(uri:Dynamic):Dynamic;
	/**
		This method takes proxy information from a request and configuration
		input to resolve a mapping of target proxies. This will consider settings
		such a NO_PROXY to strip proxy configurations.
		
		:param request: Request or PreparedRequest
		:param proxies: A dictionary of schemes or schemes and hosts to proxy URLs
		:param trust_env: Boolean declaring whether to trust environment configs
		
		:rtype: dict
	**/
	static public function resolve_proxies(request:Dynamic, proxies:Dynamic, ?trust_env:Dynamic):Dynamic;
	/**
		Move file pointer back to its recorded starting position
		so it can be read again on redirect.
	**/
	static public function rewind_body(prepared_request:Dynamic):Dynamic;
	/**
		Returns a :class:`Session` for context-management.
		
		.. deprecated:: 1.0.0
		
		    This method has been deprecated since version 1.0.0 and is only kept for
		    backwards compatibility. New code should use :class:`~requests.sessions.Session`
		    to create a session. This may be removed at a future date.
		
		:rtype: Session
	**/
	static public function session():Dynamic;
	/**
		Returns whether we should bypass proxies or not.
		
		:rtype: bool
	**/
	static public function should_bypass_proxies(url:Dynamic, no_proxy:Dynamic):Dynamic;
	/**
		Take an object and test to see if it can be represented as a
		dictionary. If it can be, return a list of tuples, e.g.,
		
		::
		
		    >>> to_key_val_list([('key', 'val')])
		    [('key', 'val')]
		    >>> to_key_val_list({'key': 'val'})
		    [('key', 'val')]
		    >>> to_key_val_list('string')
		    Traceback (most recent call last):
		    ...
		    ValueError: cannot encode objects that are not 2-tuples
		
		:rtype: list
	**/
	static public function to_key_val_list(value:Dynamic):Dynamic;
	/**
		Given a string object, regardless of type, returns a representation of
		that string in the native string type, encoding and decoding where
		necessary. This assumes ASCII unless told otherwise.
	**/
	static public function to_native_string(string:Dynamic, ?encoding:Dynamic):Dynamic;
	/**
		Join a base URL and a possibly relative URL to form an absolute
		interpretation of the latter.
	**/
	static public function urljoin(base:Dynamic, url:Dynamic, ?allow_fragments:Dynamic):Dynamic;
	/**
		Parse a URL into 6 components:
		<scheme>://<netloc>/<path>;<params>?<query>#<fragment>
		
		The result is a named 6-tuple with fields corresponding to the
		above. It is either a ParseResult or ParseResultBytes object,
		depending on the type of the url parameter.
		
		The username, password, hostname, and port sub-components of netloc
		can also be accessed as attributes of the returned object.
		
		The scheme argument provides the default value of the scheme
		component when no scheme is found in url.
		
		If allow_fragments is False, no attempt is made to separate the
		fragment component from the previous component, which can be either
		path or query.
		
		Note that % escapes are not expanded.
	**/
	static public function urlparse(url:Dynamic, ?scheme:Dynamic, ?allow_fragments:Dynamic):Dynamic;
}