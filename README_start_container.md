# Run the container with GPU support and mount the models and converted folder
docker run -it --name mobilenet_with_gpu_as_root --user 1000:1000 --gpus all -v "/home/lucy/custom_mobilenet/output/models:/app/models" -v "/home/lucy/custom_mobilenet/output/converted:/app/converted" custom_mobilenet bash

# Run as root
docker run -it --name mobilenet_with_gpu --gpus all -v "/home/lucy/custom_mobilenet/output/models:/app/models" -v "/home/lucy/custom_mobilenet/output/converted:/app/converted" custom_mobilenet bash