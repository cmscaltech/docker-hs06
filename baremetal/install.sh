#!/bin/bash

SDIR="$(dirname "$(realpath "$0")")"

if [ -f $SDIR/../environment ]; then
    # Load Environment Variables
    export $(cat $SDIR/../environment | grep -v '#' | awk '/=/ {print $1}')
fi


yum -y install git bzip2 bc
yum -y groupinstall 'Development Tools'
yum -y install glibc-devel.i686 glibc-devel systemd-libs.x86_64 libgcc libgcc.i686 libstdc++.i686 libstdc++

if grep -q -i "release 8" /etc/redhat-release
then
    # libnsl and glibc-devel are needed for running HS06_32
    yum install libnsl glibc-devel.i686
fi


if [ ! -d "/opt/cern-benchmark" ]; then
    cd /opt && git clone https://gitlab.cern.ch/cloud-infrastructure/cloud-benchmark-suite.git
    cd /opt && mv cloud-benchmark-suite cern-benchmark
    cd /opt/cern-benchmark/ && git apply $SDIR/../base-runtime-float.patch
fi

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
