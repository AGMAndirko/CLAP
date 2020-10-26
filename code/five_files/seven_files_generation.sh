#!/usr/bin/env bash

cd Timeline_project/1_data
   
#Downloads files for peyregné and deserts
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1UmwGxZpXBWH_dyJUM9so4hY8ZPP5MMLY' -O pey_coords.bed
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1R4psn9jt-naA8GYIzuxB3YM0aD3nDfNl' -O deserts.bed
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S5qf9z2N5PuUaik1iWVz7BBwAlM6OZu-' -O deserts_akey2020.bed

awk '{print "chr"$2"\t"$3-1"\t"$3"\t"$1}' hf_COMBINED.tsv | sed 's/,//g' | sort | sed 's/raw\/.*csv\://g' > coordsHF.bed
# $3-1 because bed files are 0-based: the first snp is in position 0. Explained here: https://bedtools.readthedocs.io/
     
bedtools intersect -a coordsHF.bed -b pey_coords.bed | awk '{print $4}' | sed 's/.*csv\://g' > pey_rsids
bedtools intersect -a coordsHF.bed -b deserts.bed | awk '{print $4}' | sed 's/.*csv\://g' > desert_rsids
bedtools intersect -a coordsHF.bed -b deserts_akey2020.bed | awk '{print $4}' | sed 's/.*csv\://g' > deserts_akey2020_rsids
rm pey_coords.bed deserts.bed coordsHF.bed deserts_akey2020.bed

sed 's/.*csv\://g' hf_COMBINED.tsv > hf_COMBINED_clean.tsv

grep -w -f pey_rsids hf_COMBINED_clean.tsv > inputplot_pey
grep -w -f desert_rsids hf_COMBINED_clean.tsv > inputplot_desert
grep -w -f deserts_akey2020_rsids hf_COMBINED_clean.tsv > inputplot_akeydes

awk '{print $1}' Nsignificant_humHF_excess.tsv | tail -n +1 | grep -wv "T" | grep -wv "gene" | grep -wf - Na_high_freq.tsv | grep -Po 'rs\d*' | grep -wf - hf_COMBINED_clean.tsv > dated_excess
awk '{print $1}' Nsignificant_humHFbyLength.tsv | tail -n +1 | grep -wv "T" | grep -wv "gene" | grep -wf - Na_high_freq.tsv | grep -Po 'rs\d*' | grep -wf - hf_COMBINED_clean.tsv > dated_lenght


rm pey_rsids desert_rsids deserts_akey2020_rsids
cd ../..
Rscript seven_files_plots_stats.R