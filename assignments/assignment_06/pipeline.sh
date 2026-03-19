#!/bin/bash
set -ueo pipefail

# pipeline to collect the data, install necessary prerequisites to run, and run flye in a few different environments
./scripts/01_download_data.sh

./scripts/flye_2.9.6_conda_install.sh

./scripts/flye_2.9.6_manual_build.sh
# NOTE FOR THIS PIPELINE
# inspect this script to adjust where flye should be installed. It also does NOT AUTOMATICALLY add to the path variable
# because that feels wrong to me, to adjust someone's variable
# manually add the location of where flye will be to your path

./scripts/03_run_flye_conda.sh 
./scripts/03_run_flye_local.sh 
./scripts/03_run_flye_module.sh

tail -n 10 ./assemblies/assembly_conda/flye.log
tail -n 10 ./assemblies/assembly_module/flye.log
tail -n 10 ./assemblies/assembly_local/flye.log
