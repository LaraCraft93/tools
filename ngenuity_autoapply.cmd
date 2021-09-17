@echo off
:: Lara Maia <dev@lara.monster> 2021

if not DEFINED minimized set minimized=1 && start "" /min "%~dpnx0" %* && exit 1

(start shell:AppsFolder\33C30B79.HyperXNGenuity_0a78dr3hq0pvt!App) &

:check_window_open
tasklist /fi "WindowTitle eq HyperX NGENUITY" | find "No tasks" >nul 2>&1 && goto check_window_open
taskkill /fi "WindowTitle eq HyperX NGENUITY"
exit 0
