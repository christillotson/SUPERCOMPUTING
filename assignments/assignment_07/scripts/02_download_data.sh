#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env


rm -f data/raw/*
rm -rf data/dog_reference/*

datasets download genome taxon "canis familiaris" --reference --filename data/dog_reference/canis_familiaris_ref.zip
unzip data/dog_reference/canis_familiaris_ref.zip -d data/dog_reference

mv data/dog_reference/ncbi_dataset/data/GCF_011100685.1/GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna data/dog_reference/dog_reference_genome.fna

shopt -s extglob
# need above to enable extended globbing (more pattern matching regex)
rm -rf data/dog_reference/!(*.fna)

for run_id in $(tail -n +2 data/SraRunTable.csv | cut -d',' -f1);
do fasterq-dump --split-files -O data/raw $run_id;
done
