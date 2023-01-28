package hxdiscord.types.message;

enum abstract ButtonStyle(Int) from Int to Int {
    final Primary:Int = 1;
    final Secondary:Int = 2;
    final Success:Int = 3;
    final Danger:Int = 4;
    final Link:Int = 5;
}