::Script criado por Lara Maia <lara@craft.net.br>
::Versão: 2.0 | Revisão: 19.0.0
::Apoio: fretsonfirebrasil.forumclan.com
::Esse software é um software de código livre
::e pode ser modificado de qualquer maneira
::desde que sejam mantidos os devidos créditos 
::ao autor do script. Faça bom uso.

@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
title Optimizador de Sistema Viny Corporation - 2010
mode 70,30
color 0E

goto:2
::----------------------------

:1
cls

:ARQUIVTEMPOHISTORICOSENHAS
echo Limpando hist¢rico de Senhas
echo.
echo Caso o hist¢rico esteja limpo , poder  receber algumas mensagens.
echo Se aconte‡er , clique em ok e as ignore
echo.
echo Pressione uma tecla para continuar a limpeza
pause >nul
ping -n 2 0.0.0.0 >nul
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
cls

:Logs
echo Limpando logs e tmp adicionais
echo.
ping -n 2 0.0.0.0 >nul
del /q/s "%SystemRoot%\*.TMP"
del /q/s "%SystemRoot%\*.LOG"
cls

:ARQUIVTEMPS
echo Limpando arquivos temporarios do sistema
echo.
ping -n 2 0.0.0.0 >nul
del /q/s/a:r "%TMP%"
del /q/s/a:a "%TMP%"
del /q/s/a:h "%TMP%"
Rmdir /q/s "%TMP%"
md "%TMP%"
del /q/s/a:r "%TEMP%"
del /q/s/a:a "%TEMP%"
del /q/s/a:h "%TEMP%"
Rmdir /q/s "%TEMP%"
md "%TEMP%"
cls

:crash-Dump
echo Limpando crash-Dump do Sistema
echo.
ping -n 2 0.0.0.0 >nul
del /q/s "%SystemRoot%\Minidump"
cls

:SQM-Messenger
echo Limpando SQM-Messenger logs
echo.
ping -n 2 0.0.0.0 >nul
del /q/s "%homedrive%\*.SQM"

:CLERNMGR
echo Executando limpeza CLEANMGR avançada
echo Por favor , aguarde até o seu terminio
echo.
ping -n 2 0.0.0.0 >nul
CLEANMGR.EXE /Sagerun:1
cleanmgr.exe /sagerun:n
cls

:WINDOWSUPDATEUNINSTALLSBKP
echo Limpando bkps do Windows Update
echo.
ping -n 2 0.0.0.0 >nul
set Pasta=%SystemRoot%\$NtUninstall*
if exist %Pasta% (
for /f "Tokens=*" %%i in ('dir /B /AD %Pasta%') do rd /s /q "%SystemRoot%\%%i"
goto:eof
)

exit

::---------------------------

:2
:BOOT
echo Melhorando BOOT do sistema
echo.
ping -n 2 0.0.0.0 >nul
cd\
del c:\windows\prefetch\*.* /q
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 2 /f
reg add "HKLM\Software\Microsoft\Drfg\BootOptimizeFunction" /v Enable /t REG_SZ /d Y /f
cls

:TEMPWINRAR
echo Limpando arquivos temporarios do WinRar
echo.
ping -n 2 0.0.0.0 >nul
reg delete HKCU\Software\WinRAR\ArcHistory /f /va
@echo Windows Registry Editor Version 5.00>%TEMP%\03.reg
@echo [HKEY_CURRENT_USER\Software\WinRAR\ArcHistory]>>%TEMP%\03.reg 
@echo "1"="">>%TEMP%\03.reg 
@echo "2"="">>%TEMP%\03.reg 
@echo "3"="">>%TEMP%\03.reg 
@echo "4"="">>%TEMP%\03.reg 
regedit /s %TEMP%\03.reg
cls

:EXECUTARWINDOWS
echo Limpando cache do executar do explorer
echo.
ping -n 2 0.0.0.0 >nul
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /f /va
@echo off 
@echo Windows Registry Editor Version 5.00>%TEMP%\01.reg 
@echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU]>>%TEMP%\01.reg 
@echo "MRUList"="vjkuctsrbgqponmlihefda">>%TEMP%\01.reg 
regedit /s %TEMP%\01.reg
cls

