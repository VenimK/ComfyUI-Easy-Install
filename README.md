# ComfyUI-Easy-Install  
One-click portable installation of ComfyUI for Windows 🔹 Pixaroma Community Edition 🔹  

> Dedicated to the **Pixaroma** team. [Discord Channel](https://discord.com/invite/gggpkVgBf3)  

---

## Included Core Modules  
- **Git**  
- **ComfyUI portable**  

## Included Pixaroma-Related Nodes  
- ComfyUI-Manager  
- was-node-suite  
- Easy-Use  
- controlnet_aux  
- Comfyroll Studio  
- Crystools  
- rgthree  
- GGUF  
- Florence2  
- Searge_LLM  
- ControlAltAI-Nodes  
- Ollama  
- iTools  
- seamless-tiling  
- Inpaint-CropAndStitch  
- canvas_tab  
- OmniGen  
- Inspyrenet-Rembg  
- AdvancedReduxControl  
- VideoHelperSuite  
- AdvancedLivePortrait  
- ComfyUI-ToSVG  
- Kokoro  
- Janus-Pro  
- Sonic  
- TeaCache  
- KayTool  

---

## Installation Steps:  

1. Download the latest release from [HERE](https://github.com/Tavris1/ComfyUI-Easy-Install/releases/latest/download/ComfyUI-Easy-Install.zip).  
2. Extract the ZIP file to your desired folder.  
**DO NOT** use system folders like **`Program Files`**, **`Windows`** or system root **`C:\`**  
3. Run **`"ComfyUI-Easy-Install.bat"`**  
   or **`"ComfyUI-Easy-Install for RTX 50x.bat"`**  if you have 5060, 5070, 5080 or 5090 GPU
  - After installation, you can rename or move **`"ComfyUI-Easy-Install"`** folder if needed.  
  - This installation does not affect existing ComfyUI installations in any way.  
  This way you can have multiple installations in different folders.  

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

### Latest News:  

**⚠️ Warning!** If three of the nodes fail to load after the latest ComfyUI update, run this cmd in the `python_embeded` folder:   
```bash
.\python.exe -m pip uninstall xformers
```  

- Added Stable PyTorch v2.7.0 with CUDA 12.8. Stable Support for all kind of nvidia GPUs, incl. 50x series
- Added support for SageAttention. 
  - Add **`--use-sage-attention`** to **`run_nvidia_gpu.bat`** file to enable it  
- Added support for RTX 5070, 5080, and 5090 (Blackwell) GPUs using the nightly version of PyTorch.
- Completely rewritten installation process  
- 30% Faster Installation
- Eliminated dependency on 7zip  
- Clearing the Pip Cache  
- Two new files have been added to **`run_nvidia_gpu.bat`**:  
      - **`Update All and RUN.bat`** – Updates ComfyUI and its nodes and starts it  
      - **`Update Comfy and RUN.bat`** – Updates only ComfyUI and starts it  

---

## Screenshots  
![End](https://github.com/user-attachments/assets/da090bd5-0e13-41e1-8a81-bf2d24a8632c)  

[![Support me on-Paypal-blue](https://github.com/user-attachments/assets/a5fd6af1-5842-4c62-9e07-b021b5dc52fd)](https://paypal.me/tavris1)  
