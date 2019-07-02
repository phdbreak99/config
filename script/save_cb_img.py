#!/usr/bin/env python3.7

# save image in clipboard to file
# 3 input arguments
#   [1] = output file directory
#   [2] = output file name (suffix), by default will append time string as prefix
#   [3] = output file type: PNG, JPG

from PIL import ImageGrab
import time

import os
import sys

ftype = sys.argv[3].upper()

dpath = sys.argv[1]
assert (os.path.isdir(dpath)), dpath
fname = time.strftime('%Y%m%d-%H%M%S', time.gmtime()) + '-' + sys.argv[2] + '.' + ftype.lower()
fpath = os.path.join(dpath, fname)
assert (not os.path.isfile(fpath)), fpath

img = ImageGrab.grabclipboard()
img.save(fpath, ftype)

print(fpath)
