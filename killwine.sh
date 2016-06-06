#!/bin/sh
# Lara Maia <dev@lara.click> 2016

process_list=($(ps x | grep -i '\.exe' | awk '{print $1}'))

for ((i=1; i<${#process_list[@]}; i++)); do
    echo "Killing process ${process_list[$i]}"
    kill -9 ${process_list[$i]}
done

echo "Done."
