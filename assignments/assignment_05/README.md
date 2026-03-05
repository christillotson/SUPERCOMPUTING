# Pipeline Description
This pipeline runs two scripts. The first script downloads and extracts several .fastq files in the /data/raw directory. The second script uses fastp to do some trimming and analysis on forward and backwards reads of the sequences, putting these trimmed files in the /data/trimmed directory. You will need to have installed fastp for this to work. Assuming all of your dependencies have been satisfied, and the project directory structure is unchanged, this pipeline is easily runnable. Simply navigate to the directory that pipeline.sh is in, and run
```
./pipeline.sh
```
# Tasks

## Task 1
 - used mkdir in the assignment_05 directory to create scripts, log, and data
 - cd'd into data and used mkdir to make raw and trimmed directories

## Task 2
cd'd back into scripts to create a 01_download_data.sh using 

```
nano 01_download_data.sh
```

and gave it the following text

```
#!/bin/bash
set -ueo pipefail

data_dir="${HOME}/SUPERCOMPUTING/assignments/assignment_05/data/raw"
# put everything in raw
rm -f "${data_dir}"/*.fastq
# so we don't get duplicates
wget -P "${data_dir}" "https://gzahn.github.io/data/fastq_examples.tar"
# get the tarball in the data directory
tar xvf "${data_dir}/fastq_examples.tar" -C "${data_dir}"
# extract it inside the data directory
gunzip "${data_dir}"/*.gz
# unzip the various .gz

rm "${data_dir}/fastq_examples.tar"
# finally remove the .tar not needed
```
## Task 3
Path to my programs already in .bashrc so I won't do that again.

To get fastp I ran these two commands in my programs folder (home directory, not scripts of assignment_05)
```
wget http://opengene.org/fastp/fastp
chmod a+x ./fastp
```
my fastp version is 1.1.0. This is checked by running
```
fastp -v
``` 
which gave me the output 
```
fastp 1.1.0
```

## Task 4
in assignment_05/scripts directory,

```
nano 02_run_fastp.sh
```

And give it the following text:
```
#!/bin/bash
set -ueo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_R1_/_R2_}

FWD_OUT=${FWD_IN/.fastq/.trimmed.fastq}
REV_OUT=${REV_IN/.fastq/.trimmed.fastq}

# original assignment instructions had above but was .fastq.gz instead of just >
fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/trimmed} --out2 ${REV_OUT/raw/trimmed} --json /dev/null --html /dev/null --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20
```

and gave it executable permissions with
```
chmod +x 02_run_fastp.sh
```

Tested it with 
```
./02_run_fastp.sh ~/SUPERCOMPUTING/assignments/assignment_05/data/raw/6083_098_S98_R1_001.subset.fastq
```
And it works, check trimmed data folder and both the forward and reverse trimmed are there, so moving on...

## Task 5
Navigated back to assignment_05 to 
```
nano pipeline.sh
```
And give it this text:
```
#!/bin/bash
set -ueo pipefail

./scripts/01_download_data.sh

for i in ~/SUPERCOMPUTING/assignments/assignment_05/data/raw/*_R1_*.fastq;
do ./scripts/02_run_fastp.sh $i;
done
```
then added permissions with 
```
chmod +x pipeline.sh
```
and ran it with
```
./pipeline.sh
```
My loop then ran for quite a while and checking output in data/trimmed, seems to have worked well.
The echo'd statements are nice to know that it is working but I wish there was some way to suppress the large print outputs and just have a simple indication that it worked or not, once I have my pipeline set up.

## Task 6
navigated into data/raw using cd and ran
```
rm *
```
then I went back into assignment_05 directory and ran
```
./pipeline.sh
```

## Task 7
See above section for description of the pipeline.

## Task 8
added these lines to my .gitignore for the SUPERCOMPUTING repo:
```
# ignore data files from assignment_05

assignments/assignment_05/data/raw/*.fastq
assignments/assignment_05/data/trimmed/*.fastq
```
Pushed to github after this with git add, git commit, and git push.

# Reflection

The particulars of file paths were a bit challenging in this assignment. There was much trial and error, and some googling, on where to implement file paths correctly for different commands, such as wget, tar, and fastp. However, by keeping the code modular as different scripts, and testing on a subset of the data, this testing was not too painful. 

For this assignment I learned a little more about markdown syntax to make this ReadMe appear neater. Most of the rest of the implementation here was pretty straightforward given the instructions and building off the class lessons, which I appreciated. 

We split this workflow up due to trying to follow the ideal of modularity. By having each script serve a particular function, in the future I could more easily add another analysis step while not messing with the data downloading step, or add another script to only work off the trimmed data. Additionally, I could potentially repurpose these small scripts for different projects. This modularity also made testing easier by first ensuring that a piece of the pipeline works as expected, and only then moving onto the next piece, instead of having to write / debug one long script. These are all pros of this approach - a con is that this probably takes a little more time to implement, and that it will only run if all the "right pieces" are in the right place - each script is where it originates, and fastp is installed properly, but this is an acceptable tradeoff.