/* This file is generated, do not edit! */
package websockets.utils;
@:pythonImport("websockets.utils") extern class Utils_Module {
	static public var GUID : Dynamic;
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
		Compute the value of the Sec-WebSocket-Accept header.
		
		Args:
		    key: value of the Sec-WebSocket-Key header.
	**/
	static public function accept_key(key:Dynamic):Dynamic;
	static public var annotations : Dynamic;
	/**
		Apply masking to the data of a WebSocket message.
		
		Args:
		    data: data to mask.
		    mask: 4-bytes mask.
	**/
	static public function apply_mask(data:Dynamic, mask:Dynamic):Dynamic;
	/**
		Generate a random key for the Sec-WebSocket-Key header.
	**/
	static public function generate_key():Dynamic;
}