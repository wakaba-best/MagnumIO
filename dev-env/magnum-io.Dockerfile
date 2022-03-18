# GENERATED FILE, DO NOT EDIT

FROM nvcr.io/nvidia/pytorch:21.12-py3

# NVIDIA Nsight Systems 2021.3.2

# Mellanox OFED version 5.4-1.0.3.0
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        gnupg \
        wget && \
    rm -rf /var/lib/apt/lists/*
RUN wget -qO - https://www.mellanox.com/downloads/ofed/RPM-GPG-KEY-Mellanox | apt-key add - && \
    mkdir -p /etc/apt/sources.list.d && wget -q -nc --no-check-certificate -P /etc/apt/sources.list.d https://linux.mellanox.com/public/repo/mlnx_ofed/5.4-1.0.3.0/ubuntu20.04/mellanox_mlnx_ofed.list && \
    apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ibverbs-providers \
        ibverbs-utils \
        libibmad-dev \
        libibmad5 \
        libibumad-dev \
        libibumad3 \
        libibverbs-dev \
        libibverbs1 \
        librdmacm-dev \
        librdmacm1 && \
    rm -rf /var/lib/apt/lists/*

# GDRCOPY version 2.3
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        make \
        wget && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/tmp && wget -q -nc --no-check-certificate -P /var/tmp https://github.com/NVIDIA/gdrcopy/archive/v2.3.tar.gz && \
    mkdir -p /var/tmp && tar -x -f /var/tmp/v2.3.tar.gz -C /var/tmp -z && \
    cd /var/tmp/gdrcopy-2.3 && \
    mkdir -p /usr/local/gdrcopy/include /usr/local/gdrcopy/lib && \
    make prefix=/usr/local/gdrcopy lib lib_install && \
    echo "/usr/local/gdrcopy/lib" >> /etc/ld.so.conf.d/hpccm.conf && ldconfig && \
    rm -rf /var/tmp/gdrcopy-2.3 /var/tmp/v2.3.tar.gz
ENV CPATH=/usr/local/gdrcopy/include:$CPATH \
    LIBRARY_PATH=/usr/local/gdrcopy/lib:$LIBRARY_PATH

# UCX version 1.11.0

# NVSHMEM 2.2.1
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        make \
        wget && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/tmp && wget -q -nc --no-check-certificate -P /var/tmp https://developer.download.nvidia.com/compute/redist/nvshmem/2.2.1/source/nvshmem_src_2.2.1-0.txz && \
    mkdir -p /var/tmp && tar -x -f /var/tmp/nvshmem_src_2.2.1-0.txz -C /var/tmp -J && \
    cd /var/tmp/nvshmem_src_2.2.1-0 && \
    CUDA_HOME=/usr/local/cuda NVSHMEM_MPI_SUPPORT=0 NVSHMEM_PREFIX=/usr/local/nvshmem make -j$(nproc) install && \
    rm -rf /var/tmp/nvshmem_src_2.2.1-0 /var/tmp/nvshmem_src_2.2.1-0.txz
ENV CPATH=/usr/local/nvshmem/include:$CPATH \
    LIBRARY_PATH=/usr/local/nvshmem/lib:$LIBRARY_PATH \
    PATH=/usr/local/nvshmem/bin:$PATH

# NCCL 2.11.4-1
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        gnupg \
        wget && \
    rm -rf /var/lib/apt/lists/*
RUN wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" >> /etc/apt/sources.list.d/hpccm.list && \
    apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libnccl-dev=2.11.4-1+cuda11.5 \
        libnccl2=2.11.4-1+cuda11.5 && \
    rm -rf /var/lib/apt/lists/*

# GDS 1.1.0.37-1
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gds-tools-11-5=1.1.0.37-1 \
        libcufile-11-5=1.1.1.25-1 \
        libcufile-dev-11-5=1.1.1.25-1 \
        libssl-dev \
        sudo && \
    rm -rf /var/lib/apt/lists/*

COPY magnum-io.Dockerfile \
    third_party.txt \
    README.md \
    /

ENV MAGNUM_IO_VERSION=21.12-pytorch

SHELL ["/bin/bash", "-c"]
CMD ["/bin/bash" ]


