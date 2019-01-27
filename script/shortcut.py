#!/usr/bin/env python3

import os
import sys
import pathlib
import difflib
import fnmatch
from typing import List, Dict

"""
Provide shortcut to directory or program, according to input abbreviation

# defined abbr and their commands are saved in shortcut.*.save files
- by default they locate in ~/.shortcut/ directory

# the format of a save file is like
Note: command could contain newline symbol, which means it could be multiple lines string

~~~
#<abbr1>
<command1>
#<abbr2>
<command2>
...
~~~

# command line usage
## normal function: print corresponding command to stdout
shortcut.py <mode> <abbr>
    ex. shortcut.py go abc

## search: pring search result to stderr
shortcut.py <mode> <abbr_pattern>
    ex. shortcut.py go a*

## search and list details
shortcut.py <mode> <abbr_pattern> --detail

## save file location
by default: in ~/.shortcut/
use system env variable SHORTCUT_SAVE_DIRS (higher priority than default)
use --save_dirs command line argumens (higher priority than system env)
"""


class Shortcut:
    """
    :type save: Dict[str, str]
    :type save_fpath: pathlib.Path
    """
    def __init__(self, mode: str, is_debug: bool = False, is_detail: bool = False, ls_save_fpath: List[pathlib.Path] = list()):
        self.mode = mode
        self.is_debug = is_debug
        self.is_detail = is_detail
        self.ls_save_fpath = ls_save_fpath

        self.save = dict()
        self.load()

    #===========================================================
    # save file operation
    #===========================================================

    def load(self) -> None:
        for save_fpath in self.ls_save_fpath:
            if (self.is_debug):
                print('INFO: load save from %s' % save_fpath, file=sys.stderr)
            with save_fpath.open('r') as f:
                abbr = None
                cmd = None
                for line in f:
                    if ((len(line.strip()) == 0) or (line.startswith(r'//'))):
                        # skip empty and comment
                        continue

                    if (line[0] == '#'):
                        if (abbr is not None):
                            self.save[abbr] = cmd
                        abbr = line.rstrip()[1:]
                        cmd = ''
                    else:
                        cmd += line
                self.save[abbr] = cmd

    # def dump(self):
    #     if (self.is_debug):
    #         print('INFO: dump save to %s' % self.save_fpath, file=sys.stderr)
    #
    #     ls = [(k, v) for (k, v) in self.save.items()]
    #
    #     with self.save_fpath.open('w') as f:
    #         for (abbr, cmd) in sorted(ls, lambda x: x[1]):
    #             f.write('#%s\n' % abbr)
    #             f.write(cmd)

    #===========================================================
    # shortcut operation
    #===========================================================

    def get(self, abbr):
        if (abbr not in self.save.keys()):
            ls_abbr = [k for k in self.save.keys()]
            ls_close_abbr = difflib.get_close_matches(abbr, ls_abbr, n=1)
            if (len(ls_close_abbr) == 0):
                print('ERROR: abbr (%s) does not exist for mode (%s)' % (abbr, self.mode), file=sys.stderr)
                return None
            else:
                print('WARNING: auto-correct abbr (%s) to (%s) for mode (%s)' % (abbr, ls_close_abbr[0], self.mode), file=sys.stderr)
                abbr = ls_close_abbr[0]
        cmd = self.save[abbr]
        cmd = cmd.replace('\n', ';').replace(';;', ';')
        print(cmd)
        print(cmd, file=sys.stderr)

    def search(self, pat):
        ls_matched_abbr = list()
        for abbr in self.save.keys():
            if (fnmatch.fnmatch(abbr, pat)):
                ls_matched_abbr.append(abbr)

        print('searching shortcut for ' + pat + ' :', file=sys.stderr)
        if (self.is_detail):
            for abbr in ls_matched_abbr:
                print('    ' + abbr + ' -> ' + self.save[abbr], file=sys.stderr, end='')
            print('')
        else:
            print('    ' + ' '.join(ls_matched_abbr), file=sys.stderr)
            print('')

    def add(self, abbr, cmd):
        assert abbr.search('\n') == -1
        assert cmd[-1] == '\n'
        self.save[abbr] = cmd

    def delete(self, abbr):
        assert abbr in self.save.keys()
        self.save.__delitem__(abbr)

################################################################


def cmd_line(argv, is_debug=False):
    if (is_debug):
        print(argv, file=sys.stderr)

    assert len(argv) >= 2, 'input arguments = %s' % argv
    mode = argv[0]  # type: str
    abbr = argv[1]  # type: str

    if (is_debug):
        print('mode = ' + mode, file=sys.stderr)
        print('abbr = ' + abbr, file=sys.stderr)

    if ((len(argv) == 3) and ((argv[2] == '--detail') or (argv[2] == '-d'))):
        is_detail = True
    else:
        is_detail = False

    # save file path
    ls_save_dir = list()
    if ('SHORTCUT_SAVE_DIRS' in os.environ.keys()):
        for save_dir in os.environ['SHORTCUT_SAVE_DIRS'].split(':'):
            ls_save_dir.append(save_dir)
    if ((len(argv) >= 4) and ((argv[2] == '--save_dirs') or (argv[2] == '-s'))):
        ls_save_dir += argv[3:]

    ls_save_fpath = list()
    home_save_fpath = pathlib.Path.home() / '.shortcut' / ('shortcut.%s.save' % mode)
    if (home_save_fpath.is_file()):
        ls_save_fpath.append(home_save_fpath)
    for save_dir in ls_save_dir:
        save_fpath = pathlib.Path(save_dir) / ('shortcut.%s.save' % mode)
        if save_fpath.is_file():
            ls_save_fpath.append(save_fpath)

    # call
    sc = Shortcut(mode, is_debug=is_debug, is_detail=is_detail, ls_save_fpath=ls_save_fpath)

    if (abbr.find('*') >= 0):
        sc.search(abbr)
    else:
        sc.get(abbr)

    return

if __name__ == '__main__':
    #  cmd_line(sys.argv[1:], is_debug=True)
    cmd_line(sys.argv[1:], is_debug=False)
