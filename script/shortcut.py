#!/usr/bin/env python3

import os
import sys
import pathlib
import difflib
import fnmatch
from typing import List, Dict

class Shortcut:
    """
    :type save: Dict[str, str]
    :type cfg_fpath: pathlib.Path
    """
    def __init__(self, mode: str, is_debug: bool = False, is_detail: bool = False):
        self.mode = mode
        self.is_debug = is_debug
        self.is_detail = is_detail

        self.cfg_fpath = pathlib.Path.home() / '.shortcut' / ('%s.cfg' % mode)
        assert self.cfg_fpath.is_file(), 'cannot find %s' % self.cfg_fpath

        self.save = dict()
        self.load()


    #===========================================================
    # load config file
    #===========================================================

    def load(self) -> None:
        if (self.is_debug):
            print('INFO: load save from %s' % self.cfg_fpath, file=sys.stderr)
        with self.cfg_fpath.open('r') as f:
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

################################################################


def cmd_line(argv, is_debug=False, is_detail=True):
    if (is_debug):
        print(argv, file=sys.stderr)

    if (len(argv) == 1):
        argv.append('.')

    assert len(argv) >= 2, 'input arguments = %s' % argv
    mode = argv[0]  # type: str
    abbr = argv[1]  # type: str

    if (is_debug):
        print('mode = ' + mode, file=sys.stderr)
        print('abbr = ' + abbr, file=sys.stderr)

    # call
    sc = Shortcut(mode, is_debug=is_debug, is_detail=is_detail)

    if (abbr.find('.') >= 0):
        pat = abbr.replace('.', '*')
        sc.search(pat)
    else:
        sc.get(abbr)

    return

if __name__ == '__main__':
    cmd_line(sys.argv[1:], is_debug=True, is_detail=True)
    # cmd_line(sys.argv[1:], is_debug=False, is_detail=True)
