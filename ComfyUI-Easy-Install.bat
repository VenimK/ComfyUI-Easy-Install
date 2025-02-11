@echo off
Title ComfyUI Easy Install by ivo v0.33.0 (Ep33)
:: Pixaroma Community Edition ::

:: Set colors ::
call :set_colors

:: Check for Existing ComfyUI Folder ::
if exist ComfyUI_windows_portable (
	echo %warning%WARNING:%reset% '%bold%ComfyUI_windows_portable%reset%' folder already exists!
	echo %green%Move this file to another folder and run it again.%reset%
	echo Press any key to Exit...&Pause>nul
	goto :eof
)

:: Capture the start time ::
for /f %%i in ('powershell -command "Get-Date -Format HH:mm:ss"') do set start=%%i

:: Erase pip cache ::
if exist "%localappdata%\pip\cache" rd /s /q "%localappdata%\pip\cache"

:: Install/Update 7zip, Git and ComfyUI ::
call :install_7zip
call :install_git
call :download_and_install_comfyui

:: Install Pixaroma's Related Nodes ::
call :get_node https://github.com/ltdrdata/ComfyUI-Manager
call :get_node https://github.com/crystian/ComfyUI-Crystools
call :get_node https://github.com/rgthree/rgthree-comfy
call :get_node https://github.com/yolain/ComfyUI-Easy-Use
call :get_node https://github.com/WASasquatch/was-node-suite-comfyui
call :get_node https://github.com/city96/ComfyUI-GGUF
call :get_node https://github.com/MohammadAboulEla/ComfyUI-iTools
call :get_node https://github.com/Fannovel16/comfyui_controlnet_aux
call :get_node https://github.com/gseth/ControlAltAI-Nodes
call :get_node https://github.com/kijai/ComfyUI-Florence2
call :get_node https://github.com/SeargeDP/ComfyUI_Searge_LLM
call :get_node https://github.com/spinagon/ComfyUI-seamless-tiling
call :get_node https://github.com/lquesada/ComfyUI-Inpaint-CropAndStitch
call :get_node https://github.com/Lerc/canvas_tab
call :get_node https://github.com/1038lab/ComfyUI-OmniGen
call :get_node https://github.com/john-mnz/ComfyUI-Inspyrenet-Rembg
call :get_node https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl
call :get_node https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite
call :get_node https://github.com/PowerHouseMan/ComfyUI-AdvancedLivePortrait
call :get_node https://github.com/Yanick112/ComfyUI-ToSVG

:: Install pylatexenc (for kokoro) ::
curl.exe -OL https://www.piwheels.org/simple/pylatexenc/pylatexenc-3.0a32-py3-none-any.whl
.\python_embeded\python.exe -m pip install pylatexenc-3.0a32-py3-none-any.whl
erase pylatexenc-3.0a32-py3-none-any.whl

call :get_node https://github.com/stavsap/comfyui-kokoro

:: Install onnxruntime ::
.\python_embeded\python.exe -m pip install onnxruntime-gpu --no-cache-dir --no-warn-script-location

:: Copy additional files if they exist ::
md ComfyUI\user\default
call :copy_files comfy.settings.json	ComfyUI\user\default
call :copy_files run_nvidia_gpu.bat		.\
call :copy_files extra_model_paths.yaml	ComfyUI
call :copy_files config.ini				ComfyUI\custom_nodes\ComfyUI-Manager
call :copy_files styles.json			ComfyUI\custom_nodes\was-node-suite-comfyui
call :copy_files was_suite_config.json	ComfyUI\custom_nodes\was-node-suite-comfyui
call :copy_files rgthree_config.json	ComfyUI\custom_nodes\rgthree-comfy
call :copy_files lightglue.py			python_embeded\Lib\site-packages\kornia\feature

:: Capture the end time ::
for /f %%i in ('powershell -command "Get-Date -Format HH:mm:ss"') do set end=%%i
for /f %%i in ('powershell -command "(New-TimeSpan -Start (Get-Date '%start%') -End (Get-Date '%end%')).TotalSeconds"') do set diff=%%i

