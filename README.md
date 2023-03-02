![hxdiscord](https://user-images.githubusercontent.com/99131021/222229452-cffd2b4f-0a7f-47a4-946f-5c568f64de1d.png)
## hxdiscord

hxdiscord is a Discord API Wrapper for Haxe.
## Installation

`haxelib git hxdiscord https://github.com/FurretDev/hxdiscord.git`

`haxelib install hxdiscord`

## About

hxdiscord is a Discord Library for Haxe. It's still in development. More thing will be added, but for now, you can make your own Discord Bot with this!

## Targets

I don't know how many targets does hxdiscord support, since I've not tried them all. But here's a list of them

- ✅ C++ (Does not support attachments)
- ✅ Neko (Supports attachments - Recommended)
- ✅ HashLink (Does not support attachments)

## Need help with something?

Feel free to join our Discord server. Here you can talk with the developer, make questions or even ask for help!
https://discord.gg/gKQh5cC59w

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
