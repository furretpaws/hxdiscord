/* This file is generated, do not edit! */
package requests.models;
@:pythonImport("requests.models", "Response") extern class Response {
	static public var __attrs__ : Dynamic;
	/**
		Returns True if :attr:`status_code` is less than 400.
		
		This attribute checks if the status code of the response is between
		400 and 600 to see if there was a client error or a server error. If
		the status code, is between 200 and 400, this will return True. This
		is **not** a check to see if the response code is ``200 OK``.
	**/
	public function __bool__():Dynamic;
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
		Allows you to use a response as an iterator.
	**/
	public function __iter__():Dynamic;
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
		Returns True if :attr:`status_code` is less than 400.
		
		This attribute checks if the status code of the response is between
		400 and 600 to see if there was a client error or a server error. If
		the status code, is between 200 and 400, this will return True. This
		is **not** a check to see if the response code is ``200 OK``.
	**/
	public function __nonzero__():Dynamic;
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
		The apparent encoding, provided by the charset_normalizer or chardet libraries.
	**/
	public var apparent_encoding : Dynamic;
	/**
		Releases the connection back to the pool. Once this method has been
		called the underlying ``raw`` object must not be accessed again.
		
		*Note: Should not normally need to be called explicitly.*
	**/
	public function close():Dynamic;
	/**
		Content of the response, in bytes.
	**/
	public var content : Dynamic;
	/**
		True if this Response one of the permanent versions of redirect.
	**/
	public var is_permanent_redirect : Dynamic;
	/**
		True if this Response is a well-formed HTTP redirect that could have
		been processed automatically (by :meth:`Session.resolve_redirects`).
	**/
	public var is_redirect : Dynamic;
	/**
		Iterates over the response data.  When stream=True is set on the
		request, this avoids reading the content at once into memory for
		large responses.  The chunk size is the number of bytes it should
		read into memory.  This is not necessarily the length of each item
		returned as decoding can take place.
		
		chunk_size must be of type int or None. A value of None will
		function differently depending on the value of `stream`.
		stream=True will read data as it arrives in whatever size the
		chunks are received. If stream=False, data is returned as
		a single chunk.
		
		If decode_unicode is True, content will be decoded using the best
		available encoding based on the response.
	**/
	public function iter_content(?chunk_size:Dynamic, ?decode_unicode:Dynamic):Dynamic;
	/**
		Iterates over the response data, one line at a time.  When
		stream=True is set on the request, this avoids reading the
		content at once into memory for large responses.
		
		.. note:: This method is not reentrant safe.
	**/
	public function iter_lines(?chunk_size:Dynamic, ?decode_unicode:Dynamic, ?delimiter:Dynamic):Dynamic;
	/**
		Returns the json-encoded content of a response, if any.
		
		:param \*\*kwargs: Optional arguments that ``json.loads`` takes.
		:raises requests.exceptions.JSONDecodeError: If the response body does not
		    contain valid json.
	**/
	public function json(?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Returns the parsed header links of the response, if any.
	**/
	public var links : Dynamic;
	/**
		Returns a PreparedRequest for the next request in a redirect chain, if there is one.
	**/
	public var next : Dynamic;
	/**
		Returns True if :attr:`status_code` is less than 400, False if not.
		
		This attribute checks if the status code of the response is between
		400 and 600 to see if there was a client error or a server error. If
		the status code is between 200 and 400, this will return True. This
		is **not** a check to see if the response code is ``200 OK``.
	**/
	public var ok : Dynamic;
	/**
		Raises :class:`HTTPError`, if one occurred.
	**/
	public function raise_for_status():Dynamic;
	/**
		Content of the response, in unicode.
		
		If Response.encoding is None, encoding will be guessed using
		``charset_normalizer`` or ``chardet``.
		
		The encoding of the response content is determined based solely on HTTP
		headers, following RFC 2616 to the letter. If you can take advantage of
		non-HTTP knowledge to make a better guess at the encoding, you should
		set ``r.encoding`` appropriately before accessing this property.
	**/
	public var text : Dynamic;
}