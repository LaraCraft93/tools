#!/bin/bash
# Lara Maia <dev@lara.click>

set -e

if test $(id -u) != 0
then
    echo "Você precisa executar como ROOT!"
    exit 1
fi


# ============== Configuration ============== #

# Verbose mode (1 = enable, 0 = disable)
VERBOSE=1

# Colorized output (1 = enable, 0 = disable)
# You will need grc installed to use this
COLOR=1

# Open menuconfig before build (1 = enable, 0 = disable)
MENUCONFIG=1

# Check if external modules needs rebuild (1 = enable, 0 = disable)
EXTMODULES=1

# Update bootloader (1 = enable, 0 = disable)
# Works only with the linux_stub_loader.sh script
BOOTLOADER=1

# Numbers of threads (CPU CORES + 2)
JOBS=6
# =========================================== #


# ================ functions ================ #
function checkmv() {
    if test -f "$1"; then
        mv "$1" "$2" || exit 1
    else
        echo "Error when mv ($1 > $2)"
        exit 1
    fi
}

function checkcp() {
    if test -f "$1"; then
        cp "$1" "$2" || exit 1
    else
        echo "Error when cp ($1 > $2)"
        exit 1
    fi
}

function colormake() {
    if test $COLOR -eq 1; then
        grc -es /usr/bin/make $@
    else
        /usr/bin/make $@
    fi
}

function kernelmake() {
	colormake V=$VERBOSE -j$JOBS

	if test $? -ne 0; then
		if test $VERBOSE -eq 1; then
			make -j$JOBS | grep -n10 '***'
		fi
		return 1
	fi
}
# =========================================== #

pushd /usr/src/linux || exit 1

# limpar source antes da compilação
make distclean || exit 1

# Atualizar configuração preferida
if test -f /boot/kernel.config; then
    checkcp /boot/kernel.config /usr/src/linux/.config
fi
make silentoldconfig || exit 1

# Abrir menu de configuração
if test $MENUCONFIG -eq 1; then
    make menuconfig || exit 1
fi

# Fazer backup da configuração
if test -f /boot/kernel.config; then
    checkmv /boot/kernel.config /boot/kernel.config.old
fi
checkcp .config /boot/kernel.config

# Compilar o kernel
kernelmake || exit 1

# Instalar o kernel e módulos selecionados
colormake modules_install || exit 1
checkmv /boot/kernel /boot/kernel.old
checkcp arch/x86/boot/bzImage /boot/kernel
checkmv /boot/System.map /boot/System.map.old
checkcp System.map /boot/System.map

# Preparar e recompilar módulos externos
if test $EXTMODULES -eq 1; then
    colormake modules_prepare || exit 1
    emerge @module-rebuild || exit 1
fi

popd || exit 1

# Atualizar bootloader
if test $BOOTLOADER -eq 1; then
    $(dirname $0||echo '.')/linux_stub_loader.sh || exit 1
fi

exit 0
