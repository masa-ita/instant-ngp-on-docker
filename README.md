# instant-ngp-on-docker
## About
This repository allow you to run NVIDIA's instant-ngp on docker.

https://github.com/NVlabs/instant-ngp
## How to run
### Step 1 : Clone this reposigory
Clone this repogitory with --recursive flag.
```bash
git clone --recursive https://github.com/masa-ita/instant-ngp-on-docker.git
```
### Step 2 : Build docker-ubuntu-vnc-desktop-with-cuda image
Build docker-ubuntu-vnc-desktop-with-cuda in a submodule.
```bash
cd docker-ubuntu-vnc-desktop-with-cuda
docker build -t docker-ubuntu-vnc-desktop-with-cuda -f Dockerfile.cuda .
cd ..
```
### Step 3 : Build instant-ngp-on-docker image
Build instant-ngp-on-docker image.
```bash
docker build -t instant-ngp-on-docker .
```
### Step 4 : Run
Run the container.
```bash
docker run -it --rm --gpus all -p 6080:80 -v /dev/shm:/dev/shm instant-ngp-on-docker
```
### Step 5 : Use desktop with noVNC
Open the desktop with your browser.

http://localhost:6080

### Step 6 : Run instant NeRF  
Menu -> System Tools -> LXTerminal.  
And run testbed.
```bash
cd instant-ngp
./build/testbed --scene data/nerf/fox/transforms.json
```
