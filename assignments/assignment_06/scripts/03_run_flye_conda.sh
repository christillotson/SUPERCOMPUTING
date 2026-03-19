#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

conda activate flye-env

mkdir ./assemblies/assembly_conda # added while doing pipeline

flye   --nano-hq ./data/SRR33939694.fastq.gz   --genome-size 50k   --out-dir ./assemblies/assembly_conda/temp_folder   --threads 6   --meta

mv ./assemblies/assembly_conda/temp_folder/assembly.fasta ./assemblies/assembly_conda/conda_assembly.fasta

mv ./assemblies/assembly_conda/temp_folder/flye.log ./assemblies/assembly_conda/flye.log

rm -r ./assemblies/assembly_conda/temp*



conda deactivate
