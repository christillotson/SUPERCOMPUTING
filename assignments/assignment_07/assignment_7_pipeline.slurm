#!/bin/bash
#SBATCH --job-name=christill_assign7
#SBATCH --nodes=1 # how many physical machines in the cluster
#SBATCH --ntasks=1 # how many separate 'tasks' (stick to 1)
#SBATCH --cpus-per-task=10 # how many cores (bora max is 20)
#SBATCH --time=0-12:00:00 # d-hh:mm:ss or just No. of minutes
#SBATCH --mem=32G # how much physical memory (all by default)
#SBATCH --mail-type=FAIL,BEGIN,END # when to email you
#SBATCH --mail-user=cttillotson@wm.edu # who to email
#SBATCH -o output/%j.out #STDOUT to file (%j is jobID)
#SBATCH -e output/%j.err #STDERR to file (%j is jobID)



set -ueo pipefail

./scripts/create_conda_environment.sh
# uncomment above before submitting so it works out of the box

./scripts/02_download_data.sh

./scripts/03_clean_reads.sh

./scripts/04_05_map_reads.sh
