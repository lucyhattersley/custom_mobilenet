# Build the Docker image
docker build -t mobilenet .

# Run the container
docker run -it --name mobilenet -v "$HOME/Programs/custom_mobilenet/output/models:/app/models" -v "$HOME/Programs/custom_mobilenet/output/converted:/app/converted" mobilenet bash

