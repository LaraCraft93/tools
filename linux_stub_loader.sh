#!/bin/sh
# Lara Maia <dev@lara.click>

## CONFIG ########################

EFIROOT=/dev/sda
EFIPART=1

LABEL="Lara Gentoo"
KERNEL=/kernel
SYSTEMROOT="/dev/sda5"
EXTRAOPTS="rw"

#################################

if test $(id -u) -ne 0; then
    echo "You must be root!"
    exit 1
fi

echo "Deleting old entries..."
efibootmgr -b 0000 -B 2>&1 >/dev/null
efibootmgr -b 0001 -B 2>&1 >/dev/null
efibootmgr -O 2>&1 >/dev/null

echo "Creating new entries"
efibootmgr -C -d $EFIROOT -p $EFIPART -L "$LABEL" -l $KERNEL -u "root=$SYSTEMROOT $EXTRAOPTS" >/dev/null
efibootmgr -C -d $EFIROOT -p $EFIPART -L "$LABEL Recovery" -l ${KERNEL}.old -u "root=$SYSTEMROOT $EXTRAOPTS" >/dev/null

echo "Setting boot order"
efibootmgr -o 0000,0001,0002 >/dev/null
efibootmgr -n 0000 >/dev/null

echo -e "Done\n"
efibootmgr -v
