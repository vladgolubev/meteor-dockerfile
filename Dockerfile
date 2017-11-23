FROM ubuntu:16.04

# install curl, git, python (for scss meteor package)
RUN DEBIAN_FRONTEND=noninteractive && \
        apt-get update -qq && \
        apt-get install -y --no-install-recommends -qq \
        apt-utils apt-transport-https ca-certificates curl git gnupg2 software-properties-common \
        build-essential g++ python python-dev unzip

# install meteor
RUN curl https://install.meteor.com/ | sh

WORKDIR /tmp

# create user 'someone' and allow him to run meteor
RUN useradd --create-home --shell /bin/bash someone && \
    chown someone:someone /usr/local/bin/meteor
USER someone

# create sample meteor project
# this will download meteor distribution into home directory
RUN meteor create example --bare

# build sample meteor project
# this will download and build default meteor packages
RUN cd example && \
    mkdir -p /tmp/out && \
    meteor build --directory /tmp/out

USER root

# cleanup after apt-get commands
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*.deb /var/cache/apt/*cache.bin
