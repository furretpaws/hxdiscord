/* This file is generated, do not edit! */
package requests.utils;
@:pythonImport("requests.utils") extern class Utils_Module {
	static public var DEFAULT_ACCEPT_ENCODING : Dynamic;
	static public var DEFAULT_CA_BUNDLE_PATH : Dynamic;
	static public var DEFAULT_PORTS : Dynamic;
	static public var HEADER_VALIDATORS : Dynamic;
	static public var NETRC_FILES : Dynamic;
	static public var UNRESERVED_SET : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var __version__ : Dynamic;
	static public var _null : Dynamic;
	static public var _null2 : Dynamic;
	static public var _null3 : Dynamic;
	/**
		Returns content type and parameters from given header
		
		:param header: string
		:return: tuple containing content type and dictionary of
		     parameters
	**/
	static public function _parse_content_type_header(header:Dynamic):Dynamic;
	/**
		Parse lists as described by RFC 2068 Section 2.
		
		In particular, parse comma-separated lists where the elements of
		the list may include quoted-strings.  A quoted-string could
		contain a comma.  A non-quoted string could have quotes in the
		middle.  Neither commas nor quotes count if they are escaped.
		Only double-quotes count, not single-quotes.
	**/
	static public function _parse_list_header(s:Dynamic):Dynamic;
	static public function _validate_header_part(header_part:Dynamic, header_kind:Dynamic, validator:Dynamic):Dynamic;
	/**
		Returns a CookieJar from a key/value dictionary.
		
		:param cj: CookieJar to insert cookies into.
		:param cookie_dict: Dict of key/values to insert into CookieJar.
		:rtype: CookieJar
	**/
	static public function add_dict_to_cookiejar(cj:Dynamic, cookie_dict:Dynamic):Dynamic;
	/**
		This function allows you to check if an IP belongs to a network subnet
		
		Example: returns True if ip = 192.168.1.1 and net = 192.168.1.0/24
		         returns False if ip = 192.168.1.1 and net = 192.168.100.0/24
		
		:rtype: bool
	**/
	static public function address_in_network(ip:Dynamic, net:Dynamic):Dynamic;
	/**
		Write a file to the disk in an atomic fashion
	**/
	static public function atomic_open(filename:Dynamic):Dynamic;
	static public var basestring : Dynamic;
	/**
		Verifies that header parts don't contain leading whitespace
		reserved characters, or return characters.
		
		:param header: tuple, in the format (name, value).
	**/
	static public function check_header_validity(header:Dynamic):Dynamic;
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
	/**
		Return a string representing the default user agent.
		
		:rtype: str
	**/
	static public function default_user_agent(?name:Dynamic):Dynamic;
	/**
		Returns a key/value dictionary from a CookieJar.
		
		:param cj: CookieJar object to extract cookies from.
		:rtype: dict
	**/
	static public function dict_from_cookiejar(cj:Dynamic):Dynamic;
	/**
		Returns an internal sequence dictionary update.
	**/
	static public function dict_to_sequence(d:Dynamic):Dynamic;
	/**
		Converts mask from /xx format to xxx.xxx.xxx.xxx
		
		Example: if mask is 24 function returns 255.255.255.0
		
		:rtype: str
	**/
	static public function dotted_netmask(mask:Dynamic):Dynamic;
	/**
		Replace nonexistent paths that look like they refer to a member of a zip
		archive with the location of an extracted copy of the target, or else
		just return the provided path unchanged.
	**/
	static public function extract_zipped_paths(path:Dynamic):Dynamic;
	/**
		Take an object and test to see if it can be represented as a
		dictionary. Unless it can not be represented as such, return an
		OrderedDict, e.g.,
		
		::
		
		    >>> from_key_val_list([('key', 'val')])
		    OrderedDict([('key', 'val')])
		    >>> from_key_val_list('string')
		    Traceback (most recent call last):
		    ...
		    ValueError: cannot encode objects that are not 2-tuples
		    >>> from_key_val_list({'key': 'val'})
		    OrderedDict([('key', 'val')])
		
		:rtype: OrderedDict
	**/
	static public function from_key_val_list(value:Dynamic):Dynamic;
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
		Returns encodings from given content string.
		
		:param content: bytestring to extract encodings from.
	**/
	static public function get_encodings_from_content(content:Dynamic):Dynamic;
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
		Returns the requested content back in unicode.
		
		:param r: Response object to get unicode content from.
		
		Tried:
		
		1. charset from content-type
		2. fall back and replace all unicode characters
		
		:rtype: str
	**/
	static public function get_unicode_from_response(r:Dynamic):Dynamic;
	/**
		Return a dictionary of scheme -> proxy server URL mappings.
		
		Returns settings gathered from the environment, if specified,
		or the registry.
	**/
	static public function getproxies():Dynamic;
	/**
		Return a dictionary of scheme -> proxy server URL mappings.
		
		Scan the environment for variables named <scheme>_proxy;
		this seems to be the standard convention.  If you need a
		different way, you can pass a proxies dictionary to the
		[Fancy]URLopener constructor.
	**/
	static public function getproxies_environment():Dynamic;
	/**
		Tries to guess the filename of the given object.
	**/
	static public function guess_filename(obj:Dynamic):Dynamic;
	/**
		:rtype: str
	**/
	static public function guess_json_utf(data:Dynamic):Dynamic;
	static public var integer_types : Dynamic;
	/**
		:rtype: bool
	**/
	static public function is_ipv4_address(string_ip:Dynamic):Dynamic;
	/**
		Very simple check of the cidr format in no_proxy variable.
		
		:rtype: bool
	**/
	static public function is_valid_cidr(string_network:Dynamic):Dynamic;
	/**
		Iterate over slices of a string.
	**/
	static public function iter_slices(string:Dynamic, slice_length:Dynamic):Dynamic;
	/**
		Shortcuts for generating request headers.
		
		:param keep_alive:
		    If ``True``, adds 'connection: keep-alive' header.
		
		:param accept_encoding:
		    Can be a boolean, list, or string.
		    ``True`` translates to 'gzip,deflate'.
		    List will get joined by comma.
		    String will be used as provided.
		
		:param user_agent:
		    String representing the user-agent you want, such as
		    "python-urllib3/0.6"
		
		:param basic_auth:
		    Colon-separated username:password string for 'authorization: basic ...'
		    auth header.
		
		:param proxy_basic_auth:
		    Colon-separated username:password string for 'proxy-authorization: basic ...'
		    auth header.
		
		:param disable_cache:
		    If ``True``, adds 'cache-control: no-cache' header.
		
		Example::
		
		    >>> make_headers(keep_alive=True, user_agent="Batman/1.0")
		    {'connection': 'keep-alive', 'user-agent': 'Batman/1.0'}
		    >>> make_headers(accept_encoding=True)
		    {'accept-encoding': 'gzip,deflate'}
	**/
	static public function make_headers(?keep_alive:Dynamic, ?accept_encoding:Dynamic, ?user_agent:Dynamic, ?basic_auth:Dynamic, ?proxy_basic_auth:Dynamic, ?disable_cache:Dynamic):Dynamic;
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
		Return a list of parsed link headers proxies.
		
		i.e. Link: <http:/.../front.jpeg>; rel=front; type="image/jpeg",<http://.../back.jpeg>; rel=back;type="image/jpeg"
		
		:rtype: list
	**/
	static public function parse_header_links(value:Dynamic):Dynamic;
	/**
		Parse lists as described by RFC 2068 Section 2.
		
		In particular, parse comma-separated lists where the elements of
		the list may include quoted-strings.  A quoted-string could
		contain a comma.  A non-quoted string could have quotes in the
		middle.  Quotes are removed automatically after parsing.
		
		It basically works like :func:`parse_set_header` just that items
		may appear multiple times and case sensitivity is preserved.
		
		The return value is a standard :class:`list`:
		
		>>> parse_list_header('token, "quoted value"')
		['token', 'quoted value']
		
		To create a header from the :class:`list` again, use the
		:func:`dump_header` function.
		
		:param value: a string with a list header.
		:return: :class:`list`
		:rtype: list
	**/
	static public function parse_list_header(value:Dynamic):Dynamic;
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
	/**
		Return True, if the host should be bypassed.
		
		Checks proxy settings gathered from the environment, if specified,
		or the registry.
	**/
	static public function proxy_bypass(host:Dynamic):Dynamic;
	/**
		Test if proxies should not be used for a particular host.
		
		Checks the proxy dict for the value of no_proxy, which should
		be a list of comma separated DNS suffixes, or '*' for all hosts.
	**/
	static public function proxy_bypass_environment(host:Dynamic, ?proxies:Dynamic):Dynamic;
	static public function proxy_bypass_registry(host:Dynamic):Dynamic;
	/**
		quote('abc def') -> 'abc%20def'
		
		Each part of a URL, e.g. the path info, the query, etc., has a
		different set of reserved characters that must be quoted. The
		quote function offers a cautious (not minimal) way to quote a
		string for most of these parts.
		
		RFC 3986 Uniform Resource Identifier (URI): Generic Syntax lists
		the following (un)reserved characters.
		
		unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
		reserved      = gen-delims / sub-delims
		gen-delims    = ":" / "/" / "?" / "#" / "[" / "]" / "@"
		sub-delims    = "!" / "$" / "&" / "'" / "(" / ")"
		              / "*" / "+" / "," / ";" / "="
		
		Each of the reserved characters is reserved in some component of a URL,
		but not necessarily in all of them.
		
		The quote function %-escapes all characters that are neither in the
		unreserved chars ("always safe") nor the additional chars set via the
		safe arg.
		
		The default for the safe arg is '/'. The character is reserved, but in
		typical usage the quote function is being called on a path where the
		existing slash characters are to be preserved.
		
		Python 3.7 updates from using RFC 2396 to RFC 3986 to quote URL strings.
		Now, "~" is included in the set of unreserved characters.
		
		string and safe may be either str or bytes objects. encoding and errors
		must not be specified if string is a bytes object.
		
		The optional encoding and errors parameters specify how to deal with
		non-ASCII characters, as accepted by the str.encode method.
		By default, encoding='utf-8' (characters are encoded with UTF-8), and
		errors='strict' (unsupported characters raise a UnicodeEncodeError).
	**/
	static public function quote(string:Dynamic, ?safe:Dynamic, ?encoding:Dynamic, ?errors:Dynamic):Dynamic;
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
		Select a proxy for the url, if applicable.
		
		:param url: The url being for the request
		:param proxies: A dictionary of schemes or schemes and hosts to proxy URLs
	**/
	static public function select_proxy(url:Dynamic, proxies:Dynamic):Dynamic;
	/**
		Set the environment variable 'env_name' to 'value'
		
		Save previous value, yield, and then restore the previous value stored in
		the environment variable 'env_name'.
		
		If 'value' is None, do nothing
	**/
	static public function set_environ(env_name:Dynamic, value:Dynamic):Dynamic;
	/**
		Returns whether we should bypass proxies or not.
		
		:rtype: bool
	**/
	static public function should_bypass_proxies(url:Dynamic, no_proxy:Dynamic):Dynamic;
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
		Replace %xx escapes by their single-character equivalent. The optional
		encoding and errors parameters specify how to decode percent-encoded
		sequences into Unicode characters, as accepted by the bytes.decode()
		method.
		By default, percent-encoded sequences are decoded with UTF-8, and invalid
		sequences are replaced by a placeholder character.
		
		unquote('abc%20def') -> 'abc def'.
	**/
	static public function unquote(string:Dynamic, ?encoding:Dynamic, ?errors:Dynamic):Dynamic;
	/**
		Unquotes a header value.  (Reversal of :func:`quote_header_value`).
		This does not use the real unquoting but what browsers are actually
		using for quoting.
		
		:param value: the header value to unquote.
		:rtype: str
	**/
	static public function unquote_header_value(value:Dynamic, ?is_filename:Dynamic):Dynamic;
	/**
		Un-escape any percent-escape sequences in a URI that are unreserved
		characters. This leaves all reserved, illegal and non-ASCII bytes encoded.
		
		:rtype: str
	**/
	static public function unquote_unreserved(uri:Dynamic):Dynamic;
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
	/**
		Put a parsed URL back together again.  This may result in a
		slightly different, but equivalent URL, if the URL that was parsed
		originally had redundant delimiters, e.g. a ? with an empty query
		(the draft states that these are equivalent).
	**/
	static public function urlunparse(components:Dynamic):Dynamic;
}