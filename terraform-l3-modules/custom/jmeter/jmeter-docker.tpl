#!/bin/bash

sudo yum update -y 
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-edge
sudo yum-config-manager --enable docker-ce-test
sudo yum install -y docker-ce-${DOCKER_ENGINE_VERSION}
sudo systemctl enable docker
sudo systemctl start docker

mkdir -p /opt ; cd /opt

echo 'FROM alpine:3.6
ARG JMETER_VERSION="${JMETER_VERSION}"
ENV JMETER_HOME /opt/apache-jmeter-$JMETER_VERSION
ENV JMETER_BIN  $JMETER_HOME/bin
ENV JMETER_DOWNLOAD_URL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz

RUN    apk update \
        && apk upgrade \
        && apk add ca-certificates \
        && update-ca-certificates \
        && apk add --update openjdk8-jre gzip curl unzip bash tar \
        && rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent $JMETER_DOWNLOAD_URL >  /tmp/dependencies/apache-jmeter-$JMETER_VERSION.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-$JMETER_VERSION.tgz -C /opt  \
	&& rm -rf /tmp/dependencies

ENV PATH $PATH:$JMETER_BIN

EXPOSE 1099 ' > Dockerfile.jmeter

sudo docker build -t jmeter:latest -f Dockerfile.jmeter .  ## Use this(jmeter:latest) image to run tests
sudo docker ps 
sudo docker images
