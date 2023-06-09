#!/bin/bash

# The follwoing will attempt to install all needed packages to run Hyprland
# This is a quick and dirty script there are no error checking
# This script is meant to run on a clean fresh system

# Set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

#clear the screen
clear

echo -e "$CNT - You are about to execute a script that will attempt to setup Hyprland.
Please note that Hyprland is still in Beta.
Please report any issues on the gitub, thanks!
\n"

sleep 2

#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "$COK - yay was located, moving on."
else 
    echo -e "$CWR - Yay was NOT located"
    read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install yay (y,n) ' INSTYAY
    if [[ $INSTYAY == "Y" || $INSTYAY == "y" ]]; then
        git clone https://aur.archlinux.org/yay-git.git &>> $INSTLOG
        cd yay-git
        makepkg -si --noconfirm &>> ../$INSTLOG
        cd ..
        
    else
        echo -e "$CER - Yay is required for this script, now exiting"
        exit
    fi
fi

### Check if user is using a VM ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Are you running in a VM? (y,n) ' VM

if [[ $VM == "Y" || $VM == "y" ]]; then
    echo -e "!! USER IS USING A VM !!" &>> $INSTLOG #Log that the user is in a VM
    echo -e "$CWR - Please keep in mind that VMs are known to cause issues in Hyprland."
fi

### Disable wifi powersave mode ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to disable WiFi powersave? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "$CNT - The following file has been created $LOC."
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC &>> $INSTLOG
    echo -e "\n"
    echo -e "$CNT - Restarting NetworkManager service..."
    sleep 1
    sudo systemctl restart NetworkManager &>> $INSTLOG
    sleep 2
fi

### Install all packages ####
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    # update the DB first
    echo -e "$COK - Updating yay database..."
    yay -Suy --noconfirm &>> $INSTLOG

    #Install terminal (Trouble with kitty on VMs)
    if (( $VM == "Y" || $VM == "y" )); then
        if yay -Qi foot > /dev/null ; then
            echo -e "$COK - foot is already installed."
        else
            echo -e "$CNT - Now installing foot ..."
            yay -S --noconfirm foot &>> $INSTLOG
            if yay -Qi foot > /dev/null ; then
                echo -e "$COK - foot was installed."
            else
                echo -e "$CER - foot install had failed, please check the install.log"
                exit
            fi
        fi
    else
        if yay -Qi kitty > /dev/null ; then
            echo -e "$COK - kitty is already installed."
        else
            echo -e "$CNT - Now installing kitty ..."
            yay -S --noconfirm kitty &>> $INSTLOG
            if yay -Qi kitty > /dev/null ; then
                echo -e "$COK - kitty was installed."
            else
                echo -e "$CER - kitty install had failed, please check the install.log"
                exit
            fi
        fi
    fi
    #Stage 1
    echo -e "\n$CNT - Stage 1 - Installing main components, this may take a while..."
    for SOFTWR in hyprland waybar-hyprland swww-git swaylock-effects wofi wlogout mako xdg-desktop-portal-hyprland-git swappy grim slurp thunar
    do
        #First lets see if the package is there
        if yay -Qs $SOFTWR > /dev/null ; then
            echo -e "$COK - $SOFTWR is already installed."
        else
            echo -e "$CNT - Now installing $SOFTWR ..."
            yay -S --noconfirm $SOFTWR &>> $INSTLOG
            if yay -Qs $SOFTWR > /dev/null ; then
                echo -e "$COK - $SOFTWR was installed."
            else
                echo -e "$CER - $SOFTWR install had failed, please check the install.log"
                exit
            fi
        fi
    done

    #Stage 2
    echo -e "\n$CNT - Stage 2 - Installing additional tools and utilities, this may take a while..."
    for SOFTWR in polkit-gnome python-requests wlsunset bluez bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin file-roller btop pacman-contrib nwg-displays wlr-randr
    do
        #First lets see if the package is there
        if yay -Qs $SOFTWR > /dev/null ; then
            echo -e "$COK - $SOFTWR is already installed."
        else
            echo -e "$CNT - Now installing $SOFTWR ..."
            yay -S --noconfirm $SOFTWR &>> $INSTLOG
            if yay -Qs $SOFTWR > /dev/null ; then
                echo -e "$COK - $SOFTWR was installed."
            else
                echo -e "$CER - $SOFTWR install had failed, please check the install.log"
                exit
            fi
        fi
    done

    #Stage 3
    echo -e "\n$CNT - Stage 3 - Installing theme and visual related tools and utilities, this may take a while..."
    for SOFTWR in starship ttf-jetbrains-mono-nerd noto-fonts-emoji nwg-look-bin xfce4-settings sddm-git qt5-graphicaleffects qt5-quickcontrols2 qt5-svg 
    do
        #First lets see if the package is there
        if yay -Qs $SOFTWR > /dev/null ; then
            echo -e "$COK - $SOFTWR is already installed."
        else
            echo -e "$CNT - Now installing $SOFTWR ..."
            yay -S --noconfirm $SOFTWR &>> $INSTLOG
            if yay -Qs $SOFTWR > /dev/null ; then
                echo -e "$COK - $SOFTWR was installed."
            else
                echo -e "$CER - $SOFTWR install had failed, please check the install.log"
                exit
            fi
        fi
    done

    # Start the bluetooth service
    echo -e "$CNT - Starting the Bluetooth Service..."
    sudo systemctl enable --now bluetooth.service &>> $INSTLOG
    sleep 1

    # Enable the sddm login manager service
    echo -e "$CNT - Enabling the SDDM Service..."
    sudo systemctl enable sddm &>> $INSTLOG
    sleep 1
    
    # Clean out other portals
    echo -e "$CNT - Cleaning out conflicting xdg portals..."
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk &>> $INSTLOG
fi

