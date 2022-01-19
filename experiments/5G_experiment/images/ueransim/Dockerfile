FROM ubuntu:20.04

# Install updates and dependencies
RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install make g++ libsctp-dev lksctp-tools iproute2 \
    git iputils-ping \
    iperf3 wget

# Install yq parser for experimenting

RUN wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64.tar.gz -O - |\
  tar xz && mv yq_linux_amd64 /usr/bin/yq

# Install cmake
RUN apt-get -y install wget
RUN wget -qO- "https://cmake.org/files/v3.20/cmake-3.20.0-linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local

# Clone and build UERANSIM
RUN git clone -b v3.2.6 https://github.com/aligungr/UERANSIM && \
    cd UERANSIM && make

# Set the working directory to UERANSIM
WORKDIR /UERANSIM
