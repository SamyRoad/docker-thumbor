FROM ubuntu:14.04

ENV THUMBOR_VERSION 6.0.1
ENV DOCKER_UID 1000
ENV DOCKER_GID 1000

RUN  \
    apt-get update -qq && \
    apt-get upgrade -y -qq && \
    apt-get autoremove -y -qq && \
    apt-get -y -qq install build-essential python python-dev \
        libpng12-dev libtiff5-dev libpng-dev libjasper-dev libwebp-dev \
        libcurl4-openssl-dev python-pgmagick libmagick++-dev graphicsmagick \
        libopencv-dev python-opencv python-pip && \
    apt-get clean && \
    adduser thumbor --home /home/thumbor --shell /bin/bash --disabled-password --gecos "" && \
    mkdir /home/thumbor/app && chown -R thumbor:thumbor /home/thumbor/app && \
    mkdir /home/thumbor/conf && chown -R thumbor:thumbor /home/thumbor/conf && \
    pip install thumbor==${THUMBOR_VERSION} tc_aws

COPY thumbor.conf /home/thumbor/conf/thumbor.conf
COPY thumbor.key /home/thumbor/conf/thumbor.key

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

VOLUME ["/home/thumbor/app"]

WORKDIR /home/thumbor/app

ENTRYPOINT ["/entrypoint.sh"]
CMD ["thumbor"]

EXPOSE 8080