:CONTASMSN
echo Limpando arquivos temporarios de contas do MSN
echo.
ping -n 2 0.0.0.0 >nul
reg delete HKCU\Software\Microsoft\IdentityCRL\Creds /f /va
@echo off 
@echo Windows Registry Editor Version 5.00>%TEMP%\02.reg 
@echo [HKEY_CURRENT_USER\Software\Microsoft\IdentityCRL\Creds]>>%TEMP%\02.reg 
regedit /s %TEMP%\02.reg
cls

:PREFETCH
echo Limpando prefetch
echo.
ping -n 2 0.0.0.0 >nul
del /q/s/a:a "%SystemRoot%\Prefetch"
cls

:COOKIESIE
echo Limpando cookies do Internet Explorer
echo.
ping -n 2 0.0.0.0 >nul
del /q/s/a:r "%userprofile%\Cookies"
del /q/s/a:a "%userprofile%\Cookies"
del /q/s/a:h "%userprofile%\Cookies"
del /q/s "%userprofile%\Cookies\index.dat" > NUL
cls

:ARQUIVTEMPIE
echo Limpando Arquivos Temporarios do Internet Explorer
echo.
ping -n 2 0.0.0.0 >nul
del /q/s/a:r "%userprofile%\Config~1\Temporary Internet Files"
del /q/s/a:a "%userprofile%\Config~1\Temporary Internet Files"
del /q/s/a:h "%userprofile%\Config~1\Temporary Internet Files"
del /q/s "%userprofile%\Configurações locais\Temporary Internet Files\Content.IE5\index.dat" > NUL
cls

:HISTORICOIE
echo Limpando Hist¢rico do Internet Explorer
echo.
ping -n 2 0.0.0.0 >nul
del /q/s "%userprofile%\Config~1\Histórico\History.IE5\index.dat" > NUL
del /q/s/a:r "%userprofile%\Config~1\Histórico"
del /q/s/a:a "%userprofile%\Config~1\Histórico"
del /q/s/a:h "%userprofile%\Config~1\Histórico"
Rmdir  /q "%userprofile%\Config~1\Histórico"
cls

:ARQUIVRECENTEIE
echo Limpando cache de arquivos recentes do Internet Explorer
echo.
ping -n 2 0.0.0.0 >nul
del /q/s "%userprofile%\Recent"
del /q/s "%userprofile%\Config~1\Histórico\History.IE5\index.dat" > NUL
Rmdir /q/s "%userprofile%\Config~1\Temporary Internet Files\Content.IE5"  > NUL
Rmdir /q "%userprofile%\Config~1\Histórico\History.IE5" > NUL
cls

:HF_MIG
echo Limpando cache do Windows Update
echo.
ping -n 2 0.0.0.0 >nul
del /s /q "%windir%\$hf_mig$\*.*"
cls

:REPAIR
echo Limpando cache de reparação de sistema do Windows (repair)
echo.
ping -n 2 0.0.0.0 >nul
del /s /q "%windir%\repair\*.*"
cls

:DLLCACHE
echo Limpando cache de DLL's do Windows (dllcache)
echo.
ping -n 2 0.0.0.0 >nul
del /s /q "%windir%\system32\dllcache\*.*"
cls

:NVIDIACACHE
echo Limpando cache de drivers NVIDIA (Se existir)
echo.
ping -n 2 0.0.0.0 >nul
if exist %systemdrive%\NVIDIA (rd /q %systemdrive%\NVIDIA)
cls

:menuzin2
echo Seu sistema ja foi optimizado com a limpeza basica.
echo Por‚m, vocˆ ainda pode executar as ferramentas
echo de limpeza adicionais.
echo.
echo Os ajustes deste ponto em diante , podem levar
echo um pouco mais de tempo, deseja continuar? [s/n]
set /p opc=""
if %opc% == s (goto :1)
if %opc% == n (exit)
goto:menuzin2
