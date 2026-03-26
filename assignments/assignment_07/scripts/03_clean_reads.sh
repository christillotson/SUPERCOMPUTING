#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env

rm -rf data/clean/*

for file in data/raw/*_1.fastq;
do ./scripts/run_fastp_onefile.sh "$file";
done
