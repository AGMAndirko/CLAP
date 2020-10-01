#!/usr/bin/env bash

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1UmwGxZpXBWH_dyJUM9so4hY8ZPP5MMLY' -O pey_coords.bed

awk '{print "chr"$2"\t"$3-1"\t"$3"\t"$1}' hf_COMBINED.tsv | sed 's/,//g' | sort | sed 's/raw\/.*csv\://g' > coordsHF.bed
# $3-1 because bed files are 0-based: the first snp is in position 0. Explained here: https://bedtools.readthedocs.io/

bedtools intersect -a coordsHF.bed -b pey_coords.bed | awk '{print $4}' | sed 's/.*csv\://g' > pey_rsids

grep -w -f pey_rsids Timeline_project/1_data/hf_COMBINED_clean.tsv > inputplot_pey

