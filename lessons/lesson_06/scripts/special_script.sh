#!/bin/bash
set -ueo pipefail

# what is also done instead of moving around is coding in file paths at the top
# using cd is OK

BASE_DIR="/sciclone/home/cttillotson/SUPERCOMPUTING/lessons/lesson_06/scripts"
DATA_DIR="${BASE_DIR}/data"
OUT_DIR="${BASE_DIR}/output"

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate bbmap-env
# activate environmnet

cd data

wget https://zenodo.org/records/15733378/files/ecoli_and_lambda.tar
tar -xf ecoli_and_lambda.tar
rm ecoli_and_lambda.tar
# get data

bbmap.sh ref=ecoli_bl21de3.fasta in=lambda_reads.fastq out=mapping.sam nodisk=t ambiguous=best minid=0.9 threads=2
# do bbmap stuff

mv mapping.sam ../output
#two dots .. are back 1 then forward into ./output

cd -
# cd - goes back to where you were

conda deactivate
