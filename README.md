<h1 align="center">ImCarsen Hyprland Config</h1>
<p align="center">
  <a href="https://choosealicense.com/licenses/mit/">
    <img alt="License: MIT" src="https://img.shields.io/github/license/ImCarsen/hyprland-carsen?style=for-the-badge" target="_blank" />
  </a>
  <a href="https://github.com/ImCarsen/hyprland-carsen/commits/master">
    <img alt="Last Commit" src="https://img.shields.io/github/last-commit/ImCarsen/hyprland-carsen?style=for-the-badge" target="_blank" />
  </a>
  <a href="https://github.com/ImCarsen/hyprland-carsen/issues">
    <img alt="Open Issues" src="https://img.shields.io/github/issues/ImCarsen/hyprland-carsen?style=for-the-badge" target="_blank" />
  </a>
</p>

> A personalized version of SolDoesTech and ChrisTitusTech's hyprland configs<br /> 


## Screenshots

![Placeholder]()


## Usage
Made to be run on a fresh install.
Master branch (updated less frequently, should be somewhat stable)
```bash
git clone https://github.com/ImCarsen/hyprland-carsen.git
cd hyprland-carsen/
sh hypr-install.sh
```
Dev branch (updated more frequently, possibly broken)
```bash
git clone -b Dev https://github.com/ImCarsen/hyprland-carsen.git
cd hyprland-carsen/
sh hypr-install.sh
```

## Contributing and Discussions

