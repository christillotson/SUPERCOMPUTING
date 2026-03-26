#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# now build a conda environment

conda create -y -n assign-7-env ncbi-datasets-cli sra-tools bbmap samtools -c bioconda -c conda-forge

conda activate assign-7-env

conda deactivate
