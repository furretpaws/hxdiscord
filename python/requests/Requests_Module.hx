/* This file is generated, do not edit! */
package requests;
@:pythonImport("requests") extern class Requests_Module {
	static public var __author__ : Dynamic;
	static public var __author_email__ : Dynamic;
	static public var __build__ : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __cake__ : Dynamic;
	static public var __copyright__ : Dynamic;
	static public var __description__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __license__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __path__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var __title__ : Dynamic;
	static public var __url__ : Dynamic;
	static public var __version__ : Dynamic;
	static public function _check_cryptography(cryptography_version:Dynamic):Dynamic;
	static public var chardet_version : Dynamic;
	static public var charset_normalizer_version : Dynamic;
	static public function check_compatibility(urllib3_version:Dynamic, chardet_version:Dynamic, charset_normalizer_version:Dynamic):Dynamic;
	static public var codes : Dynamic;
	/**
		Sends a DELETE request.
		
		:param url: URL for the new :class:`Request` object.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
	**/
	static public function delete(url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a GET request.
		
		:param url: URL for the new :class:`Request` object.
		:param params: (optional) Dictionary, list of tuples or bytes to send
		    in the query string for the :class:`Request`.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
	**/
	static public function get(url:Dynamic, ?params:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a HEAD request.
		
		:param url: URL for the new :class:`Request` object.
		:param \*\*kwargs: Optional arguments that ``request`` takes. If
		    `allow_redirects` is not provided, it will be set to `False` (as
		    opposed to the default :meth:`request` behavior).
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
	**/
	static public function head(url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends an OPTIONS request.
		
		:param url: URL for the new :class:`Request` object.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
	**/
	static public function options(url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a PATCH request.
		
		:param url: URL for the new :class:`Request` object.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param json: (optional) json data to send in the body of the :class:`Request`.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
	**/
	static public function patch(url:Dynamic, ?data:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a POST request.
		
		:param url: URL for the new :class:`Request` object.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param json: (optional) json data to send in the body of the :class:`Request`.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
	**/
	static public function post(url:Dynamic, ?data:Dynamic, ?json:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Sends a PUT request.
		
		:param url: URL for the new :class:`Request` object.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param json: (optional) json data to send in the body of the :class:`Request`.
		:param \*\*kwargs: Optional arguments that ``request`` takes.
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
	**/
	static public function put(url:Dynamic, ?data:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Constructs and sends a :class:`Request <Request>`.
		
		:param method: method for the new :class:`Request` object: ``GET``, ``OPTIONS``, ``HEAD``, ``POST``, ``PUT``, ``PATCH``, or ``DELETE``.
		:param url: URL for the new :class:`Request` object.
		:param params: (optional) Dictionary, list of tuples or bytes to send
		    in the query string for the :class:`Request`.
		:param data: (optional) Dictionary, list of tuples, bytes, or file-like
		    object to send in the body of the :class:`Request`.
		:param json: (optional) A JSON serializable Python object to send in the body of the :class:`Request`.
		:param headers: (optional) Dictionary of HTTP Headers to send with the :class:`Request`.
		:param cookies: (optional) Dict or CookieJar object to send with the :class:`Request`.
		:param files: (optional) Dictionary of ``'name': file-like-objects`` (or ``{'name': file-tuple}``) for multipart encoding upload.
		    ``file-tuple`` can be a 2-tuple ``('filename', fileobj)``, 3-tuple ``('filename', fileobj, 'content_type')``
		    or a 4-tuple ``('filename', fileobj, 'content_type', custom_headers)``, where ``'content-type'`` is a string
		    defining the content type of the given file and ``custom_headers`` a dict-like object containing additional headers
		    to add for the file.
		:param auth: (optional) Auth tuple to enable Basic/Digest/Custom HTTP Auth.
		:param timeout: (optional) How many seconds to wait for the server to send data
		    before giving up, as a float, or a :ref:`(connect timeout, read
		    timeout) <timeouts>` tuple.
		:type timeout: float or tuple
		:param allow_redirects: (optional) Boolean. Enable/disable GET/OPTIONS/POST/PUT/PATCH/DELETE/HEAD redirection. Defaults to ``True``.
		:type allow_redirects: bool
		:param proxies: (optional) Dictionary mapping protocol to the URL of the proxy.
		:param verify: (optional) Either a boolean, in which case it controls whether we verify
		        the server's TLS certificate, or a string, in which case it must be a path
		        to a CA bundle to use. Defaults to ``True``.
		:param stream: (optional) if ``False``, the response content will be immediately downloaded.
		:param cert: (optional) if String, path to ssl client cert file (.pem). If Tuple, ('cert', 'key') pair.
		:return: :class:`Response <Response>` object
		:rtype: requests.Response
		
		Usage::
		
		  >>> import requests
		  >>> req = requests.request('GET', 'https://httpbin.org/get')
		  >>> req
		  <Response [200]>
	**/
	static public function request(method:Dynamic, url:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Returns a :class:`Session` for context-management.
		
		.. deprecated:: 1.0.0
		
		    This method has been deprecated since version 1.0.0 and is only kept for
		    backwards compatibility. New code should use :class:`~requests.sessions.Session`
		    to create a session. This may be removed at a future date.
		
		:rtype: Session
	**/
	static public function session():Dynamic;
}