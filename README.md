# ComfyUI-Easy-Install

> Dedicated to the **Pixaroma** team. [Discord Channel](https://discord.com/invite/gggpkVgBf3)

## General Information
ComfyUI-Easy-Install provides a portable Windows version of ComfyUI with basic nodes included.  
It’s ideal for safely testing ComfyUI nodes or quickly setting up a fresh instance.  
Installation typically takes 2-3 minutes, depending on your download speed.

## What ComfyUI-Easy-Install Does
> **Main modules:**
* Installs or updates **7-Zip** (if necessary)
* Installs or updates **Git** (if necessary)
* Installs **ComfyUI portable + Manager**
> **Installs the following Main Nodes:**
* Crystools
* rgthree
* Easy-Use
* was-node-suite
* GGUF
> **Installs additional nodes related to Pixaroma workflows**
* iTools
* controlnet_aux
* ControlAltAI-Nodes
* Florence2
* KJNodes
* tensorops
* Searge_LLM
* Eagleshadow
* Inspyrenet-Rembg
* seamless-tiling

## How to Use
- Download and Extract [ComfyUI-Easy-Install](https://github.com/Tavris1/ComfyUI-Easy-Install/archive/refs/tags/0.1.0.zip) in a folder where ComfyUI will be installed and run 'ComfyUI-Easy-Install.bat'.
  - *Optionally* put your '**extra_model_paths.yaml**', '**styles.json**' (was-node-suite) and **rgthree_config.json**
  next to the installer to be copied to '**ComfyUI**' folders.
- If another '**ComfyUI_windows_portable**' folder is found, the Installer will **stop** to avoid conflicts.
  - Simply relocate the Installer to a different folder and rerun it.
- After installation, you can **move** or **rename** the '**ComfyUI_windows_portable**' folder.

## Screenshots
![Example screenshot](./ComfyUI Easy Install.jpg)
