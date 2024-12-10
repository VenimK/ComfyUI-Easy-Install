# ComfyUI-Easy-Install

> Dedicated to the **Pixaroma** team. [Discord Channel](https://discord.com/invite/gggpkVgBf3)

## Overview  
**ComfyUI-Easy-Install** offers a portable Windows version of ComfyUI, complete with essential nodes included.  
It’s perfect for safely testing nodes or setting up a fresh instance of ComfyUI.  

---

## Key Features  

### Installation Modules  
- Automatically installs or updates:  
  - **7-Zip**  
  - **Git**  
- Deploys **ComfyUI portable + Manager**.

### Pre-Installed Nodes  
**Main Nodes:**  
- Crystools  
- rgthree  
- Easy-Use  
- was-node-suite  
- GGUF  

**Pixaroma-Related Nodes:**  
- iTools  
- controlnet_aux  
- ControlAltAI-Nodes  
- Florence2  
- Searge_LLM  
- seamless-tiling  
- Inpaint-CropAndStitch  
- canvas_tab  
- OmniGen  
- Inspyrenet-Rembg  
- AdvancedReduxControl  
- VideoHelperSuite  

---

## Installation Guide  

### Steps:  
1. Download the latest release of [ComfyUI-Easy-Install](https://github.com/Tavris1/ComfyUI-Easy-Install/releases/latest/download/ComfyUI-Easy-Install.zip).  
2. Extract the ZIP file to your desired folder.  
3. Run **ComfyUI-Easy-Install.bat**.  

### Tips for Existing Installations:  
- To keep your settings intact, place the following files in the same folder as the installer:  
  - `run_nvidia_gpu.bat`  
  - `extra_model_paths.yaml`  
  - `comfy.settings.json` (user/default)  
  - `config.ini` (Manager)  
  - `styles.json` (was-node-suite)  
  - `was_suite_config.json` (was-node-suite)  
  - `rgthree_config.json`  

### Avoiding Conflicts:  
- If another **ComfyUI_windows_portable** folder is detected, the installer will stop to prevent overwriting.  
  - Move the installer to a different folder and rerun it.  
- After installation, you can rename or relocate the **ComfyUI_windows_portable** folder as needed.  

---

## Extra Model Paths Maker 🔥  

### How to Use:  
1. Place **Extra_Model_Paths_Maker.bat** in your shared **models** directory and run it.  
   - This generates an organized `extra_model_paths.yaml` listing all subfolders in the directory.  
2. Move `extra_model_paths.yaml` to your new **ComfyUI** folder.  
   - This allows ComfyUI to use your existing models without requiring additional downloads.  

> **Note**: Directories like **LLM** and **llm_gguf** cannot be redirected with this method.  

---

## Screenshot  
![ComfyUI-Easy-Install](https://github.com/user-attachments/assets/9032aff4-f277-4269-91de-b50400a659b5)
