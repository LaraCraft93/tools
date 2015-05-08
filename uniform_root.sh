#!/bin/bash
# Lara Maia <lara@craft.net.br> 2015

test $(id -u) -ne 0 && exit 1

_USER=lara
_VERBOSE=1

function link() {
    test $_VERBOSE -eq 1 && v=-v
    [[ "$1" == *"/"* ]] && (mkdir -p $v ${1%/*} || exit)
    rm -rf $v "/root/$1"
    ln -s $v "/home/$_USER/$1" "/root/$1" || exit 1
    chown $v root:users "/root/$1" || exit 1
    chgrp -R $v users "/root/$1" || exit 1
    chmod $v 3777 "/root/$1" || exit 1
    setfacl -d -m group:users:rwx "/root/$1" || exit 1
    test $_VERBOSE -eq 1 && getfacl "/root/$1"
}

link .icons
link .themes
link .config/xfce4
link .config/geany
