Commands that worked for supercomputing assignment 2
ftp [the address]
login with anonymous password
email cttillotson@wm.edu
cd to the file path, though it doesn't display
pwd tells me I am in the right directory

CAN't ftp! and CAN't passive mode! probably due to firewall
SO I just downloaded the files directly with 

curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz

and

curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gff.gz

Then moved onto Task 3

Then I simply log into File Zilla as directed, navigate to my home directory, and move those two .gz files to the data folder in assignment_02 as specified

Once in bora and logged in,

cd SUPERCOMPUTING
cd assignments/assignment_02/data

ll (list tells me what permission are)

current perms on both files are -rw------- which means it is only readable and writeable by me
SO
#https://linuxize.com/post/chmod-command-in-linux/

chmod g=r GCF_000005845.2_ASM584v2_genomic.fna.gz
chmod o=r GCF_000005845.2_ASM584v2_genomic.fna.gz

chmod g=r GCF_000005845.2_ASM584v2_genomic.gff.gz
chmod o=r GCF_000005845.2_ASM584v2_genomic.gff.gz

# had to do both because checking permissions after just o results in just o and not group, want both really

NOW doing md5sum in the git bash I have where I'm logged into bora:

md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz
OUTPUT:
c13d459b5caa702ff7e1f26fe44b8ad7  GCF_000005845.2_ASM584v2_genomic.fna.gz

md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz
OUTPUT: 
2238238dd39e11329547d26ab138be41  GCF_000005845.2_ASM584v2_genomic.gff.gz


NOW opening a new git bash window and running the same commands because they're in the home directory
cd to go home because it didn't start in home

md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz
c13d459b5caa702ff7e1f26fe44b8ad7 *GCF_000005845.2_ASM584v2_genomic.fna.gz

md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz
2238238dd39e11329547d26ab138be41 *GCF_000005845.2_ASM584v2_genomic.gff.gz

# They are the same

Task 5

To add to bashrc:
In same git bash window as did md5sum on local machine

nano .bashrc

Paste in what is suggested
I had these aliases already but in different forms so I deleted the old ones

ctrl+o to save, then press enter
then ctrl+x to exit

then I ran
source ~/.bashrc
as instructed

Description for each alias:
alias u='cd ..;clear;pwd;ls -alFh --group-directories-first'

This one u does several things:
1. go up to parent directory with cd..
2. clear the terminal so old output is not printed
3. pwd, prints the working directory
4. ls, lists file contents, alFh: {
    a = all, 
    l = long form, 
    F = adds special symbols to end of name: 
        / – directory.
        nothing – normal file.
        @ – link file.
        * – Executable file, 
    h = human readable (file and link sizes in bytes vs human readable)
}, and --group-directories-first lists the directories (and links) first

alias d='cd -;clear;pwd;ls -alFh --group-directories-first'
This one also does a few things:
# UNFINISHED

alias ll='ls -alFh --group-directories-first'
# UNFINISHED

# STILL TO DO
- finish above task of describing the aliases
- write a reflection 4-5 sentences what worked and what didn't
- make sure that SUPERCOMPUTING in github matches with on HPC



