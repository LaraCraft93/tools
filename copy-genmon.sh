#!/bin/bash
# Lara Maia (C) 2014 - <lara@craft.net.br>
# v2.1

command_ret=$(echo "$1" | sudo -S cat /root/.copy/status.txt)
config_ret=$(echo "$1" | sudo -S cat /root/.copy/config.ini)
icon="$HOME"/.genmon-icon/copy.png

echo "<img>$icon</img>"
echo "<tool>$config_ret</tool>"

if [[ $command_ret == *Downloading* ]]; then
    command_ret=${command_ret##*/sec (}
    echo "<txt>Sincronizando (falta ${command_ret%% remaining*})</txt>"
elif [[ $command_ret == *Comparing* ]]; then
    command_ret=${command_ret##*items (}
    echo "<txt>Comparando (falta ${command_ret%% remaining*})</txt>"
else
    echo "<txt>Sincronizado</txt>"
fi
