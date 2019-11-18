#!/bin/bash
echo "Welcome to BlueOS Clean Up Service [BETA]!"

read -p "Do you want to clear [mostly] unneeded pacman cache? [y/N]" CLEAR_PACMAN_CACHE
read -p "Do you want to clear unneeded temporary files? [y/N]" CLEAR_TMP_FILES
echo "Do you want to clear thumbnail cache? \nCurrent Size:"
du -sh ~/.cache/thumbnails
read -p "[y/N]" CLEAR_THBNL_CACHE
read -p "Do you want to empty ALL your downloads? [y/N]" CLEAR_DOWNLOADS

if [ "$CLEAR_PACMAN_CACHE" == "Y" ] || [ "$CLEAR_PACMAN_CACHE" == "y" ] ; then
    echo "Clearing pacmancache..."
    sudo pacman -Sc
fi
if [ "$CLEAR_TMP_FILES" == "Y" ] || [ "$CLEAR_TMP_FILES" == "y" ] ; then
    echo "Clearing /tmp folder..."
    sudo rm -rf /tmp/*
fi
if [ "$CLEAR_THBNL_CACHE" == "Y" ] || [ "$CLEAR_THBNL_CACHE" == "y" ] ; then
    echo "Clearing thumbnail cache..."
    rm -rf ~/.cache/thumbnails
fi
if [ "$CLEAR_DOWNLOADS" == "Y" ] || [ "$CLEAR_DOWNLOADS" == "y" ] ; then
    echo "Clearing downloads folder..."
    rm -rf ~/Downloads/*
fi

echo "Okay, done!"