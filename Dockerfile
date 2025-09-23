FROM tensorflow/tensorflow:2.14.0-gpu

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --fix-missing -y \
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

RUN pip install -U pip --no-cache-dir && \
    pip install --no-cache-dir \
    tensorflow_datasets==4.9.* \
    model-compression-toolkit==2.2.0 \
    imx500-converter[tf]

# Create a non-root user with UID/GID 1000
RUN groupadd -g 1000 appuser && \
    useradd -m -u 1000 -g 1000 appuser && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

COPY custom_mobilenet.py /app/