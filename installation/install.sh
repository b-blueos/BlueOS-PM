#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo -e "\033[31mERROR: Please run as root/sudo."
  exit
fi

echo -e "\033[34mInstalling 'blue'...\n"

echo "Creating main command..."
cp -a bin/blue /bin/blue

echo "Installing scripts..."
mkdir /blue || echo -e "^ This is not an error, and is probably not dangerous!\n"
mkdir /blue/{pm,update} || echo -e "^ This is not an error, and is probably not dangerous!\n"
cp -ra blue/pm/* /blue/pm/

echo "Done! :)"

echo "For help run: \`blue help\`"