#!/bin/sh

identify_ht () {
  CPUFILE=/proc/cpuinfo
  NUMPHY=`grep "physical id" $CPUFILE | sort -u | wc -l`
  NUMLOG=`grep "processor" $CPUFILE | wc -l`
  NUMCORE=`grep "core id" $CPUFILE | sort -u | wc -l`
  let TOTALCORES=$NUMPHY*$NUMCORE
  if [ $TOTALCORES -eq $NUMLOG ]
  then
    HT_ENABLED=OFF
  else
    HT_ENABLED=ON
  fi
  echo $HT_ENABLED
}
