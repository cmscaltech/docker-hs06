#!/bin/bash


timestamp=$(date +%s)

# TODO: Allow to control flags and provide params from outside
/opt/cern-benchmark/cern-benchmark -q -o --benchmarks="hs06_32" --hs06_path=/wntmp/SPEC2006_v12/ &> /wntmp/hs0632.out-$timestamp
# Sleep for 5 minutes to cool down
sleep 300
cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out /wntmp/hs0632.log-$timestamp


/opt/cern-benchmark/cern-benchmark -q -o --benchmarks="hs06_64" --hs06_path=/wntmp/SPEC2006_v12/ &> /wntmp/hs0664.out-$timestamp
# Sleep for 5 minutes to cool down
sleep 300
cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out /wntmp/hs0664.log-$timestamp

/opt/cern-benchmark/cern-benchmark -q -o --benchmarks="DB12"  &> /wntmp/db12.out-$timestamp
# Sleep for 5 minutes to cool down
sleep 300
cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out /wntmp/db12.log-$timestamp

/opt/cern-benchmark/cern-benchmark -q -o --benchmarks="spec2017" --spec2017_path=/wntmp/CPU2017/ &> /wntmp/spec2017.out-$timestamp
sleep 300
cp /tmp/cern-benchmark_root/cloud-benchmark-suite.out /wntmp/spec2017.log-$timestamp

while true; do sleep 120; done
