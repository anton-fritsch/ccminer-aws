FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Anton Fritsch

ENV DEBIAN_FRONTEND noninteractive

ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
ENV PATH=/usr/local/cuda/bin/:$PATH

RUN BUILD_DEPS=" \
      build-essential \
      linux-headers-generic \
      ca-certificates \
      curl \
      wget \
      libssl-dev \
      libcurl4-openssl-dev \
      git \
      make \
      automake" \
  && apt-get update \
  && apt-get install --no-install-recommends -y \
       ${BUILD_DEPS} \
       libgomp1 \
       libcurl3 \
  && git clone https://github.com/tpruvot/ccminer.git -b v2.1-tpruvot \
  && cd ccminer \
  && ./autogen.sh \
  && ./configure CFLAGS="-O3 -Wall -march=native" \
  && make install \
  && apt-get -yqq remove --purge ${BUILD_DEPS} \
  && apt-get -yqq autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

CMD ["./ccminer/ccminer", "-c", "/etc/ccminer/conf.d/ccminer.conf"]
