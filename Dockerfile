FROM ubuntu:14.04

ENV THUMBOR_VERSION  5.2.1

RUN  \
    apt-get update --quiet && \
    apt-get -y --quiet install build-essential checkinstall gcc python python-dev \
        libpng12-dev libtiff5-dev libpng-dev libjasper-dev libwebp-dev \
        libcurl4-openssl-dev python-pgmagick libmagick++-dev graphicsmagick \
        libopencv-dev python-opencv python-pip && \
    apt-get clean && \
    # Add 'thumbor' user which will run the application
    adduser thumbor --home /home/thumbor --shell /bin/bash --disabled-password --gecos "" && \
    mkdir /home/thumbor/app && chown -R thumbor:thumbor /home/thumbor/app && \
    mkdir /home/thumbor/conf && chown -R thumbor:thumbor /home/thumbor/conf && \
    pip install pycurl numpy thumbor==${THUMBOR_VERSION} tc_aws

COPY thumbor.conf /home/thumbor/conf/thumbor.conf
COPY thumbor.key /home/thumbor/conf/thumbor.key

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

VOLUME ["/home/thumbor/app"]

WORKDIR /home/thumbor/app
USER thumbor

ENTRYPOINT ["/entrypoint.sh"]
CMD ["thumbor"]

EXPOSE 8080
