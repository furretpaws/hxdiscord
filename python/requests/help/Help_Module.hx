/* This file is generated, do not edit! */
package requests.help;
@:pythonImport("requests.help") extern class Help_Module {
	static public var OpenSSL : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Return a dict with the Python implementation and version.
		
		Provide both the name and the version of the Python implementation
		currently running. For example, on CPython 3.10.3 it will return
		{'name': 'CPython', 'version': '3.10.3'}.
		
		This function works best on CPython and PyPy: in particular, it probably
		doesn't work for Jython or IronPython. Future investigation should be done
		to work out the correct shape of the code for those platforms.
	**/
	static public function _implementation():Dynamic;
	static public var chardet : Dynamic;
	static public var cryptography : Dynamic;
	/**
		Generate information for a bug report.
	**/
	static public function info():Dynamic;
	/**
		Pretty-print the bug information as JSON.
	**/
	static public function main():Dynamic;
	static public var pyopenssl : Dynamic;
	static public var requests_version : Dynamic;
}