#!/bin/bash
# SpeedUp Minecraft Start for Linux - By Lara Maia
# Lara Maia <lara@craft.net.br>
# Versão: 0.1.3 | Copyright © 18/03/2012 - GPLV3

clear; echo -ne "\033[01;33m"
echo -ne "\033]0;SpeedUp Minecraft Start for Linux - By Lara Maia\007"

if (( ${#1} == 0 )); then
  echo -e "\nParâmetros incorretos\033[m\n"; exit 1
else
  if [ ! -f $1 ]; then
    echo -e "\nO caminho para o seu minecraft está incorreto!\033[m\n"
    exit 1
  fi
fi

declare -i test=`uname -m | sed -e 's/x86_//g' -e 's/i//g'`
if (( test == 64 )); then export arch="-d64"; fi

# Global
export jar="$1"
export config="-XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -XX:+UseAdaptiveGCBoundary"
export agressive="-XX:+AggressiveOpts -XX:SurvivorRatio=12"
export process="-XX:MaxGCPauseMillis=500 -XX:-UseGCOverheadLimit -Xnoclassgc"
export sse="-XX:UseSSE=3 -XX:+CMSIncrementalPacing"
export parallel="-XX:ParallelGCThreads=`grep -c cpu[0-9] /proc/stat`"
export ram="-Xms500M -Xmx500M"
export user_=~

function main() {
  declare -i test=`id -u`
  if (( test == 0 )); then
  echo -e "\033[01;37;41m\n Esse script não pode ser executado diretamente como root."
  echo -e " Execute novamente utilizando o seu usuário padrão.       \n\033[m"
  exit 1; fi

  echo -e "\n\nDigite sua senha de root abaixo."
  su root -c exec; declare -i test=$?
  if (( test != 0 )); then 
    echo "Não é possível execução sem senha, saindo..."
  exit 1; fi
}

function exec() {
  trap "echo -e \"\033[m\"; unset jar arch config agressive process sse parallel ram user_; exit 0" INT TERM EXIT
  echo -e "\nInicializando, por favor aguarde..."; killall -9 java >/dev/null 2>&1
  su ${user_##*/} -c 'java $arch -client $config $agressive $process $sse $parallel $ram -jar $jar >/dev/null 2>&1 &'
  echo -e "\033[01;31m\n Ao Sair do jogo, pressione CTRL+C no terminal\n  para finalizar esse script corretamente."
  while true; do
    echo 3 > /proc/sys/vm/drop_caches
    sysctl -w vm.drop_caches=3 >/dev/null 2>&1
    sleep 600
  done
}
export -f exec; main
killall -9 java >/dev/null 2>&1
echo "Tudo Ok :)"
exit 0
