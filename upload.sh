#!/bin/bash
# Script de Upload para o megaupload - 0.1
# Autor: Lara Maia
# ----------------------------
# Dependências: curl, trickle, [plowshare http://goo.gl/rY2v9]
# --------------------------
# $1 = usuario
# $2 = senha

trickle -u 25 -s plowup megaupload -a ${1}:${2} -d \
	"http://forum.fretsonfire.net.br" *.rar
