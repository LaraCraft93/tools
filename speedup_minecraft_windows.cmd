@ECHO OFF
::: SpeedUp Minecraft Start for Windows - By Lara Maia
::: Lara Maia <lara@craft.net.br>
::: Versão: 0.1 | Copyright © 19/03/2012 - GPLV3

mode 70,25&color 1a&type %tmp%\consolelog | more /c
title SpeedUp Minecraft Start for Windows - By Lara Maia

setlocal DISABLEDELAYEDEXPANSION

if not exist %1 (
  echo O Caminho para o seu Minecraft esta incorreto!
  goto EOF
)
if defined ProgramFiles(x86) (set arch=-d64)
if not defined arch (
  echo Seu S/O esta executando em modo de 32 bits.
) else (
  echo S/O esta executando em modo de 64 bits.
)

wmic cpu get NumberOfCores | findstr ^[0-9] > %tmp%\NumberOfCores.db
for /F "tokens=*" %%A in (%tmp%\NumberOfCores.db) do set CPU_COUNT=%%A

rem Global
set jar="%1"
set config="-XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -XX:+UseAdaptiveGCBoundary"
set agressive="-XX:+AggressiveOpts -XX:SurvivorRatio=12"
set process="-XX:MaxGCPauseMillis=500 -XX:-UseGCOverheadLimit -Xnoclassgc"
set sse="-XX:UseSSE=3 -XX:+CMSIncrementalPacing"
set parallel="-XX:ParallelGCThreads=%CPU_COUNT: =%"
set ram="-Xms500M -Xmx500M"

echo Seu processador possu¡: %CPU_COUNT: =% n£cleos.&echo.
echo Se estas informa‡”es estiverem erradas, reporte o erro para
echo lara@craft.net.br ou no local a onde encontrou este script.

:exec
echo.&echo Inicializando, por favor aguarde...&taskkill /F /IM java.exe 2>%tmp%\consolelog&taskkill /F /IM wscript 2>%tmp%\consolelog
for /D %%i in (%jar%) do (set file=%%~ni%%~xi&cd %%~di%%~pi)
echo set objshell = createobject("wscript.shell")>%tmp%\startjava.vbs
echo objshell.run "%tmp%\startjava.cmd", vbhide>>%tmp%\startjava.vbs
echo @echo off>%tmp%\startjava.cmd
echo start /MIN java %arch% -client %config:~1,-1% %agressive:~1,-1% %process:~1,-1% %sse:~1,-1% %parallel:~1,-1% %ram:~1,-1% -jar %file%>>%tmp%\startjava.cmd
start %tmp%\startjava.vbs&echo.&echo Ao Terminar o seu jogo, pode fechar esta janela.

endlocal

:while_true
  %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
  ping -n 598 localhost >%tmp%\consolelog
  goto while_true
:EOF
