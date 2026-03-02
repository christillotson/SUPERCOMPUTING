#!/bin/bash
set -euo pipefail

PROJ_DIR=~/SUPERCOMPUTING/lessons/lesson_05
# wrote in class
# this scripts calls the interleaving and does it on all the data that matches the pattern
# in the data folder, with the input being the number of sequences chopped at the end

for FWD in $PROJ_DIR/data/*_R1_*
do REV=${FWD/_R1_/_R2_}
OUT=${FWD%_L001_R1_sample.fastq}_interleaved_chopped_${1}.fastq
echo $FWD $REV $OUT
$PROJ_DIR/scripts/interleave_chop.sh $FWD $REV $OUT $1
done
