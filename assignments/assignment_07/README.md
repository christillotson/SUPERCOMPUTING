# Quick Start

Navigate to the top level directory of this probject and run assignment_07_pipeline.slurm by submitting it to slurm with
```
sbatch assignment_07_pipeline.slurm
```

Ensure that your modules are set up in the same way as mine are on the W&M HPC - should at least include conda!

# Tasks
## Task 1 repo structure
I went ahead and made the several directories with mkdir
## Task 2 download data

### Part A: getting the accessions
So from what I understand, the script is looping through the csv that I get, and that csv is just stored in the upper level data directory

This page gives info on finding "accessions"

https://www.ncbi.nlm.nih.gov/sra/docs/sradownload/

In the Entrez, I searched for "Illumina". First few files looked really big so I instead searched "Illumina xyz" just as a few random characters to see what would happen and the files I saw looked much smaller. So I chose the top 10 there and downloaded an Accession List file like the above documentation indicates. However then I looked back at instructions and actually it wants me to send to "Run Selector" and download the metadata from there instead. So I did that and now I have SraRunTable.csv

I used FileZilla to transfer it to assignment_07/data location on bora.

### Part B: getting packages I need

NOTE HERE: SRA TOOLKIT already set up
It is already set up. 

However according to instructions workflow must include setting up sra toolkit. I already had an install_sra.sh in my programs but to make it more modular, and with the help of AI, I now have this which should work for any version ([0-9]+ ensures any number of digits 0 to 9 so as long as version name is consistent number.number.number should be OK)

```
#!/bin/bash
# above is shebang I think
set -ueo pipefail

PROGRAMS_DIR="$HOME/programs"  # <-- User edit this as needed. Directory where you want programs like sratoolkit to live

cd "$PROGRAMS_DIR"

rm -rf sratoolkit*
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
tar -vxzf sratoolkit.current-ubuntu64.tar.gz
rm sratoolkit.current-ubuntu64.tar.gz

# Find the extracted sratoolkit bin directory (handles any version number)
SRATOOLKIT_BIN=$(find "$PROGRAMS_DIR" -maxdepth 2 -type d -name "bin" | grep -E "sratoolkit\.[0-9]+\.[0-9]+\.[0-9]+-ubuntu64")
export PATH=$PATH:"$SRATOOLKIT_BIN"
```

Now that my SRA toolkit could potentially be updated regularly, I manually added these lines to my .bashrc 
```
PROGRAMS_DIR="$HOME/programs"  # <-- User edit this as needed. Directory where you want programs like sratoolkit to live
SRATOOLKIT_BIN=$(find "$PROGRAMS_DIR" -maxdepth 2 -type d -name "bin" | grep -E "sratoolkit\.[0-9]+\.[0-9]+\.[0-9]+-ubuntu64")
export PATH=$PATH:"$SRATOOLKIT_BIN"
```
Not necessary for this pipeline but in the future outside of it if I want to use new versions of sra toolkit.

However now that I think about it more, this is probably a bad way to do it - installing software on another's device.

SO instead I decided to go the conda env route. with the help of AI I figured exactly which packages needed to be installed for this assignment and which channels to use, this is create_conda_environment.sh:

```
#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# now build a conda environment

conda create -y -n assign-7-env ncbi-datasets-cli sra-tools bbmap samtools -c bioconda -c conda-forge

conda activate assign-7-env

conda deactivate
```

So, run at the beginning of a pipeline and THEN can activate it in subsequent scripts. Not realistic to create the conda environment every time but to make this work right out of the box need to do that. Will comment for now to go faster but remember to submit uncommented.

### Part C: Downloading from the csv

Created assignment_7_pipeline.sh and added the create conda script, will make a script to download from csv and put in this pipeline, and also rename it .slurm later

Created 02_download_data.sh:

```
#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env


rm -f data/raw/*
rm -rf data/dog_reference/*

datasets download genome taxon "canis familiaris" --reference --filename data/dog_reference/canis_familiaris_ref.zip
unzip data/dog_reference/canis_familiaris_ref.zip -d data/dog_reference

mv data/dog_reference/ncbi_dataset/data/GCF_011100685.1/GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna data/dog_reference/dog_reference_genome.fna

shopt -s extglob
# need above to enable extended globbing (more pattern matching regex)
rm -rf data/dog_reference/!(*.fna)
```

## Task 3 clean raw reads

