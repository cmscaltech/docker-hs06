#!/bin/bash

if [ -f ../environment ]; then
    # Load Environment Variables
    export $(cat ../environment | grep -v '#' | awk '/=/ {print $1}')
fi


docker run \
       -it --name benchmarks-docker \
       -v $WN_TMP:$WN_TMP \
       -v /cvmfs/:/cvmfs \
       -v $(pwd)/../environment/:/environment/ \
       --env-file ../environment \
       benchmarks-docker
