#!/bin/bash
set -ueo pipefail
module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env

REFERENCE=data/dog_reference/dog_reference_genome.fna
CLEAN_DIR=data/clean
OUTPUT_DIR=output

# Map quality filtered reads against dog reference genome
for r1 in $CLEAN_DIR/*_1.trimmed.fastq; do
    sample=$(basename $r1 _1.trimmed.fastq)
    r2=$CLEAN_DIR/${sample}_2.trimmed.fastq

    bbmap.sh -Xmx16g \
        ref=$REFERENCE \
        in1=$r1 \
        in2=$r2 \
        out=$OUTPUT_DIR/${sample}.sam \
        minid=0.95
done

# Extract mapped reads using samtools
for sam in $OUTPUT_DIR/*.sam; do
    sample=$(basename $sam .sam)
    samtools view -F 4 $sam > $OUTPUT_DIR/${sample}_dog-matches.sam
done
