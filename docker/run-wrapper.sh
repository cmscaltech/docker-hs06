#!/bin/bash

if [ -f /environment ]; then
    # Load Environment Variables
    export $(cat /environment | grep -v '#' | awk '/=/ {print $1}')
fi

# Source Helper functions
source $SDIR/../helper_functions.sh

HT_FLAG=$(identify_ht)

timestamp=$(date +%s)
OUT_DIR=$SAVE_DIR/DOCKER-HT-$HT_FLAG/$timestamp
mkdir -p $OUT_DIR
# =========================================================
#                        HS_06_32
# =========================================================
if [ $DOCKER_RUN_HS06_32 -eq 1 ]; then
    /opt/cern-benchmark/cern-benchmark -q -o --benchmarks="hs06_32" --hs06_path=$SPEC2006_v12_DIR &> $OUT_DIR/hs0632.out
    cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out $OUT_DIR/hs0632.log
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): HS06_32 DOCKER is not configured to run. Continue"
fi

# =========================================================
#                        HS_06_64
# =========================================================
if [ $DOCKER_RUN_HS06_64 -eq 1 ]; then
    /opt/cern-benchmark/cern-benchmark -q -o --benchmarks="hs06_64" --hs06_path=$SPEC2006_v12_DIR &> $OUT_DIR/hs0664.out
    cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out $OUT_DIR/hs0664.log
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): HS06_64 DOCKER is not configured to run. Continue"
fi

# =========================================================
#                        DB12
# =========================================================
if [ $DOCKER_RUN_DB12 -eq 1 ]; then
    /opt/cern-benchmark/cern-benchmark -q -o --benchmarks="DB12" &> $OUT_DIR/db12.out
    cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out $OUT_DIR/db12.log
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): DB12 DOCKER is not configured to run. Continue"
fi

# =========================================================
#                        CPU_2017
# =========================================================
if [ $DOCKER_RUN_CPU_2017 -eq 1 ]; then
    /opt/cern-benchmark/cern-benchmark -q -o --benchmarks="spec2017" --spec2017_path=$CPU2017_DIR &> $OUT_DIR/cpu2017.out
    cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out $OUT_DIR/cpu2017.log
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): CPU 2017 DOCKER is not configured to run. Continue"
fi
