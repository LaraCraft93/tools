#!/bin/sh

## CONFIG ########################

EFIROOT=/dev/sda
EFIPART=1

LABEL="Lara Gentoo"
KERNEL=/kernel
SYSTEMROOT=/dev/sda3
EXTRAOPTS="rw"
INIT="/usr/lib/systemd/systemd"

#################################

test $(id -u) == 0 || exit 1
efibootmgr -b 0000 -B >/dev/null
efibootmgr -d $EFIROOT -p $EFIPART -c -L "$LABEL" -l $KERNEL -u "root=$SYSTEMROOT init=$INIT $EXTRAOPTS" >/dev/null
efibootmgr -O >/dev/null
efibootmgr -o 0000,0001 >/dev/null
efibootmgr -n 0000 >/dev/null
efibootmgr -v
