
FROM debian:latest

# Use mirror
RUN touch /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 更新并安装必要的系统依赖
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    llvm \
    llvm-dev \
    clang \
    libclang-dev \
    make \
    cmake \
    ninja-build \
    libssl-dev \
    pkg-config \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装 Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# 设置 Rust 环境变量，直接通过 ENV 设置
ENV PATH=/root/.cargo/bin:$PATH

# 设置工作目录
WORKDIR /opt/c2rust

# docker run -it -v .:/opt/safe-c2rust safer-c2rust
# 然后删除git config中的https.proxy和http.proxy，"7890 after 0ms".