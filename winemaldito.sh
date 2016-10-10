#!/bin/bash
# Lara Maia <dev@lara.click> 2016

if test $(id -u) -ne 0; then
    echo "You must run with root privileges."
    exit 1
fi

function formatted() {
    printf "%$(stty -a <$(tty) | grep -Po '(?<=columns )\d+')c\r$1\r"
}

function clean() {
    for file in $(ls -1 $HOME/.local/share/{desktop-directories,applications}/{wine/*,wine-*} \
                        $HOME/.config/menus/applications-merged/wine-* \
                        /usr/share/{desktop-directories,applications}/wine-* \
                        2>/dev/null); do
        formatted "Removing $file..."
        rm -rf $file
        sleep 0.1
    done
}

formatted "Cleaning..."
clean
formatted "Done.\n"

exit 0
