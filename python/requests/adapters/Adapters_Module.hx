/* This file is generated, do not edit! */
package requests.adapters;
@:pythonImport("requests.adapters") extern class Adapters_Module {
	static public var DEFAULT_CA_BUNDLE_PATH : Dynamic;
	static public var DEFAULT_POOLBLOCK : Dynamic;
	static public var DEFAULT_POOLSIZE : Dynamic;
	static public var DEFAULT_POOL_TIMEOUT : Dynamic;
	static public var DEFAULT_RETRIES : Dynamic;
	static public function SOCKSProxyManager(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
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
	static public var basestring : Dynamic;
	/**
		Extract the cookies from the response into a CookieJar.
		
		:param jar: cookielib.CookieJar (not necessarily a RequestsCookieJar)
		:param request: our own requests.Request object
		:param response: urllib3.HTTPResponse object
	**/
	static public function extract_cookies_to_jar(jar:Dynamic, request:Dynamic, response:Dynamic):Dynamic;
	/**
		Replace nonexistent paths that look like they refer to a member of a zip
		archive with the location of an extracted copy of the target, or else
		just return the provided path unchanged.
	**/
	static public function extract_zipped_paths(path:Dynamic):Dynamic;
	/**
		Given a url with authentication components, extract them into a tuple of
		username,password.
		
		:rtype: (str,str)
	**/
	static public function get_auth_from_url(url:Dynamic):Dynamic;
	/**
		Returns encodings from given HTTP Header Dict.
		
		:param headers: dictionary to extract encoding from.
		:rtype: str
	**/
	static public function get_encoding_from_headers(headers:Dynamic):Dynamic;
	/**
		Given a url, return a parsed :class:`.Url` namedtuple. Best-effort is
		performed to parse incomplete urls. Fields not provided will be None.
		This parser is RFC 3986 and RFC 6874 compliant.
		
		The parser logic and helper functions are based heavily on
		work done in the ``rfc3986`` module.
		
		:param str url: URL to parse into a :class:`.Url` namedtuple.
		
		Partly backwards-compatible with :mod:`urlparse`.
		
		Example::
		
		    >>> parse_url('http://google.com/mail/')
		    Url(scheme='http', host='google.com', port=None, path='/mail/', ...)
		    >>> parse_url('google.com:80')
		    Url(scheme=None, host='google.com', port=80, path=None, ...)
		    >>> parse_url('/foo?bar')
		    Url(scheme=None, host=None, port=None, path='/foo', query='bar', ...)
	**/
	static public function parse_url(url:Dynamic):Dynamic;
	/**
		Given a URL that may or may not have a scheme, prepend the given scheme.
		Does not replace a present scheme with the one provided as an argument.
		
		:rtype: str
	**/
	static public function prepend_scheme_if_needed(url:Dynamic, new_scheme:Dynamic):Dynamic;
	static public function proxy_from_url(url:Dynamic, ?kw:python.KwArgs<Dynamic>):Dynamic;
	/**
		Select a proxy for the url, if applicable.
		
		:param url: The url being for the request
		:param proxies: A dictionary of schemes or schemes and hosts to proxy URLs
	**/
	static public function select_proxy(url:Dynamic, proxies:Dynamic):Dynamic;
	/**
		Given a url remove the fragment and the authentication part.
		
		:rtype: str
	**/
	static public function urldefragauth(url:Dynamic):Dynamic;
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