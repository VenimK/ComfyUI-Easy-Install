@echo off
Title ComfyUI Easy Install by ivo 2024.10.12

:: set colors ::
call :set_colors

:: Check for Existing ComfyUI Folder ::
if exist ComfyUI_windows_portable (
	Echo %warning%WARNING:%reset% '%bold%ComfyUI_windows_portable%reset%' folder already exists!
	Echo %green%Relocate this file to a different folder and rerun it.%reset%
	Echo Press any key to Exit...&Pause>nul
	goto :eof
)

:: Capture the start time ::
for /f %%i in ('powershell -command "Get-Date -Format HH:mm:ss"') do set start=%%i

:: Install/Update 7zip, Git and ComfyUI ::
call :install_7zip
call :install_git
call :download_and_install_copmfyui

:: Install git nodes ::
:: You can add/remove LINES (nodes) here
:: Use the SAME FORMAT - call :get_node url
call :get_node https://github.com/ltdrdata/ComfyUI-Manager
call :get_node https://github.com/crystian/ComfyUI-Crystools
call :get_node https://github.com/rgthree/rgthree-comfy
call :get_node https://github.com/yolain/ComfyUI-Easy-Use
call :get_node https://github.com/WASasquatch/was-node-suite-comfyui
call :get_node https://github.com/city96/ComfyUI-GGUF
call :get_node https://github.com/Fannovel16/comfyui_controlnet_aux
call :get_node https://github.com/gseth/ControlAltAI-Nodes
call :get_node https://github.com/MohammadAboulEla/ComfyUI-iTools
call :get_node https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes
call :get_node https://github.com/sipherxyz/comfyui-art-venture
call :get_node https://github.com/un-seen/comfyui-tensorops
call :get_node https://github.com/SeargeDP/ComfyUI_Searge_LLM
call :get_node https://github.com/Shadetail/ComfyUI_Eagleshadow
call :get_node https://github.com/spinagon/ComfyUI-seamless-tiling
call :get_node https://github.com/john-mnz/ComfyUI-Inspyrenet-Rembg

if exist ..\extra_model_paths.yaml copy ..\extra_model_paths.yaml .\ComfyUI\>nul
if exist ..\styles.json copy ..\styles.json .\ComfyUI\custom_nodes\was-node-suite-comfyui\>nul
if exist ..\config.ini copy ..\config.ini .\ComfyUI\custom_nodes\ComfyUI-Manager\>nul
if exist ..\rgthree_config.json copy ..\rgthree_config.json .\ComfyUI\custom_nodes\rgthree-comfy\>nul
if exist ..\lightglue.py copy ..\lightglue.py .\python_embeded\Lib\site-packages\kornia\feature\>nul

:: Capture the end time ::
for /f %%i in ('powershell -command "Get-Date -Format HH:mm:ss"') do set end=%%i
for /f %%i in ('powershell -command "(New-TimeSpan -Start (Get-Date '%start%') -End (Get-Date '%end%')).TotalSeconds"') do set diff=%%i

:: Completion Message ::
Echo.
Echo %green%::::::::::::::: Installation Complete :::::::::::::::%reset%
Echo %green%::::::::::::::: Total Running Time:%reset%%red% %diff% %reset%%green%seconds%reset%
Echo %yellow%::::::::::::::: Press any key to exit :::::::::::::::%reset%&Pause>nul
goto :eof

::::::::::::::::::::::::::::::::: END :::::::::::::::::::::::::::::::::

:set_colors
set warning=[33m
set     red=[91m
set   green=[92m
set  yellow=[93m
set    bold=[1m
set   reset=[0m
goto :eof

:install_7zip
:: https://www.7-zip.org/
Echo %green%::::::::::::::: Installing/Updating 7-Zip :::::::::::::::%reset%
Echo.
winget install -e --id 7zip.7zip
Echo.
goto :eof

:install_git
:: https://git-scm.com/
Echo %green%::::::::::::::: Installing/Updating Git :::::::::::::::%reset%
Echo.
winget install --id Git.Git -e --source winget
for /f "tokens=3*" %%A in ('reg query "HKCU\Environment" /v Path') do set userpath=%%A%%B
echo %path%|find /i "%ProgramFiles%\Git\cmd">nul || setx path "%userpath%;%ProgramFiles%\Git\cmd"
echo %path%|find /i "%ProgramFiles%\Git\cmd">nul || set path=%userpath%;%ProgramFiles%\Git\cmd
Echo.
goto :eof

:download_and_install_copmfyui
:: https://github.com/comfyanonymous/ComfyUI
Echo %green%::::::::::::::: Downloading ComfyUI :::::::::::::::%reset%
Echo.
if not exist ComfyUI_windows_portable_nvidia.7z (
    curl.exe -OL https://github.com/comfyanonymous/ComfyUI/releases/latest/download/ComfyUI_windows_portable_nvidia.7z
) else (Echo %yellow%ComfyUI_windows_portable_nvidia.7z exist and will be used%reset%)
Echo.
Echo %green%::::::::::::::: Extracting ComfyUI :::::::::::::::%reset%
"%ProgramFiles%\7-Zip\7z.exe" x ComfyUI_windows_portable_nvidia.7z
::???:: erase ComfyUI_windows_portable_nvidia.7z
Echo.
Echo %green%::::::::::::::: Updating ComfyUI :::::::::::::::%reset%
Echo.
cd .\ComfyUI_windows_portable\update\
CALL update_comfyui.bat<nul
cd ..\..\
Echo.
goto :eof

:get_node
set git_url=%~1
for %%x in (%git_url:/= %) do set git_folder=%%x
Echo %green%::::::::::::::: Installing %git_folder% :::::::::::::::%reset%
Echo.
if exist .\ComfyUI_windows_portable\ComfyUI cd .\ComfyUI_windows_portable
git clone %git_url% ComfyUI/custom_nodes/%git_folder%
if exist .\ComfyUI\custom_nodes\%git_folder%\requirements.txt (
	.\python_embeded\python.exe -m pip install --no-warn-script-location -r .\ComfyUI\custom_nodes\%git_folder%\requirements.txt
)
Echo.
goto :eof
