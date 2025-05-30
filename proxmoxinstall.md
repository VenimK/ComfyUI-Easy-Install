<div align="center">

# 🚀 Proxmox ComfyUI Installation Guide

### Complete guide for setting up ComfyUI with NVIDIA GPU support on Proxmox

[![ComfyUI](https://img.shields.io/badge/ComfyUI-Stable_Diffusion-blue?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAAdgAAAHYBTnsmCAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAADSSURBVDiNrdKxSgNBFIXhb9BtRLAIKIiVYGFhYeELiI2VL2Bh4wtYWfkSFhYWgpWVhYVgYWGhIhYWIiIiImJEUNkYSFxi3M3usmcYmMuc/50z9xbUcYEH3GAVyzjFI27RxgRW8IwzjGMNp3jCHaawjgc0MYsNPOMUE1jBHu7RwCy2cI8bjGEZh7jGNWaxgyucYwKL2McVzjCFTRyjgwWs4ghtXGISG/iNxAF+4AufsYxhHj/xG5+RvBSJv/ET75G8EEP4wHt0X4rkYfzDW3RfiuS5X+w5udAqJg8lAAAAAElFTkSuQmCC)](https://github.com/comfyanonymous/ComfyUI)
[![Proxmox](https://img.shields.io/badge/Proxmox-Virtual_Environment-orange?style=for-the-badge&logo=proxmox)](https://www.proxmox.com/)
[![NVIDIA](https://img.shields.io/badge/NVIDIA-GPU_Support-brightgreen?style=for-the-badge&logo=nvidia)](https://www.nvidia.com/)
[![Pixaroma](https://img.shields.io/badge/Pixaroma-AI_Art_Community-purple?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsTAAALEwEAmpwYAAABP0lEQVQ4jY2TsUrDUBSGv5OhQ4c+QKEv0EcQHPIAncShu5vg4pBFxMHFwUFwcHBwEHFwEHHIkEWKQwZxyCCFDiIiUggUQZDSz+FcuGnTpPaDw7n3/uf/z7lJLgQRGQP3wDXQBy6Ac+BVRH5s7FBEYhFZich3DisiMheR2D5E5FREUhHJRGTmkTIRSa0+FZGTf3tQ1/UjMAEeXG0CvHjNl8AYeKvreuZmPQBSSqkDd8DMNZ8BH8AhcAVcAmfAR13XM2vtF7AH7Ko8z9dJkrwDbWttCUwBa4xtSimltm3bz+12+9FaW7rGxPf+1/5gjHkDhsaYfWPMgTFm6HnvQRC8dF1XeXEURZHvfZqm6aK3CkAQBGMgBhb+bEVRzKIoivM8f+77/hF4AvZc8/q4/oVt/AT4AabALXADfAI/wC9kz4wR1Qf3OAAAAABJRU5ErkJggg==)](https://pixaroma.art)

---

</div>

## 📋 Table of Contents

1. [🛠️ Fix Storage (if needed)](#1-fix-storage-if-needed)
2. [🖥️ Proxmox Host Preparation](#2-proxmox-host-preparation)
3. [📦 Container Setup](#3-container-setup)
4. [🎨 ComfyUI Installation](#4-comfyui-installation)
5. [🚀 Running ComfyUI](#5-running-comfyui)
6. [🔧 Troubleshooting](#6-troubleshooting)
7. [🔄 Maintenance](#7-maintenance)

---

## 1. 🛠️ Fix Storage if needed

<details>
<summary>Click to expand storage configuration steps</summary>

> 🎥 **Video Guides**:
https://youtu.be/_u8qTN3cCnQ?si=jtQ-zHKzAUoKvjRC&t=899
https://youtu.be/_u8qTN3cCnQ?si=PBvabV3ARh_c71xY&t=1236


## 2. 🖥️ Proxmox Host Preparation

### Initial Setup

Login to your Proxmox Host Machine

Go to a client machine and input your IP address in in the above instance that would be https://192.168.1.213:8006 and enter root for your username and whatever password you entered. move past the nag screen.

Initial Proxmox Configuration

You MUST do this before the rest of the steps below of you will not have a successful install of the drivers that will survive updates of the Kernel in Proxmox.

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-005.jpg

Click the hostname (pve likely on the left hand side) and then repositories. Disable the “enterprise” repos. Add a repo. Add no-subscription. Click refresh and then update. Apply the updates.

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-006.jpg

It will need a reboot after this step.

Install NVIDIA Driver on Proxmox Host

First you need to update the Proxmox Host system. Please follow all these steps in this order or you will have to rerun the initramfs install portion later after you have a new kernel installed from proxmox. I do NOT recommend installing from the debian sources as that is an older version of the nvidia driver which can and will have issues with some newer cards and can and will have lower performance.

apt update && apt upgrade -y && apt install pve-headers-$(uname -r) build-essential software-properties-common make nvtop htop gcc cmake -y
update-initramfs -u

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-007.jpg

reboot now

Next visit the nvidia unix drivers archive page here: https://www.nvidia.com/en-us/drivers/unix/ and click the Latest Production Branch Version: XXXXXX link.
https://digitalspaceport.com/wp-content/uploads/2025/03/Screenshot-2025-03-23-000532.png

This will take you to that drivers page. Hover the Download button and right click, copy link.

https://digitalspaceport.com/wp-content/uploads/2025/03/Screenshot-2025-03-23-000845.png

Return to your proxmox HOST terminal and type wget then paste in the link. Hit enter. It will download that file to your location in your proxmox HOST machine.

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-008.jpg

Now type ls and view the name of the downloaded file. It should start with NVIDIA-blah-blah.run essentially.

Type chmod +x NV* and hit enter. You can now execute this installer.

To execute the installer type the following: ./NV* --dkms

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-009.jpg

You will get a popup and be presented options. Follow the video selection and choose Nvidia Proprietary. Do not worry about X (that is a desktop in linux land) and the 32 bit warnings. It will warn you about modprobe and headers. Click install those. If it demands a restart first, let it restart. It SHOULD.

When it is rebooted come back and rerun the ./NV* –dkms installation again and it will finish this time. Run nvtop to display the GPUs on the host terminal.

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-010.jpg

## 3. 📦 Container Setup

> 💡 **Tip**: Choose Debian 12 for better stability and compatibility with AI workloads

### 3.1 📥 Download Container Templates

> 🔄 **Choose Your Base**: Select either Debian 12 (recommended) or Ubuntu 22.04
First, download the container templates from the Proxmox web interface:
1. Go to your node (e.g., 'pve')
2. Select 'Shell'
3. Run these commands:

```bash
# For Debian 12
pveam download local debian-12-standard_12.2-1_amd64.tar.gz

# For Ubuntu 22.04
pveam download local ubuntu-22.04-standard_22.04-1_amd64.tar.gz
```

### 3.2 🏗️ Create LXC Container

> ⚙️ **Container Configuration**: Adjust resources based on your needs

#### Option 1: Using Debian 12 (Recommended)
```bash
pct create 100 local:vztmpl/debian-12-standard_12.2-1_amd64.tar.gz \
  --hostname comfyui \
  --cores 4 \
  --memory 16384 \
  --swap 8192 \
  --rootfs local-lvm:100 \
  --net0 name=eth0,bridge=vmbr0,ip=dhcp \
  --ostype debian \
  --password yourpassword \
  --unprivileged 0
```

#### Option 2: Using Ubuntu 22.04
```bash
pct create 100 local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.gz \
  --hostname comfyui \
  --cores 4 \
  --memory 16384 \
  --swap 8192 \
  --rootfs local-lvm:100 \
  --net0 name=eth0,bridge=vmbr0,ip=dhcp \
  --ostype ubuntu \
  --password yourpassword \
  --unprivileged 0
```

### 3.3 🔌 Start and Test Container

> ✅ **Verification**: Ensure everything is working properly
```bash
# Start the container
pct start 100

# Check status
pct status 100

# Enter container
pct enter 100

# Test network (inside container)
ping -c 4 8.8.8.8
```

### 3.4 🛠️ Initial Container Setup

> 📦 **Base Setup**: Install essential utilities and updates
```bash
# Enter container
pct enter 100

# Update system
apt update && apt upgrade -y

# Install basic utilities
apt install -y curl wget git htop nano nvtop
```



### 3.5 🎮 Enable NVIDIA GPU in Container

> ⚠️ **Important**: Follow these steps carefully to ensure proper GPU passthrough

Take note of the container number ID. In the host terminal still type ls -la. It will print the full name of the nvidia driver. It may look something like this: NVIDIA-Linux-x86_64-570.133.07.run

Type the following: pct push 100 NVIDIA-Linux-x86_64-570.133.07.run /root/NVIDIA-Linux-x86_64-570.133.07.run
Enter the LXC container: pct enter 100

Grant exec privilege inside the container: chmod +x NVIDIA-Linux-x86_64-570.133.07.run

Install with flags: ./NV* –-no-kernel-modules

Type: shutdown now after it completeshttps://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-024.jpg

Passthrough GPU/s to the LXC container

In the proxmox HOST terminal type: ls -la /dev/nvidia* and it will print your devices. They will read something like this:

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-025.jpg


On my own system it was:

ls -l /dev/nvidia*
crw-rw-rw- 1 root root 195,   0 May 29 19:19 /dev/nvidia0
crw-rw-rw- 1 root root 195, 255 May 29 19:19 /dev/nvidiactl
crw-rw-rw- 1 root root 234,   0 May 29 19:19 /dev/nvidia-uvm
crw-rw-rw- 1 root root 234,   1 May 29 19:19 /dev/nvidia-uvm-tools

/dev/nvidia-caps:
total 0
cr-------- 1 root root 237, 1 May 29 19:19 nvidia-cap1
cr--r--r-- 1 root root 237, 2 May 29 19:19 nvidia-cap2

Add to `/etc/pve/lxc/100.conf`:
```
lxc.cgroup2.devices.allow: c 195:* rwm
lxc.cgroup2.devices.allow: c 234:* rwm
lxc.cgroup2.devices.allow: c 237:* rwm
lxc.mount.entry: /dev/nvidia0 dev/nvidia0 none bind,optional,create=file
lxc.mount.entry: /dev/nvidiactl dev/nvidiactl none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-modeset dev/nvidia-modeset none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm dev/nvidia-uvm none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm-tools dev/nvidia-uvm-tools none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-caps/nvidia-cap1 dev/nvidia-caps/nvidia-cap1 none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-caps/nvidia-cap2 dev/nvidia-caps/nvidia-cap2 none bind,optional,create=file
```

Enable GPU Passthrough Reboot Persistence

Now we need to create a crontab that will fire at reboot so the LXC container can properly pick up the GPUs from the host system even after restarts and reboots. On the HOST terminal type: crontab -e it will as you if you want to use 1) nano select that as yes. Then it will open the file. Press enter to create a space at the top and then type in @reboot nvidia-smi and save the file.

https://digitalspaceport.com/wp-content/uploads/2025/03/proxmox-ollama-openwebui-ai-server-031.jpg

### 3.6 💾 Mount NVMe Drive

> 💡 **Note**: This step is crucial for storing your models and outputs
```bash
# Format NVMe if needed
mkfs.ext4 /dev/nvme0n1p1

# Mount in host
mkdir -p /mnt/models
mount /dev/nvme0n1p1 /mnt/models

# Add to container config
./setup_ct_mount.sh
```

## 4. 🎨 ComfyUI Installation

> 🌟 **Pro Tip**: Make sure your GPU is properly recognized before proceeding

### 4.1 📦 Install Dependencies

> 🔧 **Required Packages**: These are essential for running ComfyUI
```bash
pct enter 100
apt update && apt install -y python3-pip python3-venv git wget curl
```

### 4.2 Install ComfyUI
```bash
cd /opt
git clone https://github.com/Tavris1/ComfyUI-Easy-Install.git
cd ComfyUI-Easy-Install
chmod +x ComfyUI-Easy-Install-Linux.sh
./ComfyUI-Easy-Install-Linux.sh --proxmox
```

### 4.3 Configure Model Paths
```bash
cd /mnt/models
chmod +x Extra_Model_Paths_Maker.sh
./Extra_Model_Paths_Maker.sh
cp extra_model_paths.yaml /opt/ComfyUI-Easy-Install/ComfyUI/
```

## 5. 🚀 Running ComfyUI

> 🌐 **Access**: ComfyUI will be available at `http://your-proxmox-ip:8188`

### 5.1 Start ComfyUI
```bash
cd /opt/ComfyUI-Easy-Install/ComfyUI
./run_comfyui.sh --listen 0.0.0.0 --port 8188
```

### 5.2 Access Web Interface
Open in browser:
```
http://your-proxmox-ip:8188
```

## 6. 🔧 Troubleshooting

> 🔍 **Common Issues and Solutions**

### 6.1 Check NVIDIA Status
```bash
nvidia-smi
```

### 6.2 Check Container Mounts
```bash
pct enter 100
df -h
```

### 6.3 Check GPU Access
```bash
python3 -c "import torch; print(torch.cuda.is_available())"
```

### 6.4 Common Issues
- If CUDA is not found: Verify NVIDIA driver installation
- If models aren't visible: Check mount points and permissions
- If web interface is inaccessible: Check firewall settings

## 7. 🔄 Maintenance

> ⚡ **Keep your system up to date**

### 7.1 Update ComfyUI
```bash
cd /opt/ComfyUI-Easy-Install/ComfyUI
git pull
```

### 7.2 Update Custom Nodes
```bash
cd /opt/ComfyUI-Easy-Install
./update_custom_nodes.sh
```
