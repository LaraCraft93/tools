#!/bin/sh
# Script de compactação2 0.2 - Escrito por Lara Maia
# $1 = quantidade de musicas
# $2 = delimitador
# $3 = tier

mkdir Guitar\ Hero\ 1
i=1; while [ $[$i -1] != $1 ]; do
    arqv=$(ls ../*${3}/src/${2}.0${i}*/ -d)
    arqv=${arqv#*/}; arqv=${arqv#*/}; arqv=${arqv#*/}
    mv ../*${3}/src/${2}.0${i}*/ Guitar\ Hero\ 1
    (rar a -m5 -ep1 -o- "${arqv:4:-1}" Guitar\ Hero\ 1 Como\ Usar.txt changelog.txt) &
    wait
    mv Guitar\ Hero\ 1/${2}.0${i}*/ ../*${3}/src  
i=$[$i+1]; done
i=1; while [ $[$i -1] != $1 ]; do
    arqv=$(ls ../*${3}/src/${2}.${i}*/ -d)
    arqv=${arqv#*/}; arqv=${arqv#*/}; arqv=${arqv#*/}
    mv ../*${3}/src/${2}.${i}*/ Guitar\ Hero\ 1
    (rar a -m5 -ep1 -o- "${arqv:4:-1}" Guitar\ Hero\ 1 Como\ Usar.txt changelog.txt) &
    wait
    mv Guitar\ Hero\ 1/${2}.${i}*/ ../*${3}/src  
i=$[$i+01]; done
rm -rf Guitar\ Hero/