#!/bin/bash
set -ueo pipefail

./scripts/01_prep_data.sh
# makes raw and clean data directories
# gets data and downloads
# moves all downloaded data into the raw directory
# unpacks data with tar
./scripts/02_get_stats.sh
# runs seqkit stats on data and puts output in output directory
./scripts/03_cleanup.sh
# removes raw data
