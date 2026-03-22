# Build the Docker image
docker build -t mobilenet .

# Run the container
docker run -it --name mobilenet -v "/home/lucy/custom_mobilenet/output/models:/app/models" -v "/home/lucy/custom_mobilenet/output/converted:/app/converted" mobilenet bash

