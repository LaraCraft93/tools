#!/bin/bash
# Lara Maia <lara@craft.net.br>
# Code Coffe
# Based on fliptable from:
# http://www.revfad.com/flip.html
# ---------------------------
# $1 = texto

function invert() { # c
	case "$1" in
		a) echo -en '\u02500' ;;
		b) echo -en 'q' ;;
		c) echo -en '\u0254' ;;
		d) echo -en 'p' ;;
		e) echo -en '\u01dd' ;;
		f) echo -en '\u025f' ;;
		g) echo -en '\u0183' ;;
		h) echo -en '\u0265' ;;
		i) echo -en '\u0131' ;;
		j) echo -en '\u027E' ;;
		k) echo -en '\u029E' ;;
		m) echo -en '\u026F' ;;
		n) echo -en 'u' ;;
		r) echo -en '\u0279' ;;
		t) echo -en '\u0287' ;;
		v) echo -en '\u028C' ;;
		w) echo -en '\u028D' ;;
		y) echo -en '\u028E' ;;
		
		'.') echo -en '\u02D9' ;;
		'[') echo -en ']' ;;
		'(') echo -en ')' ;;
		'{') echo -en '}' ;;
		'\') echo -en ' ;;' ;;
		'<') echo -en '>' ;;
		'_') echo -en '\u203E' ;;
		*) echo -en "$1" ;;
	esac
}

while read -n 1 c; do
	if [ "$c" == "" ]; then
		echo -n '  '
		continue
	fi
	invert "$c"
done <<< "$1"
echo

exit 0
