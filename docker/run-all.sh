#!/bin/bash
set -x
SDIR="$(dirname "$(realpath "$0")")"

if [ -f $SDIR/../environment ]; then
    # Load Environment Variables
    export $(cat $SDIR/../environment | grep -v '#' | awk '/=/ {print $1}')
fi


docker run \
       --name benchmarks-docker \
       -v $WN_TMP:$WN_TMP \
       -v /cvmfs/:/cvmfs \
       -v $SDIR/../environment:/environment \
       --env-file $SDIR/../environment \
       benchmarks-docker
