FROM centos:7

MAINTAINER Justas Balcas <jbalcas@caltech.edu>

RUN mkdir -p /opt
ADD base-runtime-float.patch /opt/base-runtime-float.patch 

RUN yum -y install yum-plugin-priorities
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install git bzip2 bc
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install glibc-devel.i686 glibc-devel systemd-libs.x86_64 libgcc libgcc.i686 libstdc++.i686 libstdc++

RUN cd /opt && git clone https://gitlab.cern.ch/cloud-infrastructure/cloud-benchmark-suite.git
RUN cd /opt && mv cloud-benchmark-suite cern-benchmark

RUN cd /opt/cern-benchmark/ && git apply /opt/base-runtime-float.patch

COPY run-wrapper.sh /usr/local/bin/run-wrapper.sh
CMD /usr/local/bin/run-wrapper.sh

