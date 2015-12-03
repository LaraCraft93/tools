#!/bin/bash
# Lara Maia <lara@craft.net.br> 2015
# HEY! You! Do not use it! It's a very VERY ugly workaround.

test $(id -u) -ne 0 && exit 1

_USER=lara
_VERBOSE=0

function link() {
    test $_VERBOSE -eq 1 && v=-v
    [[ "$1" == *"/"* ]] && (mkdir -p $v ${1%/*} || exit 1)
    rm -rf $v "/root/$1" || exit 1
    ln -s $v "/home/$_USER/$1" "/root/$1" || exit 1
    chown $v -R $_USER:users "/home/$_USER/$1" || exit 1
    chmod $v -R u-s,g-s,-t "/home/$_USER/$1" || exit 1
    if [ ! -d "/home/$_USER/$1" ]; then
        chmod $v 00777 "/home/$_USER/$1" || exit 1
    else
        chmod $v -R 2777 "/home/$_USER/$1" || exit 1
        setfacl -d -m group::rwx -m user::rwx -m other::rwx "/home/$_USER/$1" || exit 1
        test $_VERBOSE -eq 1 && getfacl "/home/$_USER/$1"
    fi
}

# Workaround for atom cache
test -d /home/"$_USER"/compile-cache && (rm -rf compile-cache || exit 1)
mkdir -m2777 -p ~/.atom/compile-cache || exit 1

link .icons
link .themes
link .config/xfce4
link .config/geany
link .atom
link .config/Atom
link .config/fish/config.fish
link .grc
