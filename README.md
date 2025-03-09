# ComfyUI-Easy-Install  
One-click portable installation of ComfyUI for Windows 🔹 Pixaroma Community Edition 🔹  

> Dedicated to the **Pixaroma** team. [Discord Channel](https://discord.com/invite/gggpkVgBf3)  

---

## Included Core Modules  
- **Git**  
- **ComfyUI portable**  
- **ComfyUI-Manager**  

## Included Pixaroma-Related Nodes  
- Crystools  
- rgthree  
- Easy-Use  
- was-node-suite  
- GGUF  
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
- AdvancedLivePortrait  
- Kokoro  
- Janus-Pro  

---

## Installation Steps:  

1. Download the latest release from [HERE](https://github.com/Tavris1/ComfyUI-Easy-Install/releases/latest/download/ComfyUI-Easy-Install.zip).  
2. Extract the ZIP file to your desired folder.  
**DO NOT** use system folders like **`Program Files`**, **`Windows`** or system root **`C:\`**  
3. Run **ComfyUI-Easy-Install.bat**.  
- After installation, you can rename or move **ComfyUI_windows_portable** folder if needed.  

## Tips for Existing Installations:  
- To preserve settings from other ComfyUI installations, place the following files in the same folder as the installer.  
They will be copied automatically to the appropriate folders:  
      - `run_nvidia_gpu.bat`  
      - `extra_model_paths.yaml` (refer to **Extra Model Paths Maker 🔥**)  
      - `comfy.settings.json` (user/default)  
      - `was_suite_config.json` (custom_nodes/was-node-suite-comfyui)  
      - `rgthree_config.json` (custom_nodes/rgthree-comfy)  

---

## Extra Model Paths Maker 🔥  

### How to Use:  
1. Place **Extra_Model_Paths_Maker.bat** in your existing **models** folder and run it.  
       - This generates an organized `extra_model_paths.yaml` listing all subfolders in the directory.  
2. Move `extra_model_paths.yaml` to your new **ComfyUI** folder.  
       - This allows ComfyUI to use your existing model files without additional downloads.  

> **Note**: Some folders like **LLM** and **llm_gguf** cannot be redirected this way.  

---

## v0.37.0 (Ep37)  

### What's New:  

- Completely rewritten installation process  
- 30% Faster Installation
- Eliminated dependency on 7zip  
- Clearing the Pip Cache  
- Two new files are available alongside **`run_nvidia_gpu.bat`**:  
      - **`Update All and RUN.bat`** – Updates ComfyUI and Nodes, then launches it.  
      - **`Update Comfy and RUN.bat`** – Updates only ComfyUI and launches it.  

---

## Screenshots  
![VideoHelper](https://github.com/user-attachments/assets/473d9acd-3d8d-4c25-acc6-7c2760067382)
![Searge](https://github.com/user-attachments/assets/3e54b80e-1ca7-4fe4-89c2-3d1b2beb7e8a)
![End](https://github.com/user-attachments/assets/da090bd5-0e13-41e1-8a81-bf2d24a8632c)
