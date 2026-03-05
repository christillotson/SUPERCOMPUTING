#!/bin/bash
set -ueo pipefail

./scripts/01_download_data.sh

for i in ~/SUPERCOMPUTING/assignments/assignment_05/data/raw/*_R1_*.fastq;
do ./scripts/02_run_fastp.sh $i;
done
