#!/bin/sh

sh baremetal/run-all.sh &> baremetal-run-log
sh docker/run-all.sh &> docker-run-log
sh hepscore/run-all.sh &> hepscore-run-log


