/* This file is generated, do not edit! */
package requests.cookies;
@:pythonImport("requests.cookies") extern class Cookies_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _copy_cookie_jar(jar:Dynamic):Dynamic;
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
		Make a cookie from underspecified parameters.
		
		By default, the pair of `name` and `value` will be set for the domain ''
		and sent on every request (this is sometimes called a "supercookie").
	**/
	static public function create_cookie(name:Dynamic, value:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Extract the cookies from the response into a CookieJar.
		
		:param jar: cookielib.CookieJar (not necessarily a RequestsCookieJar)
		:param request: our own requests.Request object
		:param response: urllib3.HTTPResponse object
	**/
	static public function extract_cookies_to_jar(jar:Dynamic, request:Dynamic, response:Dynamic):Dynamic;
	/**
		Produce an appropriate Cookie header string to be sent with `request`, or None.
		
		:rtype: str
	**/
	static public function get_cookie_header(jar:Dynamic, request:Dynamic):Dynamic;
	/**
		Add cookies to cookiejar and returns a merged CookieJar.
		
		:param cookiejar: CookieJar object to add the cookies to.
		:param cookies: Dictionary or CookieJar object to be added.
		:rtype: CookieJar
	**/
	static public function merge_cookies(cookiejar:Dynamic, cookies:Dynamic):Dynamic;
	/**
		Convert a Morsel object into a Cookie containing the one k/v pair.
	**/
	static public function morsel_to_cookie(morsel:Dynamic):Dynamic;
	/**
		Unsets a cookie by name, by default over all domains and paths.
		
		Wraps CookieJar.clear(), is O(n).
	**/
	static public function remove_cookie_by_name(cookiejar:Dynamic, name:Dynamic, ?domain:Dynamic, ?path:Dynamic):Dynamic;
	/**
		Given a string object, regardless of type, returns a representation of
		that string in the native string type, encoding and decoding where
		necessary. This assumes ASCII unless told otherwise.
	**/
	static public function to_native_string(string:Dynamic, ?encoding:Dynamic):Dynamic;
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
	/**
		Put a parsed URL back together again.  This may result in a
		slightly different, but equivalent URL, if the URL that was parsed
		originally had redundant delimiters, e.g. a ? with an empty query
		(the draft states that these are equivalent).
	**/
	static public function urlunparse(components:Dynamic):Dynamic;
}