/* This file is generated, do not edit! */
package requests.compat;
@:pythonImport("requests.compat") extern class Compat_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _ver : Dynamic;
	static public var basestring : Dynamic;
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
	static public var has_simplejson : Dynamic;
	static public var integer_types : Dynamic;
	static public var is_py2 : Dynamic;
	static public var is_py3 : Dynamic;
	static public var numeric_types : Dynamic;
	/**
		Parse lists as described by RFC 2068 Section 2.
		
		In particular, parse comma-separated lists where the elements of
		the list may include quoted-strings.  A quoted-string could
		contain a comma.  A non-quoted string could have quotes in the
		middle.  Neither commas nor quotes count if they are escaped.
		Only double-quotes count, not single-quotes.
	**/
	static public function parse_http_list(s:Dynamic):Dynamic;
	/**
		Return True, if host should be bypassed.
		
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
		Like quote(), but also replace ' ' with '+', as required for quoting
		HTML form values. Plus signs in the original string are escaped unless
		they are included in safe. It also does not have safe default to '/'.
	**/
	static public function quote_plus(string:Dynamic, ?safe:Dynamic, ?encoding:Dynamic, ?errors:Dynamic):Dynamic;
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
		Like unquote(), but also replace plus signs by spaces, as required for
		unquoting HTML form values.
		
		unquote_plus('%7e/abc+def') -> '~/abc def'
	**/
	static public function unquote_plus(string:Dynamic, ?encoding:Dynamic, ?errors:Dynamic):Dynamic;
	/**
		Removes any existing fragment from URL.
		
		Returns a tuple of the defragmented URL and the fragment.  If
		the URL contained no fragments, the second element is the
		empty string.
	**/
	static public function urldefrag(url:Dynamic):Dynamic;
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