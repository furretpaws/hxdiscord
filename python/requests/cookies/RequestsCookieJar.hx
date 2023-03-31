/* This file is generated, do not edit! */
package requests.cookies;
@:pythonImport("requests.cookies", "RequestsCookieJar") extern class RequestsCookieJar {
	static public var _MutableMapping__marker : Dynamic;
	static public var __abstractmethods__ : Dynamic;
	/**
		Metaclass for defining Abstract Base Classes (ABCs).
		
		Use this metaclass to create an ABC.  An ABC can be subclassed
		directly, and then acts as a mix-in class.  You can also register
		unrelated concrete classes (even built-in classes) and unrelated
		ABCs as 'virtual subclasses' -- these and their descendants will
		be considered subclasses of the registering ABC by the built-in
		issubclass() function, but the registering ABC won't show up in
		their MRO (Method Resolution Order) nor will method
		implementations defined by the registering ABC be callable (not
		even via super()).
	**/
	static public function __class__(name:Dynamic, bases:Dynamic, namespace:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Represent a PEP 585 generic type
		
		E.g. for t = list[int], t.__origin__ is list and t.__args__ is (int,).
	**/
	public function __class_getitem__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	public function __contains__(name:Dynamic):Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	/**
		Deletes a cookie given a name. Wraps ``cookielib.CookieJar``'s
		``remove_cookie_by_name()``.
	**/
	public function __delitem__(name:Dynamic):Dynamic;
	static public var __dict__ : Dynamic;
	/**
		Default dir() implementation.
	**/
	public function __dir__():Dynamic;
	static public var __doc__ : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(other:Dynamic):Dynamic;
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
		Dict-like __getitem__() for compatibility with client code. Throws
		exception if there are more than one cookie with name. In that case,
		use the more explicit get() method instead.
		
		.. warning:: operation is O(n), not O(1).
	**/
	public function __getitem__(name:Dynamic):Dynamic;
	/**
		Unlike a normal CookieJar, this class is pickleable.
	**/
	public function __getstate__():Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	static public var __hash__ : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__(?policy:Dynamic):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?policy:Dynamic):Void;
	/**
		This method is called when a class is subclassed.
		
		The default implementation does nothing. It may be
		overridden to extend subclasses.
	**/
	public function __init_subclass__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	public function __iter__():Dynamic;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Return number of contained cookies.
	**/
	public function __len__():Dynamic;
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
	static public var __reversed__ : Dynamic;
	/**
		Implement setattr(self, name, value).
	**/
	public function __setattr__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		Dict-like __setitem__ for compatibility with client code. Throws
		exception if there is already a cookie of that name in the jar. In that
		case, use the more explicit set() method instead.
	**/
	public function __setitem__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		Unlike a normal CookieJar, this class is pickleable.
	**/
	public function __setstate__(state:Dynamic):Dynamic;
	/**
		Size of object in memory, in bytes.
	**/
	public function __sizeof__():Dynamic;
	static public var __slots__ : Dynamic;
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
	static public function __subclasshook__(C:Dynamic):Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	static public var _abc_impl : Dynamic;
	/**
		Return a list of cookie-attributes to be returned to server.
		
		like ['foo="bar"; $Path="/"', ...]
		
		The $Version attribute is also added when appropriate (currently only
		once per request).
	**/
	public function _cookie_attrs(cookies:Dynamic):Dynamic;
	public function _cookie_from_cookie_tuple(tup:Dynamic, request:Dynamic):Dynamic;
	public function _cookies_for_domain(domain:Dynamic, request:Dynamic):Dynamic;
	/**
		Return a list of cookies to be returned to server.
	**/
	public function _cookies_for_request(request:Dynamic):Dynamic;
	public function _cookies_from_attrs_set(attrs_set:Dynamic, request:Dynamic):Dynamic;
	/**
		Requests uses this method internally to get cookie values.
		
		If there are conflicting cookies, _find arbitrarily chooses one.
		See _find_no_duplicates if you want an exception thrown if there are
		conflicting cookies.
		
		:param name: a string containing name of cookie
		:param domain: (optional) string containing domain of cookie
		:param path: (optional) string containing path of cookie
		:return: cookie.value
	**/
	public function _find(name:Dynamic, ?domain:Dynamic, ?path:Dynamic):Dynamic;
	/**
		Both ``__get_item__`` and ``get`` call this function: it's never
		used elsewhere in Requests.
		
		:param name: a string containing name of cookie
		:param domain: (optional) string containing domain of cookie
		:param path: (optional) string containing path of cookie
		:raises KeyError: if cookie is not found
		:raises CookieConflictError: if there are multiple cookies
		    that match name and optionally domain and path
		:return: cookie.value
	**/
	public function _find_no_duplicates(name:Dynamic, ?domain:Dynamic, ?path:Dynamic):Dynamic;
	/**
		Return list of tuples containing normalised cookie information.
		
		attrs_set is the list of lists of key,value pairs extracted from
		the Set-Cookie or Set-Cookie2 headers.
		
		Tuples are name, value, standard, rest, where name and value are the
		cookie name and value, standard is a dictionary containing the standard
		cookie-attributes (discard, secure, version, expires or max-age,
		domain, path and port) and rest is a dictionary containing the rest of
		the cookie-attributes.
	**/
	public function _normalized_cookie_tuples(attrs_set:Dynamic):Dynamic;
	public function _process_rfc2109_cookies(cookies:Dynamic):Dynamic;
	/**
		Add correct Cookie: header to request (urllib.request.Request object).
		
		The Cookie2 header is also added unless policy.hide_cookie2 is true.
	**/
	public function add_cookie_header(request:Dynamic):Dynamic;
	/**
		Clear some cookies.
		
		Invoking this method without arguments will clear all cookies.  If
		given a single argument, only cookies belonging to that domain will be
		removed.  If given two arguments, cookies belonging to the specified
		path within that domain are removed.  If given three arguments, then
		the cookie with the specified name, path and domain is removed.
		
		Raises KeyError if no matching cookie exists.
	**/
	public function clear(?domain:Dynamic, ?path:Dynamic, ?name:Dynamic):Dynamic;
	/**
		Discard all expired cookies.
		
		You probably don't need to call this method: expired cookies are never
		sent back to the server (provided you're using DefaultCookiePolicy),
		this method is called by CookieJar itself every so often, and the
		.save() method won't save expired cookies anyway (unless you ask
		otherwise by passing a true ignore_expires argument).
	**/
	public function clear_expired_cookies():Dynamic;
	/**
		Discard all session cookies.
		
		Note that the .save() method won't save session cookies anyway, unless
		you ask otherwise by passing a true ignore_discard argument.
	**/
	public function clear_session_cookies():Dynamic;
	/**
		Return a copy of this RequestsCookieJar.
	**/
	public function copy():Dynamic;
	static public var domain_re : Dynamic;
	static public var dots_re : Dynamic;
	/**
		Extract cookies from response, where allowable given the request.
	**/
	public function extract_cookies(response:Dynamic, request:Dynamic):Dynamic;
	/**
		Dict-like get() that also supports optional domain and path args in
		order to resolve naming collisions from using one cookie jar over
		multiple domains.
		
		.. warning:: operation is O(n), not O(1).
	**/
	public function get(name:Dynamic, ?_default:Dynamic, ?domain:Dynamic, ?path:Dynamic):Dynamic;
	/**
		Takes as an argument an optional domain and path and returns a plain
		old Python dict of name-value pairs of cookies that meet the
		requirements.
		
		:rtype: dict
	**/
	public function get_dict(?domain:Dynamic, ?path:Dynamic):Dynamic;
	/**
		Return the CookiePolicy instance used.
	**/
	public function get_policy():Dynamic;
	/**
		Dict-like items() that returns a list of name-value tuples from the
		jar. Allows client-code to call ``dict(RequestsCookieJar)`` and get a
		vanilla python dict of key value pairs.
		
		.. seealso:: keys() and values().
	**/
	public function items():Dynamic;
	/**
		Dict-like iteritems() that returns an iterator of name-value tuples
		from the jar.
		
		.. seealso:: iterkeys() and itervalues().
	**/
	public function iteritems():Dynamic;
	/**
		Dict-like iterkeys() that returns an iterator of names of cookies
		from the jar.
		
		.. seealso:: itervalues() and iteritems().
	**/
	public function iterkeys():Dynamic;
	/**
		Dict-like itervalues() that returns an iterator of values of cookies
		from the jar.
		
		.. seealso:: iterkeys() and iteritems().
	**/
	public function itervalues():Dynamic;
	/**
		Dict-like keys() that returns a list of names of cookies from the
		jar.
		
		.. seealso:: values() and items().
	**/
	public function keys():Dynamic;
	/**
		Utility method to list all the domains in the jar.
	**/
	public function list_domains():Dynamic;
	/**
		Utility method to list all the paths in the jar.
	**/
	public function list_paths():Dynamic;
	static public var magic_re : Dynamic;
	/**
		Return sequence of Cookie objects extracted from response object.
	**/
	public function make_cookies(response:Dynamic, request:Dynamic):Dynamic;
	/**
		Returns True if there are multiple domains in the jar.
		Returns False otherwise.
		
		:rtype: bool
	**/
	public function multiple_domains():Dynamic;
	static public var non_word_re : Dynamic;
	/**
		D.pop(k[,d]) -> v, remove specified key and return the corresponding value.
		If key is not found, d is returned if given, otherwise KeyError is raised.
	**/
	public function pop(key:Dynamic, ?_default:Dynamic):Dynamic;
	/**
		D.popitem() -> (k, v), remove and return some (key, value) pair
		as a 2-tuple; but raise KeyError if D is empty.
	**/
	public function popitem():Dynamic;
	static public var quote_re : Dynamic;
	/**
		Dict-like set() that also supports optional domain and path args in
		order to resolve naming collisions from using one cookie jar over
		multiple domains.
	**/
	public function set(name:Dynamic, value:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Set a cookie, without checking whether or not it should be set.
	**/
	public function set_cookie(cookie:Dynamic, ?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Set a cookie if policy says it's OK to do so.
	**/
	public function set_cookie_if_ok(cookie:Dynamic, request:Dynamic):Dynamic;
	public function set_policy(policy:Dynamic):Dynamic;
	/**
		D.setdefault(k[,d]) -> D.get(k,d), also set D[k]=d if k not in D
	**/
	public function setdefault(key:Dynamic, ?_default:Dynamic):Dynamic;
	static public var strict_domain_re : Dynamic;
	/**
		Updates this jar with cookies from another CookieJar or dict-like
	**/
	public function update(other:Dynamic):Dynamic;
	/**
		Dict-like values() that returns a list of values of cookies from the
		jar.
		
		.. seealso:: keys() and items().
	**/
	public function values():Dynamic;
}