### documentation of what I'm doing
# Task 1
Already have the programs folder

# Task 2
scroll down on github page to find linked 'releases page'
https://github.com/cli/cli/releases/tag/v2.87.2

link that just says 'GitHub CLI 2.87.2 linux amd64'
is same as what is linked and what I Want to download

commands for installing:

cd into programs folder in bora

wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

tar -xzvf gh_2.74.2_linux_amd64.tar.gz 

### notably this is slightly ahead in terms of version as previous one, which is 2.74.0

# Task 3
making install_gh.sh script

first touch install_gh.sh

then nano install_gh.sh

type commands I used above, the wget, tar, then rm to remove the old .gz file

rm gh_2.74.2_linux_amd64.tar.gz

Can't yet execute due to no permissions

chmod +x install_gh.sh

does the trick

then execute using

./install_gh.sh

Actually it downloaded a ...gz.1 becuase I never removed the original. So, if I remove this .1, then should start running normally, so

rm gh_2.74.2_linux_amd64.tar.gz.1

works now and no tarballs left

# Task 4

Add location of gh binary to $PATH

go back home with cd

nano .bashrc
add the following line:

export PATH=$PATH:/sciclone/home/cttillotson/programs/gh_2.74.2_linux_amd64/bin 

make sure to save with ctrl+s before ctrl+x to exit

setting up gh auth login was done in class already but this is a newer version of gh so I will run gh auth login again
because it's now in my path, re-run bashrc with
source .bashrc

# Task 5
running 

gh auth login

✓ Logged in as christillotson
! You were already logged in to this account

Due to this already being done (see lesson 02)

# Task 6

Went back and also edited install_gh.sh to be better due to wanting it to only ever install to programs, no matter where I run the script from, 
by cding into the programs folder and using nano to edit install_gh:
#### begin install_gh.sh
#!/bin/bash
# above is shebang I think
set -ueo pipefail

wget -P ~/programs https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz
# command to get a specific version. Ideally would use wildcards to get up to date version? this could get tricky though and for this assignment I Think this is ok.

tar -xzvf ~/programs/gh_2.74.2_linux_amd64.tar.gz -C ~/programs
# unpack the file

rm ~/programs/gh_2.74.2_linux_amd64.tar.gz
# remove old tarball

#### end install_gh.sh

I ended up with this script after a lot of trial and error, but it puts the seqtk in my programs folder

#### begin install_seqtk.sh
#!/bin/bash
# above is shebang I think
set -ueo pipefail

rm -f ~/programs/seqtk
# get rid of old seqtk if it exists, goes on without error (forced) if not

git clone https://github.com/lh3/seqtk.git ~/programs/seqtk_folder

make -C ~/programs/seqtk_folder

# unpack the file

mv ~/programs/seqtk_folder/seqtk ~/programs/seqtk
# move the seqtk program to programs

rm -rf ~/programs/seqtk_folder
# remove old seqtk directory,
# -r to get rid of directory with contents -f force

echo "export PATH=$PATH:/sciclone/home/cttillotson/programs" >> ~/.bashrc

#### end seqtk.sh

I think the last line to echo the path to my bashrc isn't necessary because it's already there but OK.

# Task 7

I ran a few different commands on that assignment_03 fasta. I hope dropse doesn't modify the file because I ran that on it...., no output, which worried me. What did it do?

seqtk dropse GCF_000001735.4_TAIR10.1_genomic.fna

# Task 8 / 9

fasta files
navigate to assignment_04 using cd
mkdir data
cd data

then get the files

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/005/405/GCF_001005405.1_ASM100540v1/GCF_001005405.1_ASM100540v1_cds_from_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/005/405/GCF_001005405.1_ASM100540v1/GCF_001005405.1_ASM100540v1_rna_from_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/005/455/GCF_001005455.1_ASM100545v1/GCF_001005455.1_ASM100545v1_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/005/455/GCF_001005455.1_ASM100545v1/GCF_001005455.1_ASM100545v1_rna_from_genomic.fna.gz

then gunzip these with syntax gunzip <filename>

To get number of sequences and bases I think we can simply use seqtk size
AI helped me interpret output of seqtk comp so I use comp to do the next thing
Final code for this script: 

#### begin code
#!/bin/bash
# above is shebang I think

set -ueo pipefail

fasta_file_path=$1

num_seq=$(seqtk size "$fasta_file_path" | cut -f1)

num_base=$(seqtk size "$fasta_file_path" | cut -f2)
echo "Number of sequences in this file:"
echo $num_seq
echo "Number of bases in this file:"
echo $num_base

table_seqs=$(seqtk comp "$fasta_file_path" | cut -f 1,2)
echo "Table of sequences and their lengths:"
echo  "$table_seqs"
# quoting above keeps it in the right format. not quoting removes newlines tabs etc
#### end code
# Task 9

Running this command in assignment_04 directory should work
for file in data/GCF*; do ./summarize_fasta.sh $file;done

# Task 10 Reflection

It was challenging working with seqtk but AI helped me figure out how to do what I wanted to do when I worded things like "I want to do {X} with seqtk, how do I do it?". I wish there was better documentation online on what all the seqtk commands did, there is obviously a short description built in but it wasn't enough for me to understand, though could be because I'm not a genomic scientist. Also, syntax got tricky when referring to variables, especially as whether or not to quote it, and when to use dollar signs. The quoting isn't super intuitive to me and I will need to practice more for it to be second nature, though glad that I am able to figure out what works using trial and error. Learned that NOT quoting will remove newlines and hurt the format of tables so I need to quote when trying to return those to stdout from a script. Also learned more about writing scripts generally and making them work with input variables / assigning variables within the script. Addressing $PATH: basically, my understanding is it is a list of directories that are searched when the user tries to use a command. In each directory, I assume starting with the first, the computer looks for a program by the name of the program that was called and, if it finds it, will use that program to interpret the rest of the command input. There can be a lot of different directories here and it's ideal to add locations where common scripts / programs are, to reference them later. $PATH is a variable so can be modified (mostly added to) in different ways. 

# Task 11 Github
The way I have been working was doing coding stuff on HPC and writing in the ReadMe on my local machine because it is easier to use a text editor to edit it. So, first on HPC SUPERCOMPUTING, I git add ., git commit -m "(a message)", then git push
Then, on local, I git pull (to get changes), same add/commit/push as on HPC, so now remote is up to date but HPC isn't.
So then I go back to remote and git pull, and now everything should be the same.
