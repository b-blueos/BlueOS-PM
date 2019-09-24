#!/bin/bash
echo "Initializing installation!"
echo "Package located at: $1"
echo "Unpacking to: /tmp/blue_update/"
mkdir /tmp/blue_update
tar -C /tmp/blue_update/ -xf $1
chmod +x /tmp/blue_update/index.sh
echo
echo "Checking the manifest!"
echo "Nothing done - NOT IMPLEMENTED!"
echo "If you didn't download this from the official repository (blueos.burnyllama.tk)."
echo "Updates from other sources may be harmful."
echo "Are you sure you want to continue? [y/N]"
read -p "> " SANITY_CHECK
if [ "$SANITY_CHECK" == "y" ] || [ "$SANITY_CHECK" == "y" ] ; then
clear
echo; echo "Continuing..."
echo "You'll have to manually check the manifests."
echo "Local manifest:"
cat ai_blue/pm/manifest.py
echo; echo "Update manifest:"
cat /tmp/blue_update/manifest.py
echo; echo "Make sure the \`version_name\` is the same, unless a there's a version name bump."
echo "\`version_number\` should be 1 higher in the update manifest."
echo "Does everything look okay?? [y/N]"
read -p "> " MANIFEST_CHECK
if [ "$MANIFEST_CHECK" == "y" ] || [ "$MANIFEST_CHECK" == "y" ] ; then
echo "Starting the main update script..."
bash /tmp/blue_update/index.sh
echo "Creating new manifest..."
cp -av /tmp/blue_update/manifest.py ai_blue/pm/manifest.py
echo "Cleaning up..."
rm -rf ai_blue/update/* /tmp/blue_update/
echo "Done! Have a nice day!"
fi
fi
exit
