import json
import os
import sys
import requests
from manifest import *
print("Current version: ",version_name," - ",version_number_alias)
print("")
print("Checking for update...")

version_number += 1
request = "https://blueos.burnyllama.tk/repo/"+version_name+"/"+str(version_number)+"/manifest.py"
print("Checking for: ",request)

def exists(path):
    r = requests.head(path)
    return r.status_code == requests.codes.ok

if exists(request) == True:
    print("Exists! Do you wish to install it? [y/N]")
    download_update = input()
    if download_update == "y" or download_update == "Y":
        print("Sure")
    else:
        print("Okay, not upgrading!")
else:
    print("There's no updates! Have a great day!")
