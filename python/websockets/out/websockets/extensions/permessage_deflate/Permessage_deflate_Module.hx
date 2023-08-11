/* This file is generated, do not edit! */
package websockets.extensions.permessage_deflate;
@:pythonImport("websockets.extensions.permessage_deflate") extern class Permessage_deflate_Module {
	/**
		Special type indicating an unconstrained type.
		
		- Any is compatible with every type.
		- Any assumed to have all methods.
		- All values assumed to be instances of Any.
		
		Note that all the above statements are true from the point of view of
		static type checkers. At runtime, Any should not be used with instance
		or class checks.
	**/
	static public function Any(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of dict.
	**/
	static public function Dict(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	static public function ExtensionName(x:Dynamic):Dynamic;
	static public function ExtensionParameter(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of list.
	**/
	static public function List(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	/**
		A generic version of collections.abc.Sequence.
	**/
	static public function Sequence(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Tuple type; Tuple[X, Y] is the cross-product type of X and Y.
		
		Example: Tuple[T1, T2] is a tuple of two elements corresponding
		to type variables T1 and T2.  Tuple[int, float, str] is a tuple
		of an int, a float and a string.
		
		To specify a variable-length tuple of homogeneous type, use Tuple[T, ...].
	**/
	static public function Tuple(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Union type; Union[X, Y] means either X or Y.
		
		To define a union, use e.g. Union[int, str].  Details:
		- The arguments must be types and there must be at least one.
		- None as an argument is a special case and is replaced by
		  type(None).
		- Unions of unions are flattened, e.g.::
		
		    Union[Union[int, str], float] == Union[int, str, float]
		
		- Unions of a single argument vanish, e.g.::
		
		    Union[int] == int  # The constructor actually returns int
		
		- Redundant arguments are skipped, e.g.::
		
		    Union[int, str, int] == Union[int, str]
		
		- When comparing unions, the argument order is ignored, e.g.::
		
		    Union[int, str] == Union[str, int]
		
		- You cannot subclass or instantiate a union.
		- You can use Optional[X] as a shorthand for Union[X, None].
	**/
	static public function Union(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	static public var _EMPTY_UNCOMPRESSED_BLOCK : Dynamic;
	static public var _MAX_WINDOW_BITS_VALUES : Dynamic;
	static public var __all__ : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Build a list of ``(name, value)`` pairs for some compression parameters.
	**/
	static public function _build_parameters(server_no_context_takeover:Dynamic, client_no_context_takeover:Dynamic, server_max_window_bits:Dynamic, client_max_window_bits:Dynamic):Dynamic;
	/**
		Extract compression parameters from a list of ``(name, value)`` pairs.
		
		If ``is_server`` is :obj:`True`, ``client_max_window_bits`` may be
		provided without a value. This is only allowed in handshake requests.
	**/
	static public function _extract_parameters(params:Dynamic, is_server:Dynamic):Dynamic;
	static public var annotations : Dynamic;
	/**
		Enable Per-Message Deflate with default settings in client extensions.
		
		If the extension is already present, perhaps with non-default settings,
		the configuration isn't changed.
	**/
	static public function enable_client_permessage_deflate(extensions:Dynamic):Dynamic;
	/**
		Enable Per-Message Deflate with default settings in server extensions.
		
		If the extension is already present, perhaps with non-default settings,
		the configuration isn't changed.
	**/
	static public function enable_server_permessage_deflate(extensions:Dynamic):Dynamic;
}