# Install Docker
# Step 3 of Install Docker (for Open WebUI) on Raspberry Pi Documentation
https://www.raspberrypi.com/documentation/computers/ai.html#step3-llm

# Build the Docker image
docker build -t mobilenet .

# Run the container
docker run -it --name mobilenet -v "$HOME/Programs/custom_mobilenet/output/models:/app/models" -v "$HOME/Programs/custom_mobilenet/output/converted:/app/converted" mobilenet bash

# Inside the container
python custom_mobilenet.py
