Prerequisites:
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
2. /wntmp - Is a separate disk for scratch space.
3. Generate SPEC HS06 Tarball for spec suite ISO File. (You need to has HS06 ISO File)
```
mkdir /tmp/SPEC2006_v12
mount -o ro /root/<ISO_DOWNLOADED_FROM_SPEC_WEBSITE> /tmp/SPEC2006_v12
cd /tmp
tar cvjf /SPEC2006_v12.tar.bz2 SPEC2006_v12
cd 
umount /tmp/SPEC2006_v12 ; rmdir /tmp/SPEC2006_v12
# Save /SPEC2006_v12.tar.bz2 which can be reused on diff machine. (like on a shared FS or USB, etc)
```
4. Generate SPEC CPU2017 Tarball from spec suite ISO file. (You need to has CPU2017 ISO File)
```
mkdir /tmp/CPU2017
mount -o ro /root/<ISO_DOWNLOADED_FROM_SPEC_WEBSITE> /tmp/CPU2017
cd /tmp
tar cvjf /CPU2017.tar.bz2 CPU2017
cd 
umount /tmp/CPU2017 ; rmdir /tmp/CPU2017
# Save /CPU2017.tar.bz2 which can be reused on diff machine. (like on a shared FS or USB, etc)
```
5. Build and run docker container
```
TODO
```
