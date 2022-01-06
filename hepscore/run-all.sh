#!/bin/bash

SDIR="$(dirname "$(realpath "$0")")"

if [ -f $SDIR/../environment ]; then
    # Load Environment Variables
    export $(cat $SDIR/../environment | grep -v '#' | awk '/=/ {print $1}')
fi

# Source Helper functions
source $SDIR/../helper_functions.sh

HT_FLAG=$(identify_ht)

timestamp=$(date +%s)
OUT_DIR=$SAVE_DIR/HEPSCORE-HT-$HT_FLAG/$timestamp
mkdir -p $OUT_DIR

HEPSCORE_LOGS=$OUT_DIR/LOGS/
mkdir -p $HEPSCORE_LOGS

CONFIGS=`dirname "$0"`/confs/

# =========================================================
#                        HEPSCORE_RUN_ALL
# =========================================================
if [ $HEPSCORE_RUN_ALL -eq 1 ]; then
    ~/.local/bin/hepscore -m docker $HEPSCORE_LOGS -f $CONFIGS/all.yaml &> $OUT_DIR/all.out
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): HEPSCORE_RUN_ALL is not configured to run. Continue"
fi

# =========================================================
#                        HEPSCORE_RUN_CMS
# =========================================================
if [ $DOCKER_RUN_HS06_64 -eq 1 ]; then
    ~/.local/bin/hepscore -m docker $HEPSCORE_LOGS -f $CONFIGS/cms.yaml &> $OUT_DIR/cms.out
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): HEPSCORE_RUN_CMS is not configured to run. Continue"
fi

# =========================================================
#                        HEPSCORE_RUN_ATLAS
# =========================================================
if [ $HEPSCORE_RUN_ATLAS -eq 1 ]; then
    ~/.local/bin/hepscore -m docker $HEPSCORE_LOGS -f $CONFIGS/atlas.yaml &> $OUT_DIR/atlas.out
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): HEPSCORE_RUN_ATLAS is not configured to run. Continue"
fi

# =========================================================
#                        HEPSCORE_RUN_LHCB
# =========================================================
if [ $HEPSCORE_RUN_LHCB -eq 1 ]; then
    ~/.local/bin/hepscore -m docker $HEPSCORE_LOGS -f $CONFIGS/lhcb.yaml &> $OUT_DIR/lhcb.out
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): HEPSCORE_RUN_LHCB is not configured to run. Continue"
fi

# =========================================================
#                        HEPSCORE_RUN_BELLE2
# =========================================================
if [ $HEPSCORE_RUN_BELLE2 -eq 1 ]; then
    ~/.local/bin/hepscore -m docker $HEPSCORE_LOGS -f $CONFIGS/belle2.yaml &> $OUT_DIR/belle2.out
    sleep $SLEEP_TIME_BEFORE_RUNS
else
    echo "(INFO): HEPSCORE_RUN_BELLE2 is not configured to run. Continue"
fi

