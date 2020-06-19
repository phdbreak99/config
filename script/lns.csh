#!/bin/tcsh -f

foreach file ($argv)
    \ln -s $file
end
