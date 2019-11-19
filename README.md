# BlueOS Package Manager
The BlueOS package manager is called blue, it is written mostly weitten in Python.

## Commands
The main command is `blue` but it will require an option.

### Udating the system
There are three ways to update the system:
```
blue upgrade
```
This will automatically check for updates and update if an update is found.

If you for some reason have a link to an update you want to download use:
```
blue upgrade [URL - Ex: https://blueos.burnyllama.tk/repo/os_update/3.0/update.tar.xz]
```
As of now it has to be a URL that begins with "https://blueos.burnyllama.tk/repo/" so you can not install unofficial updates... We will probably add an option for the ability to install unofficial updates, but with a warning...

The last way is through a local file:
```
blue local [/path/to/update.tar.xz]
```
As of now this file must be a .tar.xz-archive, and you must have the full path! Not relative paths!

You can also run `blue check` to check for updates, this won't automatically update, but you will get the option to do so.

### Backup and Restore
You can backup and restore with their respective commands, this is still  quite unreliable if I remember correctly...
```
blue backup
blue restore 
```
As of now `blue restore` won't do anything. You can only backup.

There is also an experimental feature clean/remove unneccesary files.
```
blue clean
```
It is CLI based. I plan to add a GUI for it some day...

### Help
Just type `blue help` and you'll get help, you'll also get help if a command is not recognized.

## Features and Future
[*] Install system updates.
[ ] Backup, restore, and clean-up.
[ ] Install applications/programs.

This may also the core for all commands to configure BlueOS, so it may end up as more than just a package manager...