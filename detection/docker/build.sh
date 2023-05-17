# Bash file to build image.

GPU_MEM='24gb'
IMAGE_NAME='focalnet'
TAG='torch1.9.0-cuda11.1-cudnn8-mmcv1.x-mmdet2.x'

nvidia-docker build \
    --shm-size $GPU_MEM \
    -t ${IMAGE_NAME}:${TAG} \
    -f docker/Dockerfile .
