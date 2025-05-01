#!/bin/bash
# ComfyUI Easy Install by ivo - macOS ARM version
# Adapted from the Windows version v0.44.3 (Ep44)
# Pixaroma Community Edition

# Set colors
warning="\033[33m"
red="\033[91m"
green="\033[92m"
yellow="\033[93m"
bold="\033[1m"
reset="\033[0m"

# Set No Warnings
silent="--no-cache-dir --no-warn-script-location"

# Capture the start time
start=$(date +%H:%M:%S)

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
    echo -e "${warning}WARNING:${reset} The installer was run with ${bold}Administrator privileges${reset}."
    echo -e "Please run it with ${green}Standard user permissions${reset} (without Admin rights)."
    echo "Press any key to Exit..."
    read -n 1
    exit 1
fi

# Check for Existing ComfyUI Folder
if [ -d "ComfyUI-Easy-Install" ]; then
    echo -e "${warning}WARNING:${reset} '${bold}ComfyUI-Easy-Install${reset}' folder already exists!"
    echo -e "${green}Move this file to another folder and run it again.${reset}"
    echo "Press any key to Exit..."
    read -n 1
    exit 1
fi

# Check for Existing Helper-CEI.zip
if [ ! -f "Helper-CEI.zip" ]; then
    echo -e "${warning}WARNING:${reset} '${bold}Helper-CEI.zip${reset}' does not exist!"
    echo -e "${green}Unzip the entire package and try again.${reset}"
    echo "Press any key to Exit..."
    read -n 1
    exit 1
fi

# Clear Pip Cache
if [ -d "$HOME/Library/Caches/pip" ]; then
    rm -rf "$HOME/Library/Caches/pip"
    mkdir -p "$HOME/Library/Caches/pip"
fi
echo -e "${green}::::::::::::::: Clearing Pip Cache ${reset}${yellow}Done${reset}${green} ::::::::::::::${reset}"
echo

# Install/Update Git
install_git() {
    echo -e "${green}::::::::::::::: Installing/Updating Git ::::::::::::::${reset}"
    echo
    if ! command -v git &> /dev/null; then
        echo -e "${yellow}Git not found. Installing via Homebrew...${reset}"
        if ! command -v brew &> /dev/null; then
            echo -e "${yellow}Homebrew not found. Installing Homebrew...${reset}"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install git
    else
        echo -e "${yellow}Git is already installed. Updating...${reset}"
        brew upgrade git || echo -e "${yellow}Git is up to date${reset}"
    fi
    echo
}

# Install Git
install_git

# Check if git is installed
if command -v git &> /dev/null; then
    gitversion=$(git --version)
    echo -e "${bold}git${reset} ${yellow}is installed${reset}: $gitversion"
    echo
else
    echo -e "${warning}WARNING:${reset} ${bold}'git'${reset} is NOT installed"
    echo -e "Please install ${bold}'git'${reset} manually from ${yellow}https://git-scm.com/${reset} and run this installer again"
    echo "Press any key to Exit..."
    read -n 1
    exit 1
fi

# Create directory
mkdir -p ComfyUI-Easy-Install
if [ ! -d "ComfyUI-Easy-Install" ]; then
    echo -e "${warning}WARNING:${reset} Cannot create folder ${yellow}ComfyUI-Easy-Install${reset}"
    echo -e "Make sure you are NOT using system folders or folders with restricted permissions"
    echo -e "${green}Move this file to another folder and run it again.${reset}"
    echo "Press any key to Exit..."
    read -n 1
    exit 1
fi
cd ComfyUI-Easy-Install

# Install ComfyUI
install_comfyui() {
    echo -e "${green}::::::::::::::: Installing ComfyUI ::::::::::::::${reset}"
    echo
    git clone https://github.com/comfyanonymous/ComfyUI ComfyUI
    
    # Setup Python environment
    echo -e "${yellow}Setting up Python environment...${reset}"
    python_version="3.11.9"
    
    # Check if Python is installed
    if ! command -v python3 &> /dev/null; then
        echo -e "${yellow}Python not found. Installing via Homebrew...${reset}"
        brew install python@3.11
    fi
    
    # Create virtual environment with Python 3.11 if available
    if command -v python3.11 &> /dev/null; then
        python3.11 -m venv python_embedded
    else
        python3 -m venv python_embedded
    fi
    source python_embedded/bin/activate
    
    # Ensure pip is up to date
    python -m pip install --upgrade pip $silent
    
    # Install pip and dependencies
    python -m pip install --upgrade pip $silent
    
    # Install PyTorch for M1/M2 Macs
    python -m pip install torch torchvision torchaudio $silent
    
    python -m pip install pygit2 $silent
    
    # Install ComfyUI requirements
    cd ComfyUI
    python -m pip install -r requirements.txt $silent
    cd ..
    echo
}

