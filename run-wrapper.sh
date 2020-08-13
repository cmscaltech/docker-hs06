#!/bin/bash

cd /wntmp/hs06/spec2k/

nohup /opt/cern-benchmark/cern-benchmark -q -o --benchmarks="hs06_32;hs06_64;" --hs06_path=/wntmp/hs06/spec2k/SPEC2006_v12/ &

while true; do sleep 120; done
