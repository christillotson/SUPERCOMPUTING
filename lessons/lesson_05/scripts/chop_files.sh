#!/bin/bash
set -euo pipefail

PROJ_DIR=~/SUPERCOMPUTING/lessons/lesson_05
# wrote in class
# this scripts calls the interleaving and does it on all the data that matches the pattern
# in the data folder, with the input being the number of sequences chopped at the end


# or first line could be
# for FWD in ${SHARED_DIR}/lesson_05/data/*_R1_*
# except that the subshell can't access this environment variable

# where files should go

for FWD in $PROJ_DIR/data/*_R1_* # original first line that works
do REV=${FWD/_R1_/_R2_}
OUT=${FWD%_L001_R1_sample.fastq}_interleaved_chopped_${1}.fastq
echo $FWD $REV $OUT $1
$PROJ_DIR/scripts/interleave_chop.sh $FWD $REV $OUT $1
done

# modified 3/3/2026 to change $1 to $N becuase pipeline wasn't running without input
# so now is an environment variable
# nevermind changed back to 1 because every new script opens a new subshell so it can't actually access that environment variabls
