## ComfyUI Docker Setup (WSL2) ##

This repository provides a setup for running ComfyUI using Docker with GPU (Blackwell, 5000 series architecture) support on WSL2.

### Prerequisites ###

Ensure you have the following installed:

* Windows Subsystem for Linux 2 (WSL2) with Ubuntu

* Docker Desktop with WSL2 integration enabled

* NVIDIA GPU with CUDA support

* NVIDIA Container Toolkit

### Setup and Usage ###

**Clone this repository:**
```
git clone https://github.com/Azkrath/comfyui_docker_RTX5000.git
cd comfyui_docker_RTX5000
```
**Move repository to WSL2 file system (Recommended for performance):**

If you are running Windows, it is highly recommended to store the repository inside the WSL2 file system (e.g., under ~/) instead of the Windows-mounted C: drive. Running from NTFS can significantly slow down model loading and checkpoint access.
```
mv /mnt/c/Users/YOUR_USER/comfyui_docker_RTX5000 ~/comfyui_docker_RTX5000
```
**Modify folder paths (if needed):**

The docker-compose.yml file mounts external directories for models, workflows, custom nodes, and output. Update these paths in the file if your folders are located elsewhere:
```
volumes:
  - ~/comfyui_docker_RTX5000/models:/mnt/models
  - ~/comfyui_docker_RTX5000/custom_nodes:/mnt/custom_nodes
  - ~/comfyui_docker_RTX5000/workflows:/mnt/workflows
  - ~/comfyui_docker_RTX5000/output:/mnt/output
```
**Start the container (on the WSL2 file system, through Windows):**
```
docker-compose up -d
```
This will:

* Pull the nvcr.io/nvidia/pytorch:25.01-py3 image.

* Create a container named comfyui-pytorch.

* Automatically install ComfyUI if not already present.

* Set up symbolic links for external model and workflow folders.

* Restart the container after the initial setup.

**Access ComfyUI:**

Once the container is running, open your browser and navigate to:
```
http://localhost:8188
```
Stopping the container:
```
docker-compose down
```
### Notes ###

* The setup_and_run.sh script automatically clones ComfyUI if it's not installed and sets up folder mappings.

* The container will stop and require a manual restart after setup due to the way folder linking is handled.

* The ComfyUI workspace is stored persistently using the comfyui_data Docker volume.

### Contributing ###

Feel free to open issues or submit pull requests to improve this setup!

### License ###

This project is licensed under the MIT License.
