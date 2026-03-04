#!/bin/bash
set -euo pipefail
# usage: ./pipeline.sh [N bases to chop]


# intention of this general workflow is that pipeline.sh lives next to README and will call stuff in scripts on the stuff in 
# (whatever the data is)

# pipeline is the conductor and calls the relevant scripts in order

# set variable "N" to be number of bases to chop
N=${1}
# below scripts will be able to access environment variables
# actually nevermind they CANT because every new script opens a new subshell so that's why need to input it

# chop up data files
./scripts/chop_files.sh $N
# run stats
./scripts/get_stats.sh
