#!/bin/bash
echo "Starting backup..."
read -p "Would you like to backup settings and some configs? [Y/n] " SETTINGS
read -p "Would you like to backup your home directory (Size: $(sudo du -h /home/ | grep /home/$USER$))? [Y/n] " HOME_DIR
read -p "Would you like to backup a list of all applications you have installed for easier installation later? [Y/n] " PACKAGES
sudo mkdir /home/${USER}_backups/
sudo mkdir /home/${USER}_backups/$(date +"%d-%m")
# BUP = BackUp Path
if [ "$SETTINGS" == "Y" ] || [ "$SETTINGS" == "y" ] || [ "$SETTINGS" == "" ] ; then
    echo "Backing up DCONF..."
    sudo dconf dump / >> /home/${USER}_backups/$(date +"%d-%m")/dconf_backup
    
    echo "Backing up configs..."
    sudo mkdir /home/${USER}_backups/$(date +"%d-%m")/configs
    sudo cp /home/$USER/.zshrc /home/${USER}_backups/$(date +"%d-%m")/configs/zshrc

    ## ADD OTHERS
fi
if [ "$HOME_DIR" == "Y" ] || [ "$HOME_DIR" == "y" ] || [ "$HOME_DIR" == "" ] ; then
    echo "Backing up /home/$USER, this might take a while..."
    sudo mkdir /home/${USER}_backups/$(date +"%d-%m")/home 
    sudo cp -ra /home/$USER/* /home/${USER}_backups/$(date +"%d-%m")/home/
fi
if [ "$PACKAGES" == "Y" ] || [ "$PACKAGES" == "y" ] || [ "$PACKAGES" == "" ] ; then
    echo "Creating a list of packages..."
    sudo pacman -Qq >> /home/${USER}_backups/$(date +"%d-%m")/packages
fi
echo "Compressing..."
#sudo tar -cvzf /home/${USER}_backups/backup-$(date +"%d-%m").tar.gz /home/${USER}_backups/$(date +"%d-%m")/