Contributions are always welcome! If you want to contribute, feel free to check the [issues page](https://github.com/ImCarsen/hyprland-carsen/issues) and the [discussions page](https://github.com/ImCarsen/hyprland-carsen/issues).<br />


## Acknowledgements and References
I'm still super early on in this project and haven't been daily driving Linux for 2+ years. Bear with me.

✅ = Working
❎ = Working in VM
❌ = Not working

Tested on:
❎ EndeavourOS Cassini Nova 03-2023 R1 minimal installation 
❎ Arch Linux

All are tested in a VM, so things might not work yet on actual hardware.

Based on:
  - [SolDoesTech HyprV2](https://github.com/SolDoesTech/HyprV2)
  - [ChrisTitusTech Hyprland](https://github.com/ChrisTitusTech/hyprland-titus)

Useful resources:
  - [Hyprland Wiki](https://wiki.hyprland.org/)

## Packages

Main components:
| Package Name | Description |
|-|-|
| [hyprland](https://github.com/hyprwm/hyprland-wiki) | Hyprland is a highly customizable dynamic tiling Wayland compositor that doesn't sacrifice on its looks.
| [waybar-hyprland](https://github.com/Alexays/Waybar) | Highly customizable Wayland bar for Sway and Wlroots based compositors. ✌️ 🎉
| [swww-git](https://github.com/Horus645/swww) | A Solution to your Wayland Wallpaper Woes
| [swaylock-effects](https://github.com/jirutka/swaylock-effects) | Swaylock, with fancy effects
| [wofi](https://hg.sr.ht/~scoopta/wofi) | Wofi is a launcher/menu program for wlroots based wayland compositors such as sway
| [wlogout](https://github.com/ArtsyMacaw/wlogout) | A wayland based logout menu
| [mako](https://github.com/emersion/mako) | A lightweight Wayland notification daemon
| [xdg-desktop-portal-hyprland-git](https://github.com/hyprwm/xdg-desktop-portal-hyprland) | xdg-desktop-portal backend for hyprland
| [swappy](https://github.com/jtheoof/swappy) | A Wayland native snapshot editing tool, inspired by Snappy on macOS
| [grim](https://sr.ht/~emersion/grim/) | Grab images from a Wayland compositor.
| [slurp](https://github.com/emersion/slurp) | Select a region in a Wayland compositor
| [thunar](https://gitlab.xfce.org/xfce/thunar) | Modern, fast and easy-to-use file manager for Xfce

Additional tools and utilities:
| Package Name | Description |
|-|-|
| [polkit-gnome](https://gitlab.freedesktop.org/polkit/polkit/) | polkit is a toolkit for defining and handling authorizations. It is used for allowing unprivileged processes to speak to privileged processes.
| [python-requests](https://github.com/psf/requests) | HTML Parsing for Humans - Used for waybar-wttr.py
| [wlsunset](https://sr.ht/~kennylevinsen/wlsunset/) | Day/night gamma adjustments for Wayland compositors supporting wlr-gamma-control-unstable-v1 & xdg-output-unstable-v1.
| [bluez](http://www.bluez.org/) | Bluetooth protocol stack for Linux
| [bluez-utils](http://www.bluez.org/) | Command line utilities to interact with bluetooth devices
| [blueman](https://github.com/blueman-project/blueman) | Blueman is a GTK+ Bluetooth Manager
| [network-manager-applet](https://gitlab.gnome.org/GNOME/network-manager-applet) | Tray applet and an advanced network connection editor
| [gvfs](https://gitlab.gnome.org/GNOME/gvfs/) | Virtual filesystem implementation for GIO - adds missing functionality to thunar such as automount usb drives
| [thunar-archive-plugin](https://gitlab.xfce.org/thunar-plugins/thunar-archive-plugin) | Adds archive operations to the Thunar file context menus
| [file-roller](https://gitlab.gnome.org/GNOME/file-roller) | File Roller is an archive manager for the GNOME desktop environment. - Backend set of tools for working with compressed files
| [btop](https://github.com/aristocratos/btop) | Resource monitor that shows usage and stats for processor, memory, disks, network and processes.
| [pacman-contrib](https://gitlab.archlinux.org/pacman/pacman-contrib) | Contributed scripts and tools for pacman systems - Required for showing system updates in the waybar
| [nwg-displays](https://github.com/nwg-piotr/nwg-displays) | Graphical display manager for wayland compositors, works with Sway and Hyprland
| [wlr-randr](https://sr.ht/~emersion/wlr-randr/) | Utility to manage outputs of a Wayland compositor. - Required by nwg-displays

Theme and visual tools and utilities:
| Package Name | Description |
|-|-|
| [starship](https://github.com/starship/starship) | ☄🌌️ The minimal, blazing-fast, and infinitely customizable prompt for any shell!
| [ttf-jetbrains-mono-nerd](https://github.com/ryanoasis/nerd-fonts) | Patched font JetBrains Mono from nerd fonts library
| [noto-fonts-emoji](https://github.com/googlefonts/noto-emoji) | Noto Emoji fonts
| [nwg-look-bin](https://github.com/nwg-piotr/nwg-look) | GTK3 settings editor adapted to work in the sway / wlroots environment (binary package)
| [xfce4-settings](https://gitlab.xfce.org/xfce/xfce4-settings) | The xfce4-settings component provides a daemon, manager, and editor to centralize the configuration management of the Xfce system. - Set of tools for xfce, needed to set GTK theme
| [sddm-git](https://github.com/sddm/sddm) | QML based X11 and Wayland display manager - Required or you will run into shutdown bugs and delays
| [qt5-graphicaleffects](https://archlinux.org/packages/extra/x86_64/qt5-graphicaleffects/) | Graphical effects for use with Qt Quick 2 - Required for the SDDM theme
| [qt5-quickcontrols2](https://archlinux.org/packages/extra/x86_64/qt5-quickcontrols2/) | Next generation user interface controls based on Qt Quick - Required for the SDDM theme
| [qt5-svg](https://archlinux.org/packages/extra/x86_64/qt5-svg/) | Classes for displaying the contents of SVG files - Required for the SDDM theme

If you have suggestions for alternative packages, please start a discussion on the [discussions page](https://github.com/ImCarsen/hyprland-carsen/discussions/categories/suggestions)

## Author

👤 **I'm Carsen**

- Site: [www.imcarsen.com](https://www.imcarsen.com/)
- Twitter: [@ImCarsen_](https://twitter.com/ImCarsen_)
- Twitch: [ImCarsen](https://www.twitch.tv/imcarsen)
- Github: [@ImCarsen](https://github.com/ImCarsen)

