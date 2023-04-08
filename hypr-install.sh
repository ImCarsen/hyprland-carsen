#!/bin/bash

# The follwoing will attempt to install all needed packages to run Hyprland
# This is a quick and dirty script there are no error checking
# This script is meant to run on a clean fresh system
# Modified https://github.com/ChrisTitusTech/hyprland-titus and https://github.com/soldoestech/hyprland by https://github.com/ImCarsen

# Set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

echo -e "$CNT - You are about to execute a script that will attempt to setup Hyprland.
Please note that Hyprland is still in Beta.
Please report any issues on the gitub, thanks!
\n"

sleep 3

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
read -n1 -rep 'Are you running in a VM? (y,n)' VM

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
    sleep 3
fi

### Install all packages ####
#Removed cliphist
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    # update the DB first
    echo -e "$COK - Updating yay database..."
    yay -Suy --noconfirm &>> $INSTLOG
    # Install packages depending on if the user is in a VM or not
    if (( $VM == "Y" || $VM == "y" )); then
        #Stage 1
        echo -e "\n$CNT - Stage 1 - Installing main components, this may take a while..."
        for SOFTWR in hyprland foot waybar-hyprland swww swaylock-effects wofi wlogout mako xdg-desktop-portal-hyprland-git swappy grim slurp thunar
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
        for SOFTWR in polkit-kde-agent python-requests brightnessctl bluez bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin file-roller btop pacman-contrib
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
        for SOFTWR in starship ttf-jetbrains-mono-nerd noto-fonts-emoji lxappearance xfce4-settings sddm-git sddm-sugar-candy-git 
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
    else
        #Stage 1
        echo -e "\n$CNT - Stage 1 - Installing main components, this may take a while..."
        for SOFTWR in hyprland kitty waybar-hyprland swww swaylock-effects wofi wlogout mako xdg-desktop-portal-hyprland-git swappy grim slurp thunar
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
        for SOFTWR in polkit-kde-agent python-requests brightnessctl bluez bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin file-roller btop pacman-contrib qt6-wayland qt5-wayland nwg-look-bin wlr-randr
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
        for SOFTWR in starship ttf-jetbrains-mono-nerd noto-fonts-emoji lxappearance xfce4-settings sddm-git sddm-sugar-candy-git 
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
    fi


    # Start the bluetooth service
    echo -e "$CNT - Starting the Bluetooth Service..."
    sudo systemctl enable --now bluetooth.service &>> $INSTLOG
    sleep 2

    # Enable the sddm login manager service
    echo -e "$CNT - Enabling the SDDM Service..."
    sudo systemctl enable sddm &>> $INSTLOG
    sleep 2
    
    # Clean out other portals
    echo -e "$CNT - Cleaning out conflicting xdg portals..."
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk &>> $INSTLOG
fi

### Copy Config Files ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "$CNT - Copying global config files..."
    # Global configs
    if [ -d "~/.wallpapers"]; then
        cp global/background.jpg ~/.wallpapers &>> $INSTLOG
    else
        mkdir -p ~/.wallpapers && cp global/background.jpg $_ &>> $INSTLOG
    fi

    for DIR in hypr swaylock waybar
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

    #cp -R ./global/waybar ~/.config/ &>> $INSTLOG
    #cp -R ./global/hypr ~/.config/hypr/ &>> $INSTLOG
    #cp -R ./global/swaylock ~/.config/ &>> $INSTLOG

    # VM or non-VM specific configs
    if (( $VM == "Y" || $VM == "y" )); then
        echo -e "Copying VM config files...\n"
        cp -R vmdotconfig/hypr ~/.config/
    else
        echo -e "Copying config files...\n"
        cp -R dotconfig/hypr ~/.config/
    fi
        
    # Set some files as exacutable 
    echo -e "$CNT - Setting some file as executable." 
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py

    # Copy the SDDM theme
    echo -e "$CNT - Setting up the login screen."
    sudo cp -R sdt /usr/share/sddm/themes/
    sudo chown -R $USER:$USER /usr/share/sddm/themes/sdt
    sudo mkdir /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sdt" | sudo tee -a /etc/sddm.conf.d/10-theme.conf &>> $INSTLOG
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
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec sudo systemctl start sddm &>> $INSTLOG
else
    exit
fi
### Script is done ###
echo -e "Script has completed.\n"
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"