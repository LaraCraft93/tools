#!/bin/bash
# RamDisk Minecraft Server Start
# Autor: Lara Maia <lara@craft.net.br>
# Versão: 0.9 | 30/01/2012

# Checa variáveis de linha de comando
if [ "$1" == "--verbose" ]; then
	verbose=true
fi

# Variáveis Globais
minecraft_server="/home/mrk3004/Develop/Ramdisk_Arq/server"
minecraft="/home/mrk3004/Develop/Ramdisk_Arq/minecraft"
RAM_minecraft_server="/home/mrk3004/.minecraft_server"
RAM_minecraft="/home/mrk3004/.minecraft"

#Correção gráfica
printf "\n\n"

# Deleta arquivos do RamDisk caso exista
# E cria ponto de montagem se não existir.
if [ $verbose ]; then
	rm -rfv ${RAM_minecraft}/*
	rm -rfv ${RAM_minecraft_server}/*
	mkdir ${RAM_minecraft}
	mkdir ${RAM_minecraft_server}
else
	echo "Excluindo arquivos do RamDisk (Minecraft)"
	rm -rfv ${RAM_minecraft}/* >/dev/null 2>&1
	echo "Excluindo arquivos do RamDisk (Server)"
	rm -rfv ${RAM_minecraft_server}/* >/dev/null 2>&1
	echo "Criando pontos de montagem do RamDisk"
	mkdir ${RAM_minecraft} >/dev/null 2>&1
	mkdir ${RAM_minecraft_server} >/dev/null 2>&1
fi

# Desmonta sistema de arquivos caso já montado
echo "Checando sistema de arquivos já montados"
sudo umount -v ${RAM_minecraft} >/dev/null 2>&1
sudo umount -v ${RAM_minecraft_server} >/dev/null 2>&1

# Monta sistema de Arquivos
if [ ! $verbose ]; then echo "Montando Sistema de Arquivos na RAM"; fi
sudo mount -t tmpfs -o size=100m tmpfs ${RAM_minecraft}
sudo mount -t tmpfs -o size=300m tmpfs ${RAM_minecraft_server}

# Copia arquivos para o RamDisk
if [ $verbose ]; then
	cp -rfv ${minecraft}/* ${RAM_minecraft}
	cp -rfv ${minecraft_server}/* ${RAM_minecraft_server}
else
	echo "Copiando arquivos do Minecraft para o RamDisk"
	cp -rfv ${minecraft}/* ${RAM_minecraft} >/dev/null 2>&1
	echo "Copiando arquivos do Server para o RamDisk"
	cp -rfv ${minecraft_server}/* ${RAM_minecraft_server} >/dev/null 2>&1
fi

# FIXME: Ajusta diretório de trabalho para o server
cd ${RAM_minecraft_server} 

# Inicia o Servidor
echo "Iniciando o Servidor, por favor aguarde..."; sleep 5
java -d64 -jar craftbukkit.jar

# Mensagem de saída do server
echo "Saindo, por favor aguarde..."

# Faz backup e apaga arquivos do RamDisk
if [ $verbose ]; then
	cp -rfv ${RAM_minecraft}/* ${minecraft}/
	cp -rfv ${RAM_minecraft_server}/* ${minecraft_server}/
	rm -rfv ${RAM_minecraft}/*
	rm -rfv ${RAM_minecraft_server}/*
else
	echo "Fazendo backup dos arquivos do minecraft"
	cp -rfv ${RAM_minecraft}/* ${minecraft}/ >/dev/null 2>&1
	echo "Fazendo backup dos arquivos do server"
	cp -rfv ${RAM_minecraft_server}/* ${minecraft_server}/ >/dev/null 2>&1
	echo "Removendo arquivos do RamDisk (Minecraft)"
	rm -rfv ${RAM_minecraft}/* >/dev/null 2>&1
	echo "Removendo arquivos do RamDisk (Server)"
	rm -rfv ${RAM_minecraft_server}/* >/dev/null 2>&1
fi

#Correção gráfica
printf "\n\n"

exit 0
