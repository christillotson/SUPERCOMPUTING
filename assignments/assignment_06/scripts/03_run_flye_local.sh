#!/bin/bash
set -ueo pipefail
mkdir ./assemblies/assembly_local # added while doing pipeline

flye   --nano-hq ./data/SRR33939694.fastq.gz   --genome-size 50k   --out-dir ./assemblies/assembly_local/temp_folder   --threads 6   --meta

mv ./assemblies/assembly_local/temp_folder/assembly.fasta ./assemblies/assembly_local/local_assembly.fasta

mv ./assemblies/assembly_local/temp_folder/flye.log ./assemblies/assembly_local/flye.log

rm -r ./assemblies/assembly_local/temp*