# Function to get custom nodes
get_node() {
    local git_url=$1
    local git_folder=$(basename $git_url)
    echo -e "${green}::::::::::::::: Installing $git_folder ::::::::::::::${reset}"
    echo
    
    git clone $git_url ComfyUI/custom_nodes/$git_folder
    
    if [ -f "./ComfyUI/custom_nodes/$git_folder/requirements.txt" ]; then
        source python_embedded/bin/activate
        python -m pip install -r ./ComfyUI/custom_nodes/$git_folder/requirements.txt $silent
    fi
    
    if [ -f "./ComfyUI/custom_nodes/$git_folder/install.py" ]; then
        source python_embedded/bin/activate
        python ./ComfyUI/custom_nodes/$git_folder/install.py
    fi
    
    echo
}

# Function to copy files
copy_files() {
    if [ -f "../$1" ] && [ -d "./$2" ]; then
        cp "../$1" "./$2/"
    fi
}

# Install ComfyUI
install_comfyui

# Install Pixaroma's Related Nodes
get_node https://github.com/ltdrdata/ComfyUI-Manager
get_node https://github.com/WASasquatch/was-node-suite-comfyui
get_node https://github.com/yolain/ComfyUI-Easy-Use
get_node https://github.com/Fannovel16/comfyui_controlnet_aux
get_node https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes
get_node https://github.com/crystian/ComfyUI-Crystools
get_node https://github.com/rgthree/rgthree-comfy
get_node https://github.com/city96/ComfyUI-GGUF
get_node https://github.com/kijai/ComfyUI-Florence2
get_node https://github.com/SeargeDP/ComfyUI_Searge_LLM
get_node https://github.com/gseth/ControlAltAI-Nodes
get_node https://github.com/stavsap/comfyui-ollama
get_node https://github.com/MohammadAboulEla/ComfyUI-iTools
get_node https://github.com/spinagon/ComfyUI-seamless-tiling
get_node https://github.com/lquesada/ComfyUI-Inpaint-CropAndStitch
get_node https://github.com/Lerc/canvas_tab
get_node https://github.com/1038lab/ComfyUI-OmniGen
get_node https://github.com/john-mnz/ComfyUI-Inspyrenet-Rembg
get_node https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl
get_node https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite
get_node https://github.com/PowerHouseMan/ComfyUI-AdvancedLivePortrait
get_node https://github.com/Yanick112/ComfyUI-ToSVG

# Install pylatexenc for kokoro
source python_embedded/bin/activate
python -m pip install pylatexenc $silent
echo

# Install Rust (needed for some packages)
if ! command -v rustc &> /dev/null; then
    echo -e "${yellow}Installing Rust (needed for some dependencies)...${reset}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

get_node https://github.com/stavsap/comfyui-kokoro
# Fix kokoro installation
cd ComfyUI/custom_nodes/comfyui-kokoro
source ../../../python_embedded/bin/activate
python -m pip install kokoro-onnx $silent
cd ../../..
get_node https://github.com/CY-CHENYUE/ComfyUI-Janus-Pro
get_node https://github.com/smthemex/ComfyUI_Sonic
get_node https://github.com/welltop-cn/ComfyUI-TeaCache
get_node https://github.com/kk8bit/KayTool

# Install onnxruntime for ARM Macs
source python_embedded/bin/activate
python -m pip install onnxruntime-silicon $silent

# Extract 'update' folder
cd ..
unzip -o Helper-CEI.zip
cd ComfyUI-Easy-Install

# Copy additional files if they exist
copy_files run_nvidia_gpu.sh ./
copy_files extra_model_paths.yaml ComfyUI
copy_files comfy.settings.json ComfyUI/user/default
copy_files was_suite_config.json ComfyUI/custom_nodes/was-node-suite-comfyui
copy_files rgthree_config.json ComfyUI/custom_nodes/rgthree-comfy

# Create a run script for macOS
cat > run_comfyui.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
source python_embedded/bin/activate
cd ComfyUI
python main.py
EOF
chmod +x run_comfyui.sh

# Capture the end time
end=$(date +%H:%M:%S)
# Handle time calculation in a more compatible way
if command -v gdate &> /dev/null; then
    # Use gdate if available (from coreutils)
    start_seconds=$(gdate -d "$start" +%s)
    end_seconds=$(gdate -d "$end" +%s)
elif date -j -f "%H:%M:%S" "$start" +%s &> /dev/null; then
    # BSD date (macOS)
    start_seconds=$(date -j -f "%H:%M:%S" "$start" +%s)
    end_seconds=$(date -j -f "%H:%M:%S" "$end" +%s)
else
    # Fallback
    start_seconds=0
    end_seconds=0
fi
diff=$((end_seconds - start_seconds))

# Final Messages
echo
echo -e "${green}::::::::::::::: Installation Complete ::::::::::::::${reset}"
echo -e "${green}::::::::::::::: Total Running Time:${reset}${red} $diff ${reset}${green}seconds${reset}"
echo -e "${yellow}::::::::::::::: To run ComfyUI, use ./run_comfyui.sh ::::::::::::::${reset}"
echo -e "${yellow}::::::::::::::: Press any key to exit ::::::::::::::${reset}"
read -n 1
