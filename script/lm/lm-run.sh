#!/bin/sh
/nfs/opt/snps/scl/2016.12/linux64/bin/lmgrd -c /nfs/opt/license/vcs.dat -l /nfs/opt/license/lmgrd.log
less +F /nfs/opt/license/lmgrd.log
