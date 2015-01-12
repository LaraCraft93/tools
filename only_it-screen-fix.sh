#!/bin/sh
# Lara Maia <lara@craft.net.br>

mkdir -p "$XDG_CONFIG_HOME/unity3d/Creability/Only If/"

cat << EOF > "$XDG_CONFIG_HOME/unity3d/Creability/Only If/prefs"
<unity_prefs version_major="1" version_minor="0">
	<pref name="Screenmanager Is Fullscreen mode" type="int">0</pref>
	<pref name="Screenmanager Resolution Height" type="int">1025</pref>
	<pref name="Screenmanager Resolution Width" type="int">1915</pref>
</unity_prefs>
EOF
