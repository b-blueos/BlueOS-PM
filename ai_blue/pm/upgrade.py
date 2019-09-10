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
    print("An update found!")
    print("Downloading...")
else:
    print("There's no updates! Have a great day!")
