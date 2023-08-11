/* This file is generated, do not edit! */
package requests.hooks;
@:pythonImport("requests.hooks") extern class Hooks_Module {
	static public var HOOKS : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function default_hooks():Dynamic;
	/**
		Dispatches a hook dictionary on a given piece of data.
	**/
	static public function dispatch_hook(key:Dynamic, hooks:Dynamic, hook_data:Dynamic, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
}