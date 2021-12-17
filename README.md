Prerequisites (Done ONCE, No need to repeat these steps):
1. Prepare HS06 tarball (Can be done once and saved on USB/Shared FS)
```
mkdir /tmp/SPEC2006_v12
mount -o ro /root/<ISO_DOWNLOADED_FROM_SPEC_WEBSITE> /tmp/SPEC2006_v12
cd /tmp
tar cvjf /SPEC2006_v12.tar.bz2 SPEC2006_v12
cd
umount /tmp/SPEC2006_v12 ; rmdir /tmp/SPEC2006_v12
# Save /SPEC2006_v12.tar.bz2 which can be reused on diff machine. (like on a shared FS or USB, etc)
```
2. Generate SPEC CPU2017 Tarball from spec suite ISO file. (You need to have CPU2017 ISO File and do it once. Save it on USB/Shared FS afterwards)
```
mkdir /tmp/CPU2017
mount -o ro /root/<ISO_DOWNLOADED_FROM_SPEC_WEBSITE> /tmp/CPU2017
cd /tmp
tar cvjf /CPU2017.tar.bz2 CPU2017
cd
umount /tmp/CPU2017 ; rmdir /tmp/CPU2017
# Save /CPU2017.tar.bz2 which can be reused on diff machine. (like on a shared FS or USB, etc)
```

On Each machine you want to test:
1. You need to have cvmfs installed. To install cvmfs here are commands below, or look at https://opensciencegrid.org/docs/worker-node/install-cvmfs/:
```
yum update
yum install yum-plugin-priorities
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum install osg-oasis
systemctl enable autofs
systemctl start autofs
vi /etc/auto.master.d/cvmfs.autofs # Put the content below:
/cvmfs /etc/auto.cvmfs
#####################
systemctl restart autofs
vi /etc/cvmfs/default.local # Put the content below
CVMFS_REPOSITORIES="`echo $(ls /cvmfs)|tr ' ' ,`"
CVMFS_CACHE_BASE=/wntmp/cvmfs
CVMFS_QUOTA_LIMIT=20000
CVMFS_HTTP_PROXY="DIRECT"
export CMS_LOCAL_SITE=/cvmfs/cms.cern.ch/SITECONF/T2_US_Caltech
####################
ls -l /cvmfs/cms.cern.ch
```
2. Install docker or docker-ce
```
yum install docker-ce -y
service docker start
```
3. /wntmp - Separate disk for scratch space. Spec Suite will require from 20GB to ~40GB disk space. (Depends on N of cores)
4. Prepare working directory (from tarballs)
```
cd /wntmp
cp <LOCATION_OF_SPEC2006_v12.tar.bz2> .
cp <LOCATION_OF_CPU2017.tar.bz2> .
tar -xvf SPEC2006_v12.tar.bz2
tar -xvf CPU2017.tar.bz2
```
5. Build and run docker container
```
cd /wntmp
git clone https://github.com/cmscaltech/docker-hs06
cd docker-hs06
./build.sh
./start.sh
```

TODOs:
1. Allow to control /wntmp directory for docker
2. Allow to control which tests to run (e.g. only HS06_32, or only CPU2017)
3. Add HEPScore start/run script into this repo.
4. Upload to docker hub, so no need to rebuild (easier for future to use with condor)

