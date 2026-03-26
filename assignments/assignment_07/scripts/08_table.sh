#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env

#!/bin/bash
set -ueo pipefail

CLEAN_DIR=data/clean
OUTPUT_DIR=output

echo -e "SampleID\tTotal Reads\tDog-Mapped Reads"

for r1 in $CLEAN_DIR/*_1.trimmed.fastq; do
    sample=$(basename $r1 _1.trimmed.fastq)

    qc_reads=$(cat $r1 | wc -l | awk '{print $1/4}')
    dog_reads=$(cat $OUTPUT_DIR/${sample}_dog-matches.sam | wc -l)

    echo -e "$sample\t$qc_reads\t$dog_reads"
done
