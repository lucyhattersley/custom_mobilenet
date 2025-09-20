FROM tensorflow/tensorflow:2.14.0

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    nano \
    wget \
    tree \
    openjdk-17-jdk \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install -U pip --no-cache-dir&& \
    pip install --no-cache-dir \
    tensorflow_datasets==4.9.* \
    pip install model-compression-toolkit==2.2.0 \
    pip install imx500-converter[tf]