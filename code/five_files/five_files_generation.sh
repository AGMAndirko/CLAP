#!/usr/bin/env bash

cd Timeline_project/1_data
   
#Downloads files for peyregné and deserts
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1UmwGxZpXBWH_dyJUM9so4hY8ZPP5MMLY' -O pey_coords.bed
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1R4psn9jt-naA8GYIzuxB3YM0aD3nDfNl' -O deserts.bed
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lJ6KUT0QPWpsAnTBYcRBTnOxGGG35D_r' -O Na_high_freq_in_Akey2020_results_Akey2020 
sed 's/\/home\/adaleengb\/CBL\_Dating_variants\///g' Na_high_freq_in_Akey2020_results_Akey2020 > temp && mv temp Na_high_freq_in_Akey2020_results_Akey2020 

awk '{print "chr"$2"\t"$3-1"\t"$3"\t"$1}' hf_COMBINED.tsv | sed 's/,//g' | sort | sed 's/raw\/.*csv\://g' > coordsHF.bed
# $3-1 because bed files are 0-based: the first snp is in position 0. Explained here: https://bedtools.readthedocs.io/
     
bedtools intersect -a coordsHF.bed -b pey_coords.bed | awk '{print $4}' | sed 's/.*csv\://g' > pey_rsids
bedtools intersect -a coordsHF.bed -b deserts.bed | awk '{print $4}' | sed 's/.*csv\://g' > desert_rsids
rm pey_coords.bed deserts.bed coordsHF.bed

sed 's/.*csv\://g' hf_COMBINED.tsv > hf_COMBINED_clean.tsv
sed 's/.*csv\://g' Na_high_freq_in_Akey2020_results_Akey2020 > inputplot_akey

grep -w -f pey_rsids hf_COMBINED_clean.tsv > inputplot_pey
grep -w -f desert_rsids hf_COMBINED_clean.tsv > inputplot_desert


rm pey_rsids desert_rsids Na_high_freq_in_Akey2020_results_Akey2020
cd ../..
Rscript five_files_plots.R