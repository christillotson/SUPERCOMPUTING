#!/bin/bash
set -ueo pipefail

module load miniforge3
mkdir ./assemblies/assembly_module # added while doing pipeline

flye   --nano-hq ./data/SRR33939694.fastq.gz   --genome-size 50k   --out-dir ./assemblies/assembly_module/temp_folder   --threads 6   --meta

mv ./assemblies/assembly_module/temp_folder/assembly.fasta ./assemblies/assembly_module/module_assembly.fasta

mv ./assemblies/assembly_module/temp_folder/flye.log ./assemblies/assembly_module/flye.log

rm -r ./assemblies/assembly_module/temp*
