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
SRATOOLKIT_BIN=$(find "$PROGRAMS_DIR" -maxdepth 2 -type d -name "bin" | grep -E "sratoolkit\.[0-9]+\.[0-9]+\.[0-9]+-ubuntu64" | head -1)

export PATH=$PATH:"$SRATOOLKIT_BIN"
