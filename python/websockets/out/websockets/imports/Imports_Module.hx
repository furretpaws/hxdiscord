/* This file is generated, do not edit! */
package websockets.imports;
@:pythonImport("websockets.imports") extern class Imports_Module {
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
	/**
		A generic version of collections.abc.Iterable.
	**/
	static public function Iterable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		Optional type.
		
		Optional[X] is equivalent to Union[X, None].
	**/
	static public function Optional(?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>):Dynamic;
	static public var __all__ : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var annotations : Dynamic;
	/**
		Import ``name`` from ``source`` in ``namespace``.
		
		There are two use cases:
		
		- ``name`` is an object defined in ``source``;
		- ``name`` is a submodule of ``source``.
		
		Neither :func:`__import__` nor :func:`~importlib.import_module` does
		exactly this. :func:`__import__` is closer to the intended behavior.
	**/
	static public function import_name(name:Dynamic, source:Dynamic, namespace:Dynamic):Dynamic;
	/**
		Provide lazy, module-level imports.
		
		Typical use::
		
		    __getattr__, __dir__ = lazy_import(
		        globals(),
		        aliases={
		            "<name>": "<source module>",
		            ...
		        },
		        deprecated_aliases={
		            ...,
		        }
		    )
		
		This function defines ``__getattr__`` and ``__dir__`` per :pep:`562`.
	**/
	static public function lazy_import(namespace:Dynamic, ?aliases:Dynamic, ?deprecated_aliases:Dynamic):Dynamic;
}