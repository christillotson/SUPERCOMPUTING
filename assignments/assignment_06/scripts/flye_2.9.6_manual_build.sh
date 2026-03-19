#!/bin/bash
set -ueo pipefail

program_dir="$HOME/programs"

cd $program_dir

# added while making pipeline so it removes any old flye
rm -rf Flye

git clone https://github.com/fenderglass/Flye
cd Flye
make
