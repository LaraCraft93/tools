#!/bin/bash
# Lara Maia <lara@craft.net.br>
#
# Depends: procps-ng, sqlite

declare profile_path="$HOME"/.mozilla/firefox/
declare profile_name=
declare -a databases=
declare -i count=0

if test `id -u` -eq 0
then
    echo "Execute with your user for clear your profile."
    read -n1 -p "Clear root profile? [S/n]: " opc
    echo
    case $opc in
        n|N) exit 0 ;;
        s|S) profile_path=/root/.mozilla/firefox/ ;;
    esac
    unset -v opc
fi

if test "$(pgrep -x firefox)"
then
    echo "Please close your browser before running this script."
    exit 1
fi

trap "exit 1" SIGINT SIGTERM SIGKILL

if test -f "$profile_path/profiles.ini"
then
    profile_name=$(cat "$profile_path"/profiles.ini | grep Path | cut -d'=' -f2)
    databases=($(find "$profile_path/$profile_name" -type f -name "*.sqlite" -print))
    for db in ${databases[@]}
    do
        echo -ne "\rOptimizing database for user $USER ($[($count+1)*100/${#databases[@]}]%)"
        sqlite3 "$db" "ANALYZE;"
        sqlite3 "$db" "VACUUM;"
        sqlite3 "$db" "REINDEX;"
        let count++
    done
else
    echo "Firefox profile not found for user $USER"
    exit 1
fi

exit 0
