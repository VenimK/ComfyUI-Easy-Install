#!/bin/bash
cd "$(dirname "$0")"

# Set environment variables for M1 GPU optimization
export PYTORCH_ENABLE_MPS_FALLBACK=1

# Memory optimization settings
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0  # Allow using more GPU memory
export PYTORCH_MPS_LOW_WATERMARK_RATIO=0.7   # Higher threshold for better stability
export PYTORCH_MPS_MINIMUM_MEMORY_WARNINGS=0  # Reduce warning spam
export PYTORCH_MPS_ALLOCATOR_POLICY=garbage_collection  # Enable aggressive GC

# Additional memory optimizations
export PYTORCH_MPS_ALLOCATOR_BLOCK_SIZE=1073741824  # 1GB blocks for better memory management

# Additional performance optimizations
export TORCH_MPS_PLEASE_CACHE_DESCRIPTORS=1   # Improve descriptor caching
export PYTORCH_MPS_ENABLE_GRAPH_MODE=1       # Enable graph mode for better performance

# Enable unified memory for better memory management
export PYTORCH_MPS_ENABLE_UNIFIED_MEMORY=1
export PYTORCH_MPS_ENABLE_GUARD_IMPLEMENTATION=1

# ComfyUI specific optimizations
export COMFYUI_USE_MPS=1
export COMFYUI_VRAM_OPTIMIZATIONS=MPS
export COMFYUI_FORCE_MPS=1

# Data type compatibility fixes
export PYTORCH_MPS_USE_FP32_ACCUM=1  # Use FP32 for accumulation to improve precision
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:32  # Limit memory splits
export PYTORCH_FLOAT8_DISABLED=1  # Disable Float8 which is not supported on MPS
export PYTORCH_PREFER_FLOAT32=1  # Prefer float32 over unsupported types

source python_embedded/bin/activate
cd ComfyUI
python main.py --force-upcast-attention
