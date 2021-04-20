FROM ubuntu:20.04
MAINTAINER mongenae@its.jnj.com

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

ENV STAR_VERSION 2.7.8a
ENV SAMTOOLS_VERSION 1.12

WORKDIR /home

RUN apt-get update && \
    apt-get upgrade -y 

RUN apt-get install -y --fix-missing zlibc zlib1g zlib1g-dev make gcc g++ wget libncurses5-dev libncursesw5-dev libbz2-dev liblzma-dev git

RUN apt-get update

# Compile from source
RUN git clone https://github.com/arun-sub/bwa-mem2.git ert
WORKDIR /home/ert

RUN make clean
RUN make arch=avx2

ENV PATH /home/ert
ENV LD_LIBRARY_PATH "/usr/local/lib:${LD_LIBRARY_PATH}"

RUN echo "export PATH=$PATH" > /etc/environment
RUN echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" > /etc/environment
