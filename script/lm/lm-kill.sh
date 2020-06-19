#!/bin/sh

set +x

ps aux | grep lmgrd
ps aux | grep snpslmd

pkill -9 lmgrd
pkill -9 snpslmd

ps aux | grep lmgrd
ps aux | grep snpslmd
