import json
import os
import requests

# Get the Manifest
manifest = json.loads(open('/blue/pm/manifest.json', 'r').read())

print(f'Current version: {manifest["version_name"]} - {manifest["version_denotation"]}')

if os.getenv('BLUE_DEV') == "true":
    print(f'\nPossible updates:')
    for x in manifest["possible_upcoming_versions"]:
        print(f' {x}')
    print(f'\n')


def exists(path):
    r = requests.head(path)
    return r.status_code == requests.codes.ok

update_found = None
i = 1
for x in manifest["possible_upcoming_versions"]:
    if exists("https://blueos.burnyllama.tk/repo/BlueOS/"+x+"/update.tar.xz") == True and update_found == None:
        update_found = True
        print(f'\nUpdate found @ https://blueos.burnyllama.tk/repo/BlueOS/{x}/update.tar.xz')
        print(f'Do you want to install it? [y/N]')
        download_update = input()
        if download_update == "y" or download_update == "Y":
            os.system(f"python /blue/pm/upgrade.py https://blueos.burnyllama.tk/repo/BlueOS/{x}/update.tar.xz")
        else: 
            print("Okay, not upgrading!")
    else:
        if update_found == None:
            print(f'Looking for update...')
            if i >= len(manifest["possible_upcoming_versions"]):
                print(f'No updates found...')
    i += 1

open('/blue/pm/manifest.json', 'w').write(json.dumps(manifest,indent=4, separators=(", ", " : ")))