#!/bin/bash
# Lara Maia <lara@craft.net.br> 2015

set -e

if test $(id -u) != 0
then
    echo "Você precisa executar como ROOT!"
    exit 1
fi

function checkmv() {
    if test -f "$1"; then
        mv "$1" "$2"
    fi
}

#function make() {
#    $(which make) HOSTCC=clang CC=clang $@
#}

pushd /usr/src/linux

# limpar source antes da compilação
make distclean

# Atualizar configuração preferida
cp /boot/kernel.config /usr/src/linux/.config
make silentoldconfig

# Abrir menu de configuração
if test "$1" != '-q' && make menuconfig
#make gconfig

# Fazer backup da configuração
checkmv /boot/kernel.config /boot/kernel.config.old
cp .config /boot/kernel.config

# Compilar o kernel
make -j5

# Instalar o kernel e módulos selecionados
make modules_install
checkmv /boot/kernel /boot/kernel.old
cp arch/x86/boot/bzImage /boot/kernel
checkmv /boot/System.map /boot/System.map.old
cp System.map /boot/System.map

# Preparar e recompilar módulos externos
make modules_prepare
emerge @module-rebuild

popd

# Atualizar bootloader
./linux_stub_loader.sh
