#!/bin/bash
# Lara Maia <lara@craft.net.br>

STEAM="$HOME"/.local/share/Steam
RCE=Robocraft.x86_64
RCE_PATH=SteamApps/common/Robocraft
EAC=Robocraft_Data/Plugins/x86_64/libeasyanticheat.so

ulimit -n 4096

LD_PRELOAD=$LD_PRELOAD:$STEAM/$RCE_PATH/$EAC $STEAM/$RCE_PATH/$RCE &

for i in $(seq 0 10); do
    sleep 1
    if [ "$(pidof $RCE)" != "$(pidof $RCE -s)" ] \
    && [ "$(ps -p `pidof $RCE -s` -o comm=)" != "$0" ]; then
        echo "killing \"$(pidof $RCE -s)\""
        kill $(pidof $RCE -s)
    fi
done
