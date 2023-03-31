/* This file is generated, do not edit! */
package requests.models;
@:pythonImport("requests.models", "PreparedRequest") extern class PreparedRequest {
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
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic):Dynamic;
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
		Build the body for a multipart/form-data request.
		
		Will successfully encode files when passed as a dict or a list of
		tuples. Order is retained if data is a list of tuples but arbitrary
		if parameters are supplied as a dict.
		The tuples may be 2-tuples (filename, fileobj), 3-tuples (filename, fileobj, contentype)
		or 4-tuples (filename, fileobj, contentype, custom_headers).
	**/
	static public function _encode_files(files:Dynamic, data:Dynamic):Dynamic;
	/**
		Encode parameters in a piece of data.
		
		Will successfully encode parameters when passed as a dict or a list of
		2-tuples. Order is retained if data is a list of 2-tuples but arbitrary
		if parameters are supplied as a dict.
	**/
	static public function _encode_params(data:Dynamic):Dynamic;
	static public function _get_idna_encoded_host(host:Dynamic):Dynamic;
	public function copy():Dynamic;
	/**
		Deregister a previously registered hook.
		Returns True if the hook existed, False if not.
	**/
	public function deregister_hook(event:Dynamic, hook:Dynamic):Dynamic;
	/**
		Build the path URL to use.
	**/
	public var path_url : Dynamic;
	/**
		Prepares the entire request with the given parameters.
	**/
	public function prepare(?method:Dynamic, ?url:Dynamic, ?headers:Dynamic, ?files:Dynamic, ?data:Dynamic, ?params:Dynamic, ?auth:Dynamic, ?cookies:Dynamic, ?hooks:Dynamic, ?json:Dynamic):Dynamic;
	/**
		Prepares the given HTTP auth data.
	**/
	public function prepare_auth(auth:Dynamic, ?url:Dynamic):Dynamic;
	/**
		Prepares the given HTTP body data.
	**/
	public function prepare_body(data:Dynamic, files:Dynamic, ?json:Dynamic):Dynamic;
	/**
		Prepare Content-Length header based on request method and body
	**/
	public function prepare_content_length(body:Dynamic):Dynamic;
	/**
		Prepares the given HTTP cookie data.
		
		This function eventually generates a ``Cookie`` header from the
		given cookies using cookielib. Due to cookielib's design, the header
		will not be regenerated if it already exists, meaning this function
		can only be called once for the life of the
		:class:`PreparedRequest <PreparedRequest>` object. Any subsequent calls
		to ``prepare_cookies`` will have no actual effect, unless the "Cookie"
		header is removed beforehand.
	**/
	public function prepare_cookies(cookies:Dynamic):Dynamic;
	/**
		Prepares the given HTTP headers.
	**/
	public function prepare_headers(headers:Dynamic):Dynamic;
	/**
		Prepares the given hooks.
	**/
	public function prepare_hooks(hooks:Dynamic):Dynamic;
	/**
		Prepares the given HTTP method.
	**/
	public function prepare_method(method:Dynamic):Dynamic;
	/**
		Prepares the given HTTP URL.
	**/
	public function prepare_url(url:Dynamic, params:Dynamic):Dynamic;
	/**
		Properly register a hook.
	**/
	public function register_hook(event:Dynamic, hook:Dynamic):Dynamic;
}