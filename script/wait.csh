#!/usr/bin/tcsh -f

if ($2 == "") then
    set sec=60
else
    set sec=$2
endif

echo "wait for $1 (checking every $sec seconds)"


recheck:
if (! -e $1) then
    sleep $sec
    echo -n "."
    goto recheck
else if(-e $1) then
    sleep $sec
endif

echo "\nwait is done"
