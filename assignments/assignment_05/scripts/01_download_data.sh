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
