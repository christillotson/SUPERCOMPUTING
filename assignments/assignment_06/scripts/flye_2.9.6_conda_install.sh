#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# now build a conda environment for flye v2.9.6 called "flye-env"

mamba create -y -n flye-env flye -c bioconda

conda activate flye-env

flye -v

conda env export --no-builds > flye-env.yml

conda deactivate
