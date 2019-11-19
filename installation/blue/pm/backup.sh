#!/bin/bash
echo "Starting backup..."
read -p "Would you like to backup settings and some configs? [Y/n] " SETTINGS
read -p "Would you like to backup your home directory (Size: $(sudo du -h /home/$USER | grep /home/$USER$))? [Y/n] " HOME_DIR
read -p "Would you like to backup a list of all applications you have installed for easier installation later? [Y/n] " PACKAGES
mkdir ~/_backup
# BUP = BackUp Path
if [ "$SETTINGS" == "Y" ] || [ "$SETTINGS" == "y" ] || [ "$SETTINGS" == "" ] ; then
    echo "Backing up DCONF..."
    dconf dump / >> ~/_backup/dconf_backup
    
    echo "Backing up configs..."
    mkdir ~/_backup/configs
    cp ~/.zshrc ~/_backup/configs/zshrc

    ## ADD OTHERS
fi
if [ "$HOME_DIR" == "Y" ] || [ "$HOME_DIR" == "y" ] || [ "$HOME_DIR" == "" ] ; then
    echo "Backing up /home/$USER, this might take a while..."
    mkdir ~/_backup/home 
    cp -ra ~/* ~/_backup/home/
fi
if [ "$PACKAGES" == "Y" ] || [ "$PACKAGES" == "y" ] || [ "$PACKAGES" == "" ] ; then
    echo "Creating a list of packages..."
    pacman -Qq >> ~/_backup/packages
fi
echo "Compressing..."
sudo tar -cvzf ~/_backup.tar.gz ~/_backup/
echo "Done! Location: ~/_backup.tar.gz"