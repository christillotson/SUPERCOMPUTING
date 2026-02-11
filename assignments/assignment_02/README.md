# assignment_02

Christopher Tillotson
February 12, 2026
assignment_02

The following are commands that I used as well as the general process for this assignment.

## TASK 1

To SSH into bora, I ran the command
````bora````
Which is aliased this way in my .bashrc file:
````alias bora="ssh cttillotson@bora.sciclone.wm.edu"````
Then I was prompted to enter my password, which I did.
I am then in my home HPC directory. The directory "~/SUPERCOMPUTING/assignments/assignment_02/data/" already existed, so I did not need to create it. IF I did need to create it, I could have ran 
````mkdir -p SUPERCOMPUTING/assignments/assignment_02/data```
Or, more appropriately, ````git clone```` a repository which had this created.

After this I can safely type ````exit```` to leave.

## TASK 2

These commands worked for task 2, starting from my home directory on my local machine. 
````ftp ftp.ncbi.nlm.nih.gov````
login as prompted, giving "anonymous" for the username and my school email as the password.

````cd genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/```` 
brought me to the intended file path.
````pwd```` and checking its output verified I was where I wanted to be.

However I found that ````get```` was rejected and I was unable to get the files this way.

````ftp> get GCF_000005845.2_ASM584v2_genomic.fna.gz````
````200 PORT command successful````
````425 Unable to build data connection: Connection refused````

Seeing that I could not do this, I ran ````bye```` to exit the ftp server and return to my local home directory.

SO I just downloaded the files directly with 

````curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz````

and

````curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gff.gz````

which were both run in my local home directory. curl is the base command to download the file, the flag -O ensures the file is downloaded with the same filename as in the address, and the address is where the file is downloaded from.

## TASK 3

## 3.1 
Then I simply log into File Zilla as directed, using a connection that was already established in class under the same parameters as 3.1. This was accessed with `ctrl+s`, selected the right connection, then clicking "Connect", then clicking "OK" on the pop-up. Then, I navigated to my home directory on the HPC as displayed in FileZilla, then into the SUPERCOMPUTING/assignments/assignment_02/data folder, and then simply clicked and dragged the two necessary files over.

Then, back in my terminal, I connected to bora with the same process as in TASK 1. 

Once in bora and logged in,

````cd SUPERCOMPUTING````
````cd assignments/assignment_02/data````

````ll```` (list tells me what permission are)

current perms on both files are -rw------- which means it is only readable and writeable by me
SO, following this source below, I ran the commands to change permissions to what I wanted.
https://linuxize.com/post/chmod-command-in-linux/

````chmod g=r GCF_000005845.2_ASM584v2_genomic.fna.gz````
````chmod o=r GCF_000005845.2_ASM584v2_genomic.fna.gz````

````chmod g=r GCF_000005845.2_ASM584v2_genomic.gff.gz````
````chmod o=r GCF_000005845.2_ASM584v2_genomic.gff.gz````

then I checked permissions again with ````ll```` to ensure they were what I wanted them to be. in the chmod command, the last argument is obviously the file, but the first g=r or o=r sets either the group or all user permissions to reading, respectively. 

I kept this Git Bash open to run the next task in bora.

## TASK 4

To do this, I opened another Git Bash instance and navigated to my local SUPERCOMPUTING directory using ````cd```` (I will not share the actual filepath for my personal setup) then by running 
````cd assignments/assignment_02/data````

#### MD5 hashes

md5sum on local machine:

````md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz````
c13d459b5caa702ff7e1f26fe44b8ad7 *GCF_000005845.2_ASM584v2_genomic.fna.gz

````md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz````
2238238dd39e11329547d26ab138be41 *GCF_000005845.2_ASM584v2_genomic.gff.gz

md5sum on HPC repository:

````md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz````
c13d459b5caa702ff7e1f26fe44b8ad7  GCF_000005845.2_ASM584v2_genomic.fna.gz

````md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz````
2238238dd39e11329547d26ab138be41  GCF_000005845.2_ASM584v2_genomic.gff.gz

md5 hashes given by the source website (in the same directory as the two intended files, listed in 'md5checksums.txt'):

c13d459b5caa702ff7e1f26fe44b8ad7  ./GCF_000005845.2_ASM584v2_genomic.fna.gz

2238238dd39e11329547d26ab138be41  ./GCF_000005845.2_ASM584v2_genomic.gff.gz

NOTE: These hashes all match. This tells me that my file download, and then transfer from FileZilla, did not corrupt the files.

## TASK 5

To add to bashrc:
In same git bash window as did md5sum on local machine

````nano .bashrc````

Paste in what is suggested
I had these aliases already but in different forms so I deleted the old ones

````ctrl+o```` to save, then press enter
then ````ctrl+x```` to exit

then I ran
````source ~/.bashrc````
as instructed

Description for each alias:
alias u='cd ..;clear;pwd;ls -alFh --group-directories-first'

This one u does several things:
1. go up to parent directory with cd..
2. clear the terminal so old output is not printed
3. pwd, prints the working directory
4. ls, lists file contents, alFh: {
    a = all files, 
    l = long form, 
    F = adds special symbols to end of name: 
        / – directory.
        nothing – normal file.
        @ – link file.
        * – Executable file, 
    h = human readable (file and link sizes in bytes vs human readable)
}, and --group-directories-first lists the directories (and links) first

had to look at this source for the next one: https://dev.to/ccoveille/tips-the-power-of-cd-command-16b

alias d='cd -;clear;pwd;ls -alFh --group-directories-first'
1. This first goes to the most recent directory that the user was in with cd -
2. The string of pwd and everything following it is the same as the alias u above and does the same thing after navigating

alias ll='ls -alFh --group-directories-first'
ls, lists file contents, alFh: {
    a = all files, 
    l = long form, 
    F = adds special symbols to end of name: 
        / – directory.
        nothing – normal file.
        @ – link file.
        * – Executable file, 
    h = human readable (file and link sizes in bytes vs human readable)
}, and --group-directories-first lists the directories (and links) first

## Reflection

Most of this assignment worked perfectly fine for me, except for getting the files using ````ftp```` in the command line. While I was able to navigate into the NIH server and the intended directory, I was unable to ````get```` the files. I think this is either due to Windows firewall issues, or an inherent limitation of the standard Windows ftp making it unable to get files in passive mode, or a combination of these reasons. So, to work past this issue, I instead used ````curl```` to download the files. This resulted in the same result, which was the .gz files in my home directory, as ````ftp```` and ````get```` would have, except this will not work in all future cases where there is not a URL to pull from.

I also ran into an issue in terms of a merge conflict between the remote repository and the HPC repository, though this was quickly resolved by accepting any new changes, because in this case I did not delete anything, I just edited the README.

Working with FileZilla was relatively straightforward given our experience with it in class, as was the rest of the assignment. I would not change any of this assignment because it gave me good practice on what a normal file retrieval, moving, and verification would be like, I just wish that I could configure my system to make ftp work.


