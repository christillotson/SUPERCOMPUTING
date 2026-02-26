#!/bin/bash
# above is shebang I think
set -ueo pipefail

directory_name=$1
num=$(ls -l "$directory_name" | wc -l)

echo "$num"
