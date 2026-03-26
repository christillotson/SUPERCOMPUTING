#!/bin/bash
set -ueo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_1.fastq/_2.fastq}

FWD_OUT=${FWD_IN/.fastq/.trimmed.fastq}
REV_OUT=${REV_IN/.fastq/.trimmed.fastq}

# original assignment instructions had above but was .fastq.gz instead of just fastq. But I interpreted extracts the contents as gunzipping, so ask prof about this
fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/clean} --out2 ${REV_OUT/raw/clean} --json /dev/null --html /dev/null --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20
