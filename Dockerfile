FROM python:3.13.3-slim-bookworm

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEN=noninteractive

RUN apt-get update && apt-get -y upgrade &&\
    apt-get -y --no-install-recommends install software-properties-common \
    apt-utils build-essential cmake unzip git wget curl tmux sysstat \
    vim libtool &&\
    apt-get clean &&\
    apt-get autoremove &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/cache/apt/archives/*

# Install requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

ENV PYTHONPATH=$PYTHONPATH:/workdir

WORKDIR /workdir
