# BashBar

An open-source terminal command/script launcher

---

## Getting started

This simple menubar application will let you run terminal commands or script using the menubar.
If the command script requires sudo it will be autodetected and you will be asked to enter administrator password.

On the first run the menubar may look a little bit empty.

![menu]

When you hit **Preferences** you'll be presented 10 tabs which you can use to enter up to 10 commands under each tab or just one command for each tab which creates single menu entry.

![preferences]

From version 1.8.0 it is possible to use variables in commands i.e:

Adding: `%% var <Variable description> %%` to the function:

![variable1]

```bash
ls -la %% var <Variable description> %%
```

will trigger input dialog:

![variable2]

There are two type of variables:

1. Path `%% path <Variable description> %%` - triggers File/Directory browser
2. Other `%% variable <Manual entry> %%` - triggers input modal

---

## Installing

Download latest version from [here](https://tbrek.github.io/BashBar/)

Simply copy it to your /Application folder and run.

---

## Change log

1.8.2 Added option to open results window automatically
1.8.1 Added variable types
1.8.0 Added variables
1.7.4 Import dialog  box update<br>
1.7.3 Inport/Export settings added<br>
1.7.1(2) Fixed Code-signing<br>
1.7 Added Sparkle SWUpdate<br>
1.3 Output window is now resizable and scrollable<br>
1.2 Added output window shown when user clicks results cell in menu<br>
1.1 Removed sandboxing as it cause problems with commands run with sudo<br>
1.0 Sandboxing & open-at-login added<br>
0.6 Inital release

[bashbarlogo]: /images/logo_128x128.png
[menu]: /images/menu.png
[preferences]: /images/preferences.png
[variable1]: /images/variable1.png
[variable2]: /images/variable2.png
