#!/bin/bash
set -ueo pipefail

rm -f ./data/*
wget -P ./data "https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1" 
mv ./data/SRR33939694.fastq.gz\?download\=1  ./data/SRR33939694.fastq.gz
