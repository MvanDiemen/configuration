# Configuration

This is the configuration I am using on my current laptop.
It is based on [My previous dotfiles](https://github.com/MvanDiemen/dotfiles) which became too cluttered after some years.

This is an attempt to go back to the basics and only include what I actually use/need, which is:

  * i3                  - Currently using the `i3-gaps` version
  * Polybar
  * Terminator
  * Dunst
  * Visual Studio Code

### Fonts

The fonts I am using are:

  * Noto (Sans)
  * Fira Code
  * Noto Emoji
  * Font Awesome 4/5

## eCryptfs

As I don't like encryption solutions for the entire disk where you need to fill in a password to mount/unlock the disk
on each boot, eCryptfs provides a solution more like FileVault where the user password decrypts the home dir.

For this I used `encryptfs-utils` and followed the [The
wiki](https://wiki.archlinux.org/title/ECryptfs#Encrypting_a_home_directory).

## i3

In the past I have used i3 a lot and used it with fixed workspaces for specific apps. Currently I am going to a sort of
trial period where I want to use it more 'flex' and see if I want to have dedicated workspaces again or not.

I have used both the i3status bar and polybar and have been keeping with polybar as I like the setup and the look of it.
Also I am using `betterlockscreen` instead of `i3lock` as I like the default positioning and look of the password/clock
a bit more.

## Polybar

The polybar setup is pretty simplistic and close to the default example. I have changed it to a fixed center and added a
script which can launch polybar on the correct monitor based on the different ports my current Lenovo X1 has and as I
only use one screen at a time, not keep multiple polybars around.

## Terminator

WIP

## Dunst

WIP

## VS Code

WIP
