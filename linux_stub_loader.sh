#!/bin/sh

## CONFIG ########################

EFIROOT=/dev/sda
EFIPART=1

LABEL="Arch Linux Ck"
KERNEL=/vmlinuz-linux-ck
INITRD=/initramfs-linux-ck.img
SYSTEMROOT=/dev/sda2
EXTRAOPTS="rw quiet splash"

#################################

test $(id -u) == 0 || exit 1
efibootmgr -b 0000 -B >/dev/null
efibootmgr -d $EFIROOT -p $EFIPART -c -L "$LABEL" -l $KERNEL -u "root=$SYSTEMROOT initrd=$INITRD $EXTRAOPTS"
efibootmgr -v
