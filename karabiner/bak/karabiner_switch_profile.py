#!/usr/bin/env python3
import os
import sys
import json
import signal
import psutil
import argparse
import subprocess
from os.path import expanduser
from collections import OrderedDict

CONFIG_PATH = '.config/karabiner/karabiner.json'


home = expanduser("~")
config = {}


def find_procs_by_name(name):
    "Return a list of processes matching 'name'."
    ls = []
    for p in psutil.process_iter():
        proc_name = ""
        try:
            proc_name = p.name()
        except (psutil.AccessDenied, psutil.ZombieProcess):
            pass
        except psutil.NoSuchProcess:
            continue
        if name in proc_name:
            ls.append(p.pid)
    return ls


def get_profiles():
    with open('{}/{}'.format(home, CONFIG_PATH)) as json_data:
        profiles = []
        config = json.load(json_data)
        for profile in config['profiles']:
            profiles.append((profile['name'], profile['selected']))
        return profiles


def get_active_profile():
    return [x[0] for x in get_profiles() if x[1]][0]


def rewrite_config(choice):
    with open('{}/{}'.format(home, CONFIG_PATH)) as conf_file:
        config = json.load(conf_file, object_pairs_hook=OrderedDict)
        for profile in config['profiles']:
            profile['selected'] = profile['name'] == choice

    with open('{}/{}'.format(home, CONFIG_PATH), 'w') as conf_file:
        conf_file.write(json.dumps(config, indent=4, separators=(',', ': ')))


def restart_karabiner():
    for pid in find_procs_by_name('karabiner_console_user_server'):
        os.kill(pid, signal.SIGTERM)


def parse_args():
    parser = argparse.ArgumentParser(prog='karabiner_profile')
    parser.add_argument('-p', '--profile', help="select profile", choices=[x[0] for x in get_profiles()])
    parser.add_argument('-l', '--list', help="list profiles", default=False, action='store_true')
    return parser.parse_args()


def run_notifier(message):
    args = ['terminal-notifier', '-sender', 'com.apple.Terminal', '-title', 'Karabiner', '-message', message]
    subprocess.check_call(args)


def main():
    args = parse_args()
    if args.list:
        for profile, _ in get_profiles():
            print('* {}'.format(profile))
    elif args.profile:
        rewrite_config(args.profile)
        restart_karabiner()
        run_notifier('Activated new profile: {}'.format(args.profile))
    else:
        run_notifier('Current active profile: {}'.format(get_active_profile()))
    sys.exit(0)


if __name__ == "__main__":
    main()
