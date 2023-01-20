# hxdiscord

hxdiscord is a Discord API Wrapper for Haxe.
## Installation

`haxelib git hxdiscord https://github.com/FurretDev/hxdiscord.git`

`haxelib install hxdiscord`

## About

hxdiscord is a Discord Library for Haxe. It's still in development.


Some targets might not work, I haven't tested any. C++ and Neko will work. (Binary attachments doesn't work on C++. Use Neko if you want to send images or whatever you want)



## Example

Here's an example of a Discord Bot, using the hxdiscord library.

```haxe
import hxdiscord.DiscordClient;
import hxdiscord.utils.Intents;
import hxdiscord.types.*;

class Main
{
    static var Bot:DiscordClient;
    static function main()
    {
        Bot = new DiscordClient("your token here", [Intents.ALL], false);
        Bot.onReady = onReady;
        Bot.onMessageCreate = onMessageCreate;
    }

    public static function onReady()
    {
        trace("The bot is ready");
    }

    public static function onMessageCreate(m:Message)
    {
        if (m.content == "hi")
        {
            m.reply({content:"Hello!"}, true); //true or false, the bot will mention the user
        }
    }
}
