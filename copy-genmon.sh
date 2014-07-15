#!/bin/bash
# Lara Maia (C) 2014 - <lara@craft.net.br>

command_ret=$(echo $1 | sudo -S cat /root/.copy/status.txt)

if [[ $command_ret == *Downloading* ]]; then
    command_ret=${command_ret##*/sec (}
    echo "Sincronizando (falta ${command_ret%% remaining*})"
else
    echo Sincronizado
fi