:: Completion Message ::
echo.
echo %green%::::::::::::::: Installation Complete :::::::::::::::%reset%
echo %green%::::::::::::::: Total Running Time:%reset%%red% %diff% %reset%%green%seconds%reset%
echo %yellow%::::::::::::::: Press any key to exit :::::::::::::::%reset%&Pause>nul
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
echo %green%::::::::::::::: Installing/Updating 7-Zip :::::::::::::::%reset%
echo.
winget install -e --id 7zip.7zip
echo.
goto :eof

:install_git
:: https://git-scm.com/
echo %green%::::::::::::::: Installing/Updating Git :::::::::::::::%reset%
echo.
winget install --id Git.Git -e --source winget
for /f "tokens=3*" %%A in ('reg query "HKCU\Environment" /v Path') do set userpath=%%A%%B
echo %path%|find /i "%ProgramFiles%\Git\cmd">nul || setx path "%userpath%;%ProgramFiles%\Git\cmd"
echo %path%|find /i "%ProgramFiles%\Git\cmd">nul || set path=%userpath%;%ProgramFiles%\Git\cmd
echo.
goto :eof

:download_and_install_comfyui
:: https://github.com/comfyanonymous/ComfyUI
echo %green%::::::::::::::: Downloading ComfyUI :::::::::::::::%reset%
echo.
if exist ComfyUI_windows_portable_nvidia.7z erase ComfyUI_windows_portable_nvidia.7z
curl.exe -OL https://github.com/comfyanonymous/ComfyUI/releases/download/v0.2.3/ComfyUI_windows_portable_nvidia.7z

if not exist ComfyUI_windows_portable_nvidia.7z (
	cls
	echo %warning%WARNING:%reset% Cannot create %yellow%ComfyUI_windows_portable_nvidia.7z%reset%
	echo Make sure you are NOT using system folders like %yellow%Program Files, Windows%reset% or system root %yellow%C:\%reset%
	echo %green%Move this file to another folder and run it again.%reset%
	echo Press any key to Exit...&Pause>nul
	exit /b
)

echo %green%::::::::::::::: Extracting ComfyUI :::::::::::::::%reset%
"%ProgramFiles%\7-Zip\7z.exe" x ComfyUI_windows_portable_nvidia.7z
erase ComfyUI_windows_portable_nvidia.7z
echo.
echo %green%::::::::::::::: Updating ComfyUI :::::::::::::::%reset%
echo.
.\ComfyUI_windows_portable\python_embeded\python.exe -m pip uninstall -y torch torchvision torchaudio
.\ComfyUI_windows_portable\python_embeded\python.exe -m pip install --upgrade pip --no-cache-dir --no-warn-script-location
cd .\ComfyUI_windows_portable\python_embeded\
python -m pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 xformers==0.0.29.post2 --extra-index-url https://download.pytorch.org/whl/cu126 --no-cache-dir --no-warn-script-location
cd ..\update\
if exist update_comfyui_and_python_dependencies.bat rename update_comfyui_and_python_dependencies.bat "!DON'T USE THIS! update_comfyui_and_python_dependencies.bat"
CALL update_comfyui.bat nopause
cd ..\..\
echo.
goto :eof

:get_node
set git_url=%~1
for %%x in (%git_url:/= %) do set git_folder=%%x
echo %green%::::::::::::::: Installing %git_folder% :::::::::::::::%reset%
echo.
if exist .\ComfyUI_windows_portable\ComfyUI cd .\ComfyUI_windows_portable
git clone %git_url% ComfyUI/custom_nodes/%git_folder%
if exist .\ComfyUI\custom_nodes\%git_folder%\requirements.txt (
	.\python_embeded\python.exe -m pip install -r .\ComfyUI\custom_nodes\%git_folder%\requirements.txt --no-cache-dir --no-warn-script-location
)
if exist .\ComfyUI\custom_nodes\%git_folder%\install.py (
	.\python_embeded\python.exe .\ComfyUI\custom_nodes\%git_folder%\install.py
)
echo.
goto :eof

:copy_files
if exist ..\%~1 (if exist .\%~2 copy ..\%~1 .\%~2\>nul)
goto :eof
