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
3. Generate SPEC HS06 Tarball for spec suite ISO File:
```
mkdir /mnt/SPEC2006_v12
mount -o ro /root/<ISO_DOWNLOADED_FROM_SPEC_WEBSITE> /mnt/SPEC2006_v12
cd /mnt/
chmod -R u+w SPEC2006_v12
tar cvjf /SPEC2006_v12.tar.bz2 SPEC2006_v12
cd 
umount /mnt/SPEC2006_v12 ; rmdir /mnt/SPEC2006_v12

```
4. Generate SPEC CPU2017 Tarball from spec suite ISO file
```
TODO
```
5. Build and run docker container
```
TODO
```
