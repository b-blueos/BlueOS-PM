#!/bin/bash
#!/bin/bash
echo "Initializing installation!"
echo "Package located at: $1"
echo "Unpacking to: /tmp/blue_update/"
mkdir /tmp/blue_update
tar -C /tmp/blue_update/ -xf $1
chmod +x /tmp/blue_update/index.sh
echo
echo "Starting the main update script..."
bash /tmp/blue_update/index.sh
echo "Creating new manifest..."
cp -av /tmp/blue_update/manifest.py ai_blue/pm/manifest.py
echo "Cleaning up..."
rm -rf ai_blue/update/* /tmp/blue_update/
echo "Done! Have a nice day!"
