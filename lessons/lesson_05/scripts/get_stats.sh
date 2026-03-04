#!/bin/bash
set -euo pipefail

# take files as inout

# run seqkit stats on them all 
seqkit stats ./data/*.fastq > ./output/stats.tsv
# export results
