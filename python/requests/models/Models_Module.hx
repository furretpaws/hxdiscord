/* This file is generated, do not edit! */
package requests.models;
@:pythonImport("requests.models") extern class Models_Module {
	static public var CONTENT_CHUNK_SIZE : Dynamic;
	static public var DEFAULT_REDIRECT_LIMIT : Dynamic;
	static public var ITER_CHUNK_SIZE : Dynamic;
	static public var REDIRECT_STATI : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _copy_cookie_jar(jar:Dynamic):Dynamic;
	static public var basestring : Dynamic;
	/**
		Verifies that header parts don't contain leading whitespace
		reserved characters, or return characters.
		
		:param header: tuple, in the format (name, value).
	**/
	static public function check_header_validity(header:Dynamic):Dynamic;
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
	static public function default_hooks():Dynamic;
	/**
		Encode a dictionary of ``fields`` using the multipart/form-data MIME format.
		
		:param fields:
		    Dictionary of fields or list of (key, :class:`~urllib3.fields.RequestField`).
		
		:param boundary:
		    If not specified, then a random boundary will be generated using
		    :func:`urllib3.filepost.choose_boundary`.
	**/
	static public function encode_multipart_formdata(fields:Dynamic, ?boundary:Dynamic):Dynamic;
	/**
		Given a url with authentication components, extract them into a tuple of
		username,password.
		
		:rtype: (str,str)
	**/
	static public function get_auth_from_url(url:Dynamic):Dynamic;
	/**
		Produce an appropriate Cookie header string to be sent with `request`, or None.
		
		:rtype: str
	**/
	static public function get_cookie_header(jar:Dynamic, request:Dynamic):Dynamic;
	/**
		Tries to guess the filename of the given object.
	**/
	static public function guess_filename(obj:Dynamic):Dynamic;
	/**
		:rtype: str
	**/
	static public function guess_json_utf(data:Dynamic):Dynamic;
	/**
		Iterate over slices of a string.
	**/
	static public function iter_slices(string:Dynamic, slice_length:Dynamic):Dynamic;
	/**
		Return a list of parsed link headers proxies.
		
		i.e. Link: <http:/.../front.jpeg>; rel=front; type="image/jpeg",<http://.../back.jpeg>; rel=back;type="image/jpeg"
		
		:rtype: list
	**/
	static public function parse_header_links(value:Dynamic):Dynamic;
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
		Re-quote the given URI.
		
		This function passes the given URI through an unquote/quote cycle to
		ensure that it is fully and consistently quoted.
		
		:rtype: str
	**/
	static public function requote_uri(uri:Dynamic):Dynamic;
	/**
		Stream decodes an iterator.
	**/
	static public function stream_decode_response_unicode(iterator:Dynamic, r:Dynamic):Dynamic;
	static public function super_len(o:Dynamic):Dynamic;
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
		Determine if unicode string only contains ASCII characters.
		
		:param str u_string: unicode string to check. Must be unicode
		    and not Python 2 `str`.
		:rtype: bool
	**/
	static public function unicode_is_ascii(u_string:Dynamic):Dynamic;
	/**
		Encode a dict or sequence of two-element tuples into a URL query string.
		
		If any values in the query arg are sequences and doseq is true, each
		sequence element is converted to a separate parameter.
		
		If the query arg is a sequence of two-element tuples, the order of the
		parameters in the output will match the order of parameters in the
		input.
		
		The components of a query arg may each be either a string or a bytes type.
		
		The safe, encoding, and errors parameters are passed down to the function
		specified by quote_via (encoding and errors only if a component is a str).
	**/
	static public function urlencode(query:Dynamic, ?doseq:Dynamic, ?safe:Dynamic, ?encoding:Dynamic, ?errors:Dynamic, ?quote_via:Dynamic):Dynamic;
	/**
		Parse a URL into 5 components:
		<scheme>://<netloc>/<path>?<query>#<fragment>
		
		The result is a named 5-tuple with fields corresponding to the
		above. It is either a SplitResult or SplitResultBytes object,
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
	static public function urlsplit(url:Dynamic, ?scheme:Dynamic, ?allow_fragments:Dynamic):Dynamic;
	/**
		Put a parsed URL back together again.  This may result in a
		slightly different, but equivalent URL, if the URL that was parsed
		originally had redundant delimiters, e.g. a ? with an empty query
		(the draft states that these are equivalent).
	**/
	static public function urlunparse(components:Dynamic):Dynamic;
}