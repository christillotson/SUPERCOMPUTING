# The pipeline
This pipeline downloads some genomic data and installs conda and Flye to work with this data. It then calls other scripts to test running Flye (Detecting genomes?) in different environments: a conda environment, a module environment, and a locally installed environment. It can be easily run with ./pipeline.sh

Note: Inspect the script flye_2.9.6_manual_build.sh which installs flye. By default, it looks for a folder called 'programs' in the home directory and installs flye there. However, this will NOT AUTOMATICALLY change your path because this seems like antisocial behavior. This script may be modified depending on where you want to put the program. This is an example of a line which should be added to your .bashrc so that it can find the program.

export PATH=$PATH:$HOME/programs/Flye/bin

# Tasks

## Task 1
I setup the directories with mkdir (directory name)

## Task 2
created 01_download_data.sh in the scripts folder with nano

Intended to be run in in the main assignment_06 directory with ./scripts/01_download_data.sh

changed permissions with chmod +x

Then ran it

```
#!/bin/bash
set -ueo pipefail

wget -P ./data "https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1"
```
## Task 3

Wrote the following script:
```
#!/bin/bash
set -ueo pipefail

program_dir="$HOME/programs"

cd $program_dir
git clone https://github.com/fenderglass/Flye
cd Flye
make

```
Then CD'd into the location in programs, Flye, bin, and added this line to my .bashrc manually
```
export PATH=$PATH:/sciclone/home/cttillotson/programs/Flye/bin
```

Reload with source .bashrc

## Task 4
Wrote this script
```
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
```

checking version outputs this
```
2.9.6-b1802
```

## Task 5
Figuring out how to use Flye

Not sure what genome size refers to but if it means number of bases then website says it's 52.9M (million?) bases

Google says expected coliphage 30k to 60k so will do 50k

## Task 6
Using flye

Working with AI settled on this command which seems to work
```
flye   --nano-hq SRR33939694.fastq.gz   --genome-size 50k   --out-dir flye_coliphage_out   --threads 6   --meta
```
But need to implement and fix paths and such. For one, need to go and change download data script to rename data correctly
It is now this
```
rm -f ./data/*
wget -P ./data "https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1"
mv ./data/SRR33939694.fastq.gz\?download\=1  ./data/SRR33939694.fastq.gz
```
3 scripts written look like this, named exactly the same as given in example
Easy to make I just used cp to copy them and change a few words but same structure

CONDA:
```
#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

conda activate flye-env

flye   --nano-hq ./data/SRR33939694.fastq.gz   --genome-size 50k   --out-dir ./assemblies/assembly_conda/temp_folder   --threads 6   --meta

mv ./assemblies/assembly_conda/temp_folder/assembly.fasta ./assemblies/assembly_conda/conda_assembly.fasta

mv ./assemblies/assembly_conda/temp_folder/flye.log ./assemblies/assembly_conda/flye.log

rm -r ./assemblies/assembly_conda/temp*

conda deactivate
```

MODULE:
```
#!/bin/bash
set -ueo pipefail

module load miniforge3

flye   --nano-hq ./data/SRR33939694.fastq.gz   --genome-size 50k   --out-dir ./assemblies/assembly_module/temp_folder   --threads 6   --meta

mv ./assemblies/assembly_module/temp_folder/assembly.fasta ./assemblies/assembly_module/module_assembly.fasta

mv ./assemblies/assembly_module/temp_folder/flye.log ./assemblies/assembly_module/flye.log

rm -r ./assemblies/assembly_module/temp*
```

LOCAL:
```
#!/bin/bash
set -ueo pipefail

flye   --nano-hq ./data/SRR33939694.fastq.gz   --genome-size 50k   --out-dir ./assemblies/assembly_local/temp_folder   --threads 6   --meta

mv ./assemblies/assembly_local/temp_folder/assembly.fasta ./assemblies/assembly_local/local_assembly.fasta

mv ./assemblies/assembly_local/temp_folder/flye.log ./assemblies/assembly_local/flye.log

rm -r ./assemblies/assembly_local/temp*
```

## Task 7
3 commands to look at last 10 lines:
```
tail -n 10 ./assemblies/assembly_conda/flye.log
tail -n 10 ./assemblies/assembly_module/flye.log
tail -n 10 ./assemblies/assembly_local/flye.log
```

## Task 8
Went back and edited the scripts to properly create the directories but otherwise just called them all, in order of when created in this assignment. 

# Reflection
This assignment was not too bad conceptually but did take me quite a lot of time because, with so many moving parts, there were inevitably small bugs to fix. Additionally, I found myself going back a lot to make the script more modular, such as by first removing any old copy of the script still there, creating the directory to house outputs, etc. I would not say I learned anything new from this assignment besides using Flye - this assignment only covered content we learned about in class but it did reinforce it and I now feel much more comfortable writing scripts and pipelines. As far as the different methods, I think I prefer the environment. Though I would prefer to have fewer lines of code, it feels better to have this portable environment versus forcing a local install or relying on an admin (though I am sure they are very reliable) to make sure the module I want is installed.