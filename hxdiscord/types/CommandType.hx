package hxdiscord.types;

enum abstract CommandType(Int) from Int to Int {
    final SUB_COMMAND:Int = 1;
    final SUB_COMMAND_GROUP:Int = 2;
    final STRING:Int = 3;
    final INTEGER:Int = 4;
    final BOOLEAN:Int = 5;
    final USER:Int = 6;
    final CHANNEL:Int = 7;
    final ROLE:Int = 8;
    final MENTIONABLE:Int = 9;
    final NUMBER:Int = 10;
    final ATTACHMENT:Int = 11;
}
