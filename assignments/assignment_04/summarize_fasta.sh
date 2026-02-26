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
