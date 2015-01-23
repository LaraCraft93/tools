#!/bin/sh

## CONFIG ########################

EFIROOT=/dev/sda
EFIPART=1

LABEL="Arch Linux Ck"
KERNEL=/vmlinuz-linux-ck
INITRD=/initramfs-linux-ck.img
SYSTEMROOT=/dev/sda2
EXTRAOPTS="rw resume=/dev/sda2 resume_offset=15296512 threadirqs"
INIT="/usr/lib/systemd/systemd"

#################################

test $(id -u) == 0 || exit 1
efibootmgr -b 0000 -B >/dev/null
efibootmgr -d $EFIROOT -p $EFIPART -c -L "$LABEL" -l $KERNEL -u "root=$SYSTEMROOT initrd=$INITRD init=$INIT $EXTRAOPTS"
efibootmgr -O >/dev/null
efibootmgr -o 0000,0001 >/dev/null
efibootmgr -n 0000 >/dev/null
efibootmgr -v
