#!/bin/bash

if [ -f ../environment ]; then
    # Load Environment Variables
    export $(cat ../environment | grep -v '#' | awk '/=/ {print $1}')
fi


yum -y install git bzip2 bc
yum -y groupinstall 'Development Tools'
yum -y install glibc-devel.i686 glibc-devel systemd-libs.x86_64 libgcc libgcc.i686 libstdc++.i686 libstdc++

if grep -q -i "release 8" /etc/redhat-release
then
    # libnsl and glibc-devel are needed for running HS06_32
    yum install libnsl glibc-devel.i686
fi


cd /opt && git clone https://gitlab.cern.ch/cloud-infrastructure/cloud-benchmark-suite.git
cd /opt && mv cloud-benchmark-suite cern-benchmark
cd /opt/cern-benchmark/ && git apply ../base-runtime-float.patch

cd $WN_TMP
if [ -z "$SPEC2006_v12_TAR" ]; then
    tar -xvzf $SPEC2006_v12_TAR
fi


if [ -z "$CPU2017_TAR" ]; then
    tar -xvf $CPU2017_TAR
fi
