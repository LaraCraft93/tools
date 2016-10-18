#!/bin/sh
# Lara Maia <dev@lara.click>

## CONFIG ########################

EFIROOT=/dev/sda
EFIPART=1

LABEL="Lara Gentoo"
KERNEL=/kernel
SYSTEMROOT="PARTUUID=F717E7D8-2E32-4123-AC66-463731E4AE54"
EXTRAOPTS="rw"
ROOTFLAGS="data=writeback"

#################################

if test $(id -u) -ne 0; then
    echo "You must be root!"
    exit 1
fi

echo "Deleting old entries..."
efibootmgr -b 0000 -B 2>&1 >/dev/null
efibootmgr -b 0001 -B 2>&1 >/dev/null
efibootmgr -b 0002 -B 2>&1 >/dev/null
efibootmgr -O 2>&1 >/dev/null

echo "Creating new entries"
efibootmgr -C -d $EFIROOT -p $EFIPART -L "$LABEL" -l $KERNEL -u "root=$SYSTEMROOT rootflags=$ROOTFLAGS $EXTRAOPTS" >/dev/null
efibootmgr -C -d $EFIROOT -p $EFIPART -L "$LABEL Recovery" -l ${KERNEL}.old -u "root=$SYSTEMROOT rootflags=$ROOTFLAGS $EXTRAOPTS" >/dev/null
efibootmgr -C -d $EFIROOT -p $EFIPART -L "$LABEL Emergency" -l ${KERNEL}.emergency -u "root=$SYSTEMROOT $EXTRAOPTS" >/dev/null

echo "Setting boot order"
efibootmgr -o 0000,0001,0002,0003 >/dev/null
efibootmgr -n 0000 >/dev/null

echo -e "Done\n"
efibootmgr -v
