#!/bin/bash

if [ -f ../environment ]; then
    # Load Environment Variables
    export $(cat ../environment | grep -v '#' | awk '/=/ {print $1}')
fi

yum -y install docker
service docker stop
# This part below is fragile if people have things already under /var/lib/docker
# Mention this in README.MD to do in advance.
#rm -rf /var/lib/docker
#ln -s /wntmp/docker/ /var/lib/docker
#mkdir /wntmp/docker/
sysctl -w user.max_net_namespaces=10000
service docker start

./build.sh