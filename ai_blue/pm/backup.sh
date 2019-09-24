#!/bin/bash
echo "Starting backup..."
read -p "Would you like to backup settings and some configs? [Y/n] " SETTINGS
read -p "Would you like to backup your home directory (Size: $(sudo du -h /home/ | grep /home/$USER$))? [Y/n] " HOME_DIR
read -p "Would you like to backup a list of all applications you have installed for easier installation later? [Y/n] " PACKAGES
mkdir /home/${USER}_backups/
mkdir /home/${USER}_backups/$(date +"%d-%m")
# BUP = BackUp Path
BUP = /home/${USER}_backups/$(date +"%d-%m")
if [ "$SETTINGS" == "Y" ] || [ "$SETTINGS" == "y" ] || [ "$SETTINGS" == "" ] ; then
    echo "Backing up DCONF..."
    sudo dconf dump / >> $BUP/dconf_backup
    
    echo "Backing up configs..."
    sudo mkdir $BUP/configs
    sudo cp /home/$USER/.zshrc $BUP/configs/zshrc

    ## ADD OTHERS
fi
if [ "$HOME_DIR" == "Y" ] || [ "$HOME_DIR" == "y" ] || [ "$HOME_DIR" == "" ] ; then
    echo "Backing up /home/$USER, this might take a while..."
    sudo mkdir $BUP/home 
    sudo cp -rav /home/$USER/* $BUP/home/
fi
if [ "$PACKAGES" == "Y" ] || [ "$PACKAGES" == "y" ] || [ "$PACKAGES" == "" ] ; then
    echo "Creating a list of packages..."
    sudo pacman -Qq >> $BUP/packages
fi
echo "Compressing..."
sudo tar -cvzf /home/${USER}_backups/backup-$(date +"%d-%m").tar.gz $BUP/