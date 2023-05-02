package haxe.ws;

#if java

typedef SocketImpl = haxe.ws.java.NioSocket;

#elseif cs

typedef SocketImpl = haxe.ws.cs.NonBlockingSocket;

#elseif nodejs

typedef SocketImpl = haxe.ws.nodejs.NodeSocket;

#else

typedef SocketImpl = sys.net.Socket;

#end