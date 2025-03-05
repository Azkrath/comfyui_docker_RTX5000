#!/bin/bash

# Set up ComfyUI if it's not already installed
if [ ! -d "/workspace/ComfyUI/.git" ]; then
    echo "Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI /workspace/ComfyUI
    cd /workspace/ComfyUI

    echo "Installing dependencies..."
    grep -v 'torchaudio\|torchvision' requirements.txt > temp_requirements.txt
    pip install -r temp_requirements.txt
else
    echo "ComfyUI already installed. Skipping setup."
fi

# Step 2: Map external model folders
echo "Mapping external model folders..."

# Models
rm -rf /workspace/ComfyUI/models
ln -s /mnt/models /workspace/ComfyUI/models

# Workflows
rm -rf /workspace/ComfyUI/user/default/workflows
ln -s /mnt/workflows /workspace/ComfyUI/user/default/workflows

# Custom Nodes
rm -rf /workspace/ComfyUI/custom_nodes
ln -s /mnt/custom_nodes /workspace/ComfyUI/custom_nodes

# Output
rm -rf /workspace/ComfyUI/output
ln -s /mnt/output /workspace/ComfyUI/output

# Step 3: Restart the container (Self-Termination Trick)
echo "Stopping container for restart..."
CONTAINER_ID=$(hostname)
docker stop $CONTAINER_ID

# Step 4: Relaunch ComfyUI after restart (This only runs if the container is manually restarted)
echo "Starting ComfyUI..."
cd /workspace/ComfyUI
python main.py --listen