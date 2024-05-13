FROM python:3.11.9-bullseye

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt -y upgrade && \
    apt-get -y install software-properties-common apt-utils && \
    apt-get -y install build-essential cmake unzip git wget curl tmux sysstat \
    vim  libtool  &&\
    apt-get clean &&\
    apt-get autoremove &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/cache/apt/archives/*

# Install requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

ENV PYTHONPATH $PYTHONPATH:/workdir

WORKDIR /workdir
