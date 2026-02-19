Christopher Tillotson
February 19, 2026
Assignment_03

My process for Assignment_03 is this:

# Task 1

Once in the assignment_03 directory:
Created data directory using 

mkdir data

CD into data 

cd data

# Task 2

and download data with

wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz

then unzipped with

gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz

# Task 3

Exploring with Unix tools
1. How many sequences are in the FASTA file?
Get all headers which signifies a sequence, then count the number of lines

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | wc -l
7
2. What is the total number of nucleotides (not including header lines or newlines)?
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions/Cheatsheet
# https://unix.stackexchange.com/questions/60994/how-to-grep-lines-which-does-not-begin-with-or
# https://www.geeksforgeeks.org/linux-unix/wc-command-linux-examples/
https://www.geeksforgeeks.org/linux-unix/tr-command-in-unix-linux-with-examples/
Get everything not starting with >, get rid of newlines, wordcount characters

grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | tr -d "\n" | wc -m
119668634

3. How many total lines are in the file?
wc -l GCF_000001735.4_TAIR10.1_genomic.fna
14 GCF_000001735.4_TAIR10.1_genomic.fna

4. How many header lines contain the word "mitochondrion"?
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | grep "mitochondrion" | wc -l
1

5. How many header lines contain the word "chromosome"?
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | grep "chromosome" | wc -l
5

6. How many nucleotides are in each of the first 3 chromosome sequences?
# tried for a while on this to get them all on one line, was hard to figure out and initially had 3 different commands but remembered I can paste them together with this syntax

paste <(grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | head -1 | tail -1 |wc -m) <(grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | head -2 | tail -1 |wc -m) <(grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | head -3 | tail -1 |wc -m)
30427672        19698290        23459831

7. How many nucleotides are in the sequence for 'chromosome 5'? 
grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | head -5 | tail -1 | wc -m
26975503

8. How many sequences contain "AAAAAAAAAAAAAAAA"
grep "AAAAAAAAAAAAAAAA" GCF_000001735.4_TAIR10.1_genomic.fna | wc -l
1

9. If you were to sort the sequences alphabetically, which sequence (header) would be first in that list?
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | sort | head -1
>NC_000932.1 Arabidopsis thaliana chloroplast, complete genome

10. How would you make a new tab-separated version of this file, where the first column is the headers and the second column are the associated sequences?
paste <(grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna) <(grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna)

Output too large to show

NOTE: last instruction is not possible. Online Github repo cannot reflect HPC for assignment_03 because the data file is too big (and even if it were a little smaller, shouldn't we not be putting that in there anyway?). To solve this, in the assignment_03 folder, I had to cd into data, and touch an empty.txt file. Then, I went to the SUPERCOMPUTING directory using cd .. a few times and edited my .gitignore using nano .gitignore and added the data file to be ignored.

# Task 5

My approach to this assignment was pretty similar to my approach to coding assignments in the past, such as creating simple classes and functions in Python to perform tasks. I first think of the output, what it is and what it should look like, and try to work backwards when thinking of how to arrive at the output. Practically, I referenced class notes, the practice we did, the class resource of possible Unix commands, and online search results to figure out the syntax for these tasks. I learned that sort is alphabetical by default, that you find the "opposite" of a thing with grep -v, and that you can translate to delete certain characters with tr -d. I learned that I can use gunzip to unzip this particular kind of file, but I don't know enough about it to be comfortable. 
Paste particularly frustrated me, not in terms of its syntax difficulty, but in terms of how long it took me to arrive at the conclusion that I would need to use it for problem 6. I wish there was (or that I could recall) a nicer way to pick out a particular line from a text file instead of calling the head down to that number, then a tail of 1. Translate was also somewhat surprising because I thought I recalled that the syntax for getting rid of characters would be to translate them to "", but in this case we simply flag -d to delete them. 
These kinds of skills are essential in computational work for two main reasons: firstly, that we must get comfortable so they become second nature ("muscle memory") when we need to apply them. This will save time in the future. Secondly, our comfortability will enable us to apply more creative modifications, analysis, or whatever else we are doing with our data, because the commands/skills applied in this assignment are essentially an expansion of a toolbox of ways to look at and re-arrange data. 




