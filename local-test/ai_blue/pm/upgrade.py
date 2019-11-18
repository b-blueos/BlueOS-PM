import json
import os
import sys
import requests

manifest = json.loads(open('ai_blue/pm/manifest.json', 'r').read())
print(f'Current version: {manifest["version_name"]} - {manifest["version_denotation"]}')

def exists(path):
    r = requests.head(path)
    return r.status_code == requests.codes.ok
def error(msg):
    print(f"\033[91mERROR: {msg}\033[0m")

if os.getenv('BLUE_DEV') == "true":
    print(f'\nFirst argument: {sys.argv[1]}')
    print(f'Possible updates:')
    for x in manifest["possible_upcoming_versions"]:
        print(f' {x}')
    print(f'\n')

update_found = None
try:
    if sys.argv[1].startswith('/'):
        print(f'Upgrading from local package...')
        if os.path.exists(sys.argv[1]):
            if os.path.isfile(sys.argv[1]):
                if sys.argv[1].endswith('.tar.xz'):
                    print(f'Moving {sys.argv[1]} to ai_blue/update/update.tar.xz to prepare for update...')
                    os.system(f"mv {sys.argv[1]} ai_blue/update/update.tar.xz")
                else:
                    error("That is not a valid update-file. Make sure it is a .tar.xz archive!")
            else:
                error("That is a directory, not a file!")
        else:
            error("That update-file does't exist!")
    elif sys.argv[1].startswith('https://blueos.burnyllama.tk/repo/'):
        print(f'Checking if {sys.argv[1]} exists...')
        if exists(sys.argv[1]) == True:
            update_found = True
            with open("ai_blue/update/update.tar.xz","wb") as update_file:
                update_file.write(requests.get(sys.argv[1]).content)
            print(f'Done!')
        else:
            error(f"{sys.argv[1]} does not exist!")
except:
    i = 1
    for x in manifest["possible_upcoming_versions"]:
        if exists("https://blueos.burnyllama.tk/repo/BlueOS/"+x+"/update.tar.xz") == True and update_found == None:
            update_found = True
            print(f'\nUpdate found @ https://blueos.burnyllama.tk/repo/BlueOS/{x}/update.tar.xz')
            print(f'Downloading...')
            with open("ai_blue/update/update.tar.xz","wb") as update_file:
                update_file.write(requests.get("https://blueos.burnyllama.tk/repo/BlueOS/"+x+"/update.tar.xz").content)
            print(f'Done!')
        else:
            if update_found == None:
                if i >= len(manifest["possible_upcoming_versions"]):
                    error(f'No updates found...')
        i += 1

if update_found == True:
    print(f'')

print(f"\nDone! Have a great day {os.getenv('USER')}!")
open('ai_blue/pm/manifest.json', 'w').write(json.dumps(manifest,indent=4, separators=(", ", " : ")))