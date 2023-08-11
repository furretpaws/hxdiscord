/* This file is generated, do not edit! */
package requests.auth;
@:pythonImport("requests.auth") extern class Auth_Module {
	static public var CONTENT_TYPE_FORM_URLENCODED : Dynamic;
	static public var CONTENT_TYPE_MULTI_PART : Dynamic;
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
	/**
		Encode the bytes-like object s using Base64 and return a bytes object.
		
		Optional altchars should be a byte string of length 2 which specifies an
		alternative alphabet for the '+' and '/' characters.  This allows an
		application to e.g. generate url or filesystem safe Base64 strings.
	**/
	static public function b64encode(s:Dynamic, ?altchars:Dynamic):Dynamic;
	static public var basestring : Dynamic;
	/**
		Extract the cookies from the response into a CookieJar.
		
		:param jar: cookielib.CookieJar (not necessarily a RequestsCookieJar)
		:param request: our own requests.Request object
		:param response: urllib3.HTTPResponse object
	**/
	static public function extract_cookies_to_jar(jar:Dynamic, request:Dynamic, response:Dynamic):Dynamic;
	/**
		Parse lists of key, value pairs as described by RFC 2068 Section 2 and
		convert them into a python dict:
		
		>>> d = parse_dict_header('foo="is a fish", bar="as well"')
		>>> type(d) is dict
		True
		>>> sorted(d.items())
		[('bar', 'as well'), ('foo', 'is a fish')]
		
		If there is no value for a key it will be `None`:
		
		>>> parse_dict_header('key_without_value')
		{'key_without_value': None}
		
		To create a header from the :class:`dict` again, use the
		:func:`dump_header` function.
		
		:param value: a string with a dict header.
		:return: :class:`dict`
		:rtype: dict
	**/
	static public function parse_dict_header(value:Dynamic):Dynamic;
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
}