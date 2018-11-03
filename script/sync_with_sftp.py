#!/usr/bin/env python2

import pysftp
from getpass import getpass

# with pysftp.Connection('hostname', username='me', password='secret') as sftp:
#     with sftp.cd('public'):             # temporarily chdir to public
#         sftp.put('/my/local/filename')  # upload file to public/ on remote
#         sftp.get('remote_file')         # get a remote file

with pysftp.Connection('50.250.209.133', username='jwang', password=getpass('Input password:')) as sftp:
    with sftp.cd('/work/users/jwang/pygmy.orv/doc'):
        while (True):
            sftp.put('/Users/jwang/work/pygmy.orv/doc/orv-design-doc.xlsx')
            raw_input('REPEAT');
