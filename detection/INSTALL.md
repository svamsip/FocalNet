
## Installation Instructions

- Clone this repo:

    ```bash
    git clone https://github.com/svamsip/FocalNet
    cd FocalNet
    ```

- Create a conda virtual environment and activate it:

    ```bash
    conda create -n focal python=3.7 -y
    conda activate focal
    ```

- Install `CUDA==11.1` with `cudnn8` following
  the [official installation instructions](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
- Install `PyTorch==1.9.0` and `torchvision==0.10.0` with cuda support:

    ```bash
    pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
    ```

- Install `timm`:

    ```bash
    pip install timm
    ```

- [Optional] Install `Apex`:

    ```bash
    git clone https://github.com/NVIDIA/apex
    cd apex
    pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./
    ```

- For other requirements refer to `requirements.txt`:

    **captured from docker container environment.

    ```bash
    pip install -r requirements.txt
    ```

- Recommend installing mmcv and mmdet from source.

  - `mmcv`

    ```bash
    # Install mmcv 1.7.1
    git clone https://github.com/open-mmlab/mmcv.git -b 1.x /openmmlab/mmcv \  
        && cd /openmmlab/mmcv \
        && MMCV_WITH_OPS=1 pip install --no-cache-dir -e . -v
    ```

  - `mmdet`

    ```bash
    # Install MMDetection 2.28.2
    git clone https://github.com/open-mmlab/mmdetection.git -b 2.x /openmmlab/mmdetection \
    && cd /openmmlab/mmdetection \
    && pip install --no-cache-dir -e .
    ```

- Copy `mmcv/*` and `mmdet/*` files into respective directories at `/openmmlab/`

    ```bash
    # copy the epoch_based_runner with AMP 
    cp Focalnet/detection/mmcv/mmcv/runner/epoch_based_runner.py  /openmmlab/mmcv/mmcv/runner/epoch_based_runner.py

    # copy focalnet module
    cp Focalnet/detection/mmdet/models/backbones/__init__.py  /openmmlab/mmdetection/mmdet/models/backbones/__init__.py

    cp Focalnet/detection/mmdet/models/backbones/focalnet.py  /openmmlab/mmdetection/mmdet/models/backbones/focalnet.py

    # copy focalnet configuration files
    cp Focalnet/detection/configs/* /openmmlab/mmdetection/configs/
    ```

## Docker

- Dockerfile: [docker/Dockerfile](docker/Dockerfile)
- build docker image by executing [docker/build.sh](docker/build.sh)

    ```bash
    bash docker/build.sh
    ```

    or

    ```bash
    nvidia-docker build \
        --shm-size $GPU_MEM \
        -t focalnet:torch1.9.0-cuda11.1-cudnn8-mmcv1.x-mmdet2.x \
        -f docker/Dockerfile .

    ```
