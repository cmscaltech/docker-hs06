#!/bin/bash
set -x
SDIR="$(dirname "$(realpath "$0")")"

if [ -f $SDIR/../environment ]; then
    # Load Environment Variables
    export $(cat $SDIR/../environment | grep -v '#' | awk '/=/ {print $1}')
fi

if [ $DOCKER_APPLY_SYSCTL -eq 1 ]; then
    sysctl -w user.max_net_namespaces=10000
fi

# Remove all any unleft docker container
docker rm benchmarks-docker

docker run \
       --name benchmarks-docker \
       -v $WN_TMP:$WN_TMP \
       -v /cvmfs/:/cvmfs \
       -v $SDIR/../environment:/environment \
       --env-file $SDIR/../environment \
       benchmarks-docker
