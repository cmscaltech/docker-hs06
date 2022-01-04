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

cd $SDIR

# Docker does not allow to add file outside of build dir. copy temporary file 
cp ../base-runtime-float.patch .
sh $SDIR/build.sh
rm -f base-runtime-float.patch


cd $WN_TMP
if [ -n "$SPEC2006_v12_TAR" ]; then
    if [ ! -d "$WN_TMP/SPEC2006_v12" ]; then
        tar -xvf $SPEC2006_v12_TAR
    fi
fi

if [ -n "$CPU2017_TAR" ]; then
    if [ ! -d "$WN_TMP/CPU2017" ]; then
        tar -xvf $CPU2017_TAR
    fi
fi


