FROM debian:latest

# Use mirror
# RUN touch /etc/apt/sources.list
# RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# RUN sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    clang \
    libclang-dev \
    make \
    cmake \
    ninja-build \
    curl \
    pkg-config \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

RUN sh -c "$(curl -L https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)"
RUN chsh -s /bin/zsh

# docker run -it --name=rustc_dev --network=host dev

# And delete the proxy settings in the git config, to avoid "7890 after 0ms".