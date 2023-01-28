package hxdiscord.types.message;

enum abstract ComponentObject(Int) from Int to Int {
    final ActionRow:Int = 1;
    final Button:Int = 2;
    final StringSelect:Int = 3;
    final TextInput:Int = 4;
    final UserSelect:Int = 5;
    final RoleSelect:Int = 6;
    final MentionableSelect:Int = 7;
    final ChannelSelect:Int = 8;
}