### Copy Config Files ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "$CNT - Copying global config files..."
    # Global configs
    WPDIR=~/.wallpapers/
    if [ -d "$WPDIR" ]; then
        cp global/background.jpg $WPDIR
    else
        mkdir -p ~/.wallpapers
        cp global/background.jpg $WPDIR
    fi

    for DIR in hypr swaylock waybar wlogout wofi mako
    do 
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then 
            echo -e "$CAT - Config for $DIR located, backing up."
            mv $DIRPATH $DIRPATH-back &>> $INSTLOG
            echo -e "$COK - Backed up $DIR to $DIRPATH-back."
        fi
        echo -e "$CNT - Copying $DIR config to $DIRPATH."  
        cp -R global/$DIR ~/.config/ &>> $INSTLOG
    done

    # VM or non-VM specific configs
    echo -e "$VM"
    if (( $VM == "Y" || $VM == "y" )); then
        echo -e "$CNT - Copying VM config files...\n"
        cp -R vmdotconfig/hypr ~/.config/
    else
        echo -e "$CNT - Copying config files...\n"
        cp -R dotconfig/hypr ~/.config/
    fi

    # Copy the SDDM theme
    echo -e "$CNT - Setting up the login screen."
    sudo cp -R global/sdt /usr/share/sddm/themes/
    sudo chown -R $USER:$USER /usr/share/sddm/themes/sdt
    sudo mkdir /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sdt" | sudo tee -a /etc/sddm.conf.d/10-theme.conf
    WLDIR=/usr/share/wayland-sessions
    if [ -d "$WLDIR" ]; then
        echo -e "$COK - $WLDIR found"
    else
        echo -e "$CWR - $WLDIR NOT found, creating..."
        sudo mkdir $WLDIR
    fi 
    sudo cp extras/hyprland.desktop /usr/share/wayland-sessions/
    sudo sudo sed -i 's/Exec=Hyprland/Exec=\/home\/'$USER'\/start-hypr/' /usr/share/wayland-sessions/hyprland.desktop
    cp extras/start-hypr ~/

    #SDDM background
    #ln -sf ~/.wallpapers/background.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
    #cp ~/.wallpapers/background.jpg /usr/share/sddm/themes/sdt/

    # Setup initial theme
    ln -sf /usr/share/sddm/themes/sdt/Backgrounds/wallpaper-dark.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
    ln -sf ~/.config/wofi/style/style-dark.css ~/.config/wofi/style.css

    # Set some files as exacutable 
    echo -e "$CNT - Setting some files as executable."
    chmod +x ~/.config/hypr/scripts/bgaction
    chmod +x ~/.config/hypr/scripts/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py
    chmod +x ~/start-hypr
fi

### Script is done ###
echo -e "$CNT - Script has completed!"
### Start hyprland now prompt ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec sudo systemctl start sddm &>> $INSTLOG
else
    exit
fi

echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"