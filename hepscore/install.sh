#!/bin/bash

if [ -f ../environment ]; then
    # Load Environment Variables
    export $(cat ../environment | grep -v '#' | awk '/=/ {print $1}')
fi


pip3 install --user git+https://gitlab.cern.ch/hep-benchmarks/hep-score.git