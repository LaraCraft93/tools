#!/bin/sh
# Script de compactação 0.6 - Escrito por Lara Maia
# $1 = quantidade de musicas
# $2 = quantidade de tiers

t=1; while [ $[$t-1] != $2 ]; do
    mkdir Guitar\ Hero\ 1
    i=1; while [ $[$i -1] != $1 ]; do
        arqv=$(ls ../*tier${t}/src/${t}.${i}*/ -d)
        arqv=${arqv#*/}; arqv=${arqv#*/}; arqv=${arqv#*/}
        mv ../*tier${t}/src/${t}.${i}*/ Guitar\ Hero\ 1
        (rar a -m5 -ep1 -o- "${arqv:4:-1}" Guitar\ Hero\ 1 Como\ Usar.txt changelog.txt) &
        wait
        mv Guitar\ Hero\ 1/${t}.${i}*/ ../*tier${t}/src  
    i=$[$i+1]; done
    rm -rf Guitar\ Hero/
    sleep 3
t=$[$t+1]; done