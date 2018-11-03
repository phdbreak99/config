#!/usr/bin/env python
import bcrypt
from getpass import getpass

def gen_password_file(output_fpath):
    master_secret_key = getpass('Input master secret key:')
    salt = bcrypt.gensalt()
    combo_password = salt + master_secret_key
    hashed_password = bcrypt.hashpw(combo_password, salt)

    print("salt = " + salt)
    print("hashed_password = " + hashed_password)

