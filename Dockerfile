# Siesta 5.4.0 Dockerfile for building from source without MPI/ScaLAPACK



FROM debian:stable-slim

# 安裝基本編譯依賴
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    gcc \
    g++ \
    cmake \
    git \
    wget \
    ca-certificates \
    libblas-dev \
    liblapack-dev \
    libhdf5-dev \
    libnetcdf-dev \
    libreadline-dev \
    patch \
    diffutils \
    && rm -rf /var/lib/apt/lists/*

# 設定工作目錄
WORKDIR /opt

# 取得 SIESTA 源碼（從 GitLab）
RUN git clone https://gitlab.com/siesta-project/siesta.git \
    && cd siesta \
    && git fetch --tags \
    && git checkout 5.4.0 \
    && git submodule update --init --recursive

# 使用 CMake 三步驟建構與安裝（關閉 MPI/ScaLAPACK）
WORKDIR /opt/siesta
RUN cmake -S. -B_build \
      -DCMAKE_INSTALL_PREFIX=/usr/local/siesta \
      -DCMAKE_BUILD_TYPE=Release \
      -DENABLE_MPI=OFF \
      -DENABLE_SCALAPACK=OFF \
      -DENABLE_NETCDF=ON \
      -DENABLE_HDF5=ON \
 && cmake --build _build -j1 \
 && cmake --install _build

# 設定 PATH
ENV PATH="/usr/local/siesta/bin:${PATH}"

# 預設執行 siesta
CMD ["siesta", "--version"]