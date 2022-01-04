#!/bin/bash

SDIR="$(dirname "$(realpath "$0")")"

if [ -f $SDIR/../environment ]; then
    # Load Environment Variables
    export $(cat $SDIR/../environment | grep -v '#' | awk '/=/ {print $1}')
fi

yum -y install docker-ce

if [ $DOCKER_OVERWRITE_STORAGE -eq 1 ]; then
    service docker stop
    # This part below is fragile if people have things already under /var/lib/docker
    # Mention this in README.MD to do in advance.
    rm -rf /var/lib/docker
    mkdir $DOCKER_STORAGE_DIR
    ln -s $DOCKER_STORAGE_DIR /var/lib/docker
    service docker start
fi


if [ $DOCKER_APPLY_SYSCTL -eq 1 ]; then
    sysctl -w user.max_net_namespaces=10000
fi

pip3 install --user git+https://gitlab.cern.ch/hep-benchmarks/hep-score.git
