#!/bin/bash

# The follwoing will attempt to install all needed packages to run Hyprland
# This is a quick and dirty script there are no error checking
# This script is meant to run on a clean fresh system
# Modified https://github.com/ChrisTitusTech/hyprland-titus and https://github.com/soldoestech/hyprland by https://github.com/ImCarsen

#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "yay was located, moving on.\n"
    yay -Suy
else 
    echo -e "yay was not located, please install yay. Exiting script.\n"
    exit 
fi

read -n1 -rep 'Are you running in a VM? (y,n)' VM

### Disable wifi powersave mode ###
read -n1 -rep 'Would you like to disable wifi powersave? (y,n)' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi

### Install all packages ####
#Removed cliphist
read -n1 -rep 'Would you like to install the packages? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    # Install packages depending on if the user is in a VM or not
    if (( $VM == "Y" || $VM == "y" )); then
        yay -S --noconfirm hyprland foot waybar-hyprland   \
        swww-git swaylock-effects wofi wlogout mako thunar  \
        thunar-archive-plugin nwg-look-bin                  \
        ttf-jetbrains-mono-nerd noto-fonts-emoji            \
        wlr-randr sddm-git starship fish-git                \
        polkit-kde-agent python-requests                    \
        swappy grim slurp pamixer brightnessctl gvfs        \
        xdg-desktop-portal-hyprland-git qt6-wayland
    else
        yay -S --noconfirm hyprland kitty waybar-hyprland   \
        swww-git swaylock-effects wofi wlogout mako thunar  \
        thunar-archive-plugin nwg-look-bin                  \
        ttf-jetbrains-mono-nerd noto-fonts-emoji            \
        wlr-randr sddm-git starship fish-git                \
        polkit-kde-agent python-requests                    \
        swappy grim slurp pamixer brightnessctl gvfs        \
        xdg-desktop-portal-hyprland-git qt6-wayland
    fi


    # Start the bluetooth service
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    
    # Clean out other portals
    echo -e "Cleaning out conflicting xdg portals...\n"
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk
fi

### Copy Config Files ###
read -n1 -rep 'Would you like to copy config files? (y,n)' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    # Global configs
    mkdir -p ~/.wallpapers && cp ./global/background.jpg $_
    cp -R ./global/waybar ~/.config/
    cp -R ./global/hypr ~/.config/hypr/
    cp -R ./global/swaylock ~/.config/
    # VM or non-VM specific configs
    if (( $VM == "Y" || $VM == "y" )); then
        echo -e "Copying VM config files...\n"
        cp -R ./vmdotconfig/hypr ~/.config/
        
    else
        echo -e "Copying config files...\n"
        cp -R ./dotconfig/hypr ~/.config/
        #cp -R ./dotconfig/kitty ~/.config/
        #cp -R ./dotconfig/pipewire ~/.config/
        #cp -R ./dotconfig/swaylock ~/.config/
        #p -R ./dotconfig/wlogout ~/.config/
    fi
        
    # Set some files as exacutable 
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py
fi

### Enable SDDM Autologin ###
read -n1 -rep 'Would you like to enable SDDM autologin? (y,n)' ALOG
if [[ $ALOG == "Y" || $ALOG == "y" ]]; then
    LOC="/etc/sddm.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[Autologin]\nUser = $(whoami)\nSession=hyprland" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Enable SDDM service...\n"
    sudo systemctl enable sddm
    sleep 3
fi

# Start now prompt
read -n1 -rep 'Would you like to start Hyprland now? (y,n)' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec Hyprland
else
    exit
fi
### Script is done ###
echo -e "Script has completed.\n"
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"