Reference 02_run_fastp.sh from assignment 5 ( just pasting here for reference, the actual script I use to run fastp is slightly different):
```
#!/bin/bash
set -ueo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_R1_/_R2_}

FWD_OUT=${FWD_IN/.fastq/.trimmed.fastq}
REV_OUT=${REV_IN/.fastq/.trimmed.fastq}

# original assignment instructions had above but was .fastq.gz instead of just fastq. But I interpreted extracts the contents as gunzipping, so ask prof about this
fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/trimmed} --out2 ${REV_OUT/raw/trimmed} --json /dev/null --html /dev/null --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20
```
I think what I will do is two scripts. One takes in a file name and runs fastp. Then a different one will run that script on a loop.

run_fastp_onefile.sh:
```
#!/bin/bash
set -ueo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_1.fastq/_2.fastq}

FWD_OUT=${FWD_IN/.fastq/.trimmed.fastq}
REV_OUT=${REV_IN/.fastq/.trimmed.fastq}

# original assignment instructions had above but was .fastq.gz instead of just fastq. But I interpreted extracts the contents as gunzipping, so ask prof about this
fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/clean} --out2 ${REV_OUT/raw/clean} --json /dev/null --html /dev/null --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20
```

03_clean_reads.sh
```
#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env

rm -rf data/clean/*

for file in data/raw/*_1.fastq;
do ./scripts/run_fastp_onefile.sh "$file";
done
```

## Tasks 4 and 5 mapping

wrote a script had AI help, called 04_05_mapping.sh: 
```
#!/bin/bash
set -ueo pipefail
module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env

REFERENCE=data/dog_reference/dog_reference_genome.fna
CLEAN_DIR=data/clean
OUTPUT_DIR=output

# Map quality filtered reads against dog reference genome
for r1 in $CLEAN_DIR/*_1.trimmed.fastq; do
    sample=$(basename $r1 _1.trimmed.fastq)
    r2=$CLEAN_DIR/${sample}_2.trimmed.fastq

    bbmap.sh -Xmx16g \
        ref=$REFERENCE \
        in1=$r1 \
        in2=$r2 \
        out=$OUTPUT_DIR/${sample}.sam \
        minid=0.95
done

# Extract mapped reads using samtools
for sam in $OUTPUT_DIR/*.sam; do
    sample=$(basename $sam .sam)
    samtools view -F 4 -b $sam > $OUTPUT_DIR/${sample}_dog-matches.bam
done
```
## Task 6 submit to SLURM
Renamed my pipeline to be .slurm and now it looks like this
```
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

```
Submitted it to slurm with sbatch, job id that was running is 286957

## Task 7
More interesting results on std err after a while. Also, a folder named 'ref' was created in the main directory, presumably due to how bbmap functions.

## Task 8 results table

Used AI and wrote a script to iterate over .sams in the output folder, called 08_table.sh
```
#!/bin/bash
set -ueo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate assign-7-env

#!/bin/bash
set -ueo pipefail

CLEAN_DIR=data/clean
OUTPUT_DIR=output

echo -e "SampleID\tTotal Reads\tDog-Mapped Reads"

for r1 in $CLEAN_DIR/*_1.trimmed.fastq; do
    sample=$(basename $r1 _1.trimmed.fastq)

    qc_reads=$(cat $r1 | wc -l | awk '{print $1/4}')
    dog_reads=$(cat $OUTPUT_DIR/${sample}_dog-matches.sam | wc -l)

    echo -e "$sample\t$qc_reads\t$dog_reads"
done
```
and the output table looks like this:
SampleID        Total Reads     Dog-Mapped Reads
ERR12092973     59746   0
ERR12092974     59839   0
ERR12092984     62174   0
ERR12093000     62290   0
ERR12093007     62248   0
ERR12093027     60001   0
ERR12093037     62271   0
ERR12093043     56757   0
ERR12093044     59790   1
ERR12093054     61485   0

Number for Dog-Mapped Reads is shifted over, not tab separated well, but one match! ERR12093044

# Reflection

This was a much more difficult assignment compared to others for exactly the reasons the instructions said it would be. It was challenging figuring out the new software which I was unfamiliar with so I had an AI LLM write those scripts after describing what I needed to do, and then tweaked / tested them myself on subsets of the data. There was also difficulty in the high level planning of this project for me - most time consuming was deciding how to structure the installation of packages (I settled on using a conda env) and how to make that work across multiple scripts. I was also unsure of how much resources to ask for - I wanted to ask for enough to get the computing done efficiently, but not so much that I would be banished to the bottom of the queue. It wasn't clear to me exactly how much to ask for but I settled on half of the CPUs and half of the RAM available to a single node, which seemed fair and still beefier than my local machine. I learned more about creating a conda environment and what needs to go into using it across multiple scripts in a pipeline, as well as balancing resource consumption in SLURM. 