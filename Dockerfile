FROM docker-ubuntu-vnc-desktop-with-cuda

USER root

# Install dependencies
RUN apt update && apt install -y \
        libssl-dev \
        git \
        libopenexr-dev \
        libxi-dev \
        libglfw3-dev \
        libglew-dev \
        libomp-dev \
        libxinerama-dev \
        libxcursor-dev \
        libboost-program-options-dev \
        libboost-filesystem-dev \
        libboost-graph-dev \
        libboost-system-dev \
        libboost-test-dev \
        libeigen3-dev \
        libsuitesparse-dev \
        libfreeimage-dev \
        libgoogle-glog-dev \
        libgflags-dev \
        qtbase5-dev \
        libqt5opengl5-dev \
        libcgal-dev \
        libatlas-base-dev \
        libsuitesparse-dev \
        python3-pip \
        python3-dev

RUN pip install numpy pyexr pillow scipy opencv-python

# Install cmake recent version
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.2/cmake-3.22.2.tar.gz && \
      tar xzf cmake-3.22.2.tar.gz && \
      cd cmake-3.22.2 && \
      ./bootstrap && make && make install && \
      cd /root

# Install instant-ngp
# If GPU autodetection fails, set the enviroment variable TCNN_CUDA_ARCHITECTURES
# with the GPU's compute capabirity code.
# ENV TCNN_CUDA_ARCHITECTURES 75
RUN git clone --recursive https://github.com/nvlabs/instant-ngp && \
    cd instant-ngp && \
    cmake . -B build && \
    cmake --build build --config RelWithDebInfo -j 16 && \
    cd /root

# Install Ceres Solver
RUN git clone https://ceres-solver.googlesource.com/ceres-solver && \
    cd ceres-solver && \
    git checkout $(git describe --tags) && \
    mkdir build && \
    cd build && \
    cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && \
    make -j && \
    make install && \
    cd /root

# Install COLMAP 3.7
RUN wget https://github.com/colmap/colmap/archive/refs/tags/3.7.tar.gz && \
    tar xzf 3.7.tar.gz && \
    cd colmap-3.7 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install && \
    cd /root

ENV PATH="/usr/local/cuda-11.2/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/cuda-11.2/lib64:$LD_LIBRARY_PATH"
