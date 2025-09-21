# Docker GPU Setup for NVIDIA Graphics

This guide will help you set up Docker to access your NVIDIA GPU on your Dell laptop.

## Prerequisites

1. **NVIDIA Drivers**: Ensure you have NVIDIA drivers installed on your host system
   - Download from [NVIDIA Driver Downloads](https://www.nvidia.com/drivers/)
   - Or check if already installed: `nvidia-smi`

## Step 1: Install NVIDIA Container Toolkit

### On Ubuntu/WSL2:
```bash
# Add the GPG key
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

# Add the repository
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Update and install
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Configure Docker
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

### On Windows with Docker Desktop:
1. Ensure you have Docker Desktop with WSL2 backend
2. Install WSL2 with Ubuntu distribution
3. Follow the Ubuntu steps above within WSL2
4. Enable GPU support in Docker Desktop settings

## Step 2: Build Your Docker Image

```bash
docker build -t mobilenet-gpu .
```

## Step 3: Run Container with GPU Access

```bash
docker run --gpus all -it --rm mobilenet-gpu python custom_mobilenet.py
```

### Alternative GPU specifications:
- `--gpus all`: Use all available GPUs
- `--gpus 1`: Use one GPU
- `--gpus '"device=0"'`: Use specific GPU by device ID

## Step 4: Verify GPU Access

After running the container, you should see:
- `nvidia-smi` command succeeds (no "GPU not available" message)
- TensorFlow detects GPU: Check for messages like "Created device /GPU:0"

### Test GPU Detection Script:
```python
import tensorflow as tf
print("TensorFlow version:", tf.__version__)
print("GPU Available: ", tf.config.list_physical_devices('GPU'))
print("Built with CUDA: ", tf.test.is_built_with_cuda())
```

## Troubleshooting

### Common Issues:

1. **"nvidia-smi: command not found" in container**:
   - Check if NVIDIA Container Toolkit is properly installed
   - Restart Docker daemon: `sudo systemctl restart docker`

2. **"Docker: Error response from daemon: could not select device driver"**:
   - Ensure NVIDIA drivers are installed on host
   - Update Docker and NVIDIA Container Toolkit

3. **GPU not visible to TensorFlow**:
   - Verify container was started with `--gpus` flag
   - Check TensorFlow-GPU compatibility with your CUDA version

4. **On Windows/WSL2**:
   - Ensure WSL2 is using Windows NVIDIA drivers
   - Enable GPU compute in WSL2: Update Windows and WSL2 to latest versions

### Check Commands:
- Host GPU status: `nvidia-smi`
- Docker GPU support: `docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`
- Container GPU access: `docker run --gpus all -it mobilenet-gpu nvidia-smi`
