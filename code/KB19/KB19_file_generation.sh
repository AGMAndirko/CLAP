#!/usr/bin/env bash

mkdir Timeline_project && cd Timeline_project #creates home directory for the project


mkdir 1_data
mkdir 2_plots

#Downloads raw files (Martin)
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=19tQMjCfwH9zNHY072IK0ou4LNns8UAXu' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=19tQMjCfwH9zNHY072IK0ou4LNns8UAXu" -O NNaall_positions.tsv && rm -rf /tmp/cookies.txt

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1K7OUi_a91lirJKsaT3KgPDTK7ACGQn1E' -O Nafixed_positions.tsv

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1dKS4HEoB2mj7g2EsR_XKZu-gPimJHjhj' -O hfsapiens.freqfilt.tsv

# Downloads dating of variants from https://human.genome.dating/
# See original article (Albers & McVean, 2020) in https://doi.org/10.1371/journal.pbio.3000586

wget https://human.genome.dating/bulk/atlas.chr1.csv.gz
wget https://human.genome.dating/bulk/atlas.chr2.csv.gz
wget https://human.genome.dating/bulk/atlas.chr3.csv.gz
wget https://human.genome.dating/bulk/atlas.chr4.csv.gz
wget https://human.genome.dating/bulk/atlas.chr5.csv.gz
wget https://human.genome.dating/bulk/atlas.chr6.csv.gz
wget https://human.genome.dating/bulk/atlas.chr7.csv.gz
wget https://human.genome.dating/bulk/atlas.chr8.csv.gz
wget https://human.genome.dating/bulk/atlas.chr9.csv.gz
wget https://human.genome.dating/bulk/atlas.chr10.csv.gz
wget https://human.genome.dating/bulk/atlas.chr11.csv.gz
wget https://human.genome.dating/bulk/atlas.chr12.csv.gz
wget https://human.genome.dating/bulk/atlas.chr13.csv.gz
wget https://human.genome.dating/bulk/atlas.chr14.csv.gz
wget https://human.genome.dating/bulk/atlas.chr15.csv.gz
wget https://human.genome.dating/bulk/atlas.chr16.csv.gz
wget https://human.genome.dating/bulk/atlas.chr17.csv.gz
wget https://human.genome.dating/bulk/atlas.chr18.csv.gz
wget https://human.genome.dating/bulk/atlas.chr19.csv.gz
wget https://human.genome.dating/bulk/atlas.chr20.csv.gz
wget https://human.genome.dating/bulk/atlas.chr21.csv.gz
wget https://human.genome.dating/bulk/atlas.chr22.csv.gz
gzip -d *
cat *.csv > allchr.csv

#For 90% cutoff, no global filtering
  grep -P -o "rs\d*" Na_high_freq.tsv > hf_vars
grep -w -f hf_vars *.csv | grep "Combined" > hf_COMBINED.tsv

#For all variants
grep -P -o "rs\d*" NNaall_positions.tsv > all_vars
grep -w -f all_vars *.csv | grep -P "Combined" > all_COMBINED.tsv

#For 90% cutoff, plus global filtering
grep -P -o "rs\d*" hfsapiens.freqfilt.tsv  > hf_strict_vars
grep -w -f hf_strict_vars *.csv | grep -P "Combined" > hf_strictCOMBINED.tsv

#For fixed
grep -P -o "rs\d*" Nafixed_positions.tsv > fixed_vars
grep -w -f fixed_vars *.csv | grep -P "Combined"> fixed_COMBINED.tsv
#Counts lines of everything to check that we are on the same page here:
wc -l Na_high_freq.tsv hf_vars hf_COMBINED.tsv NNaall_positions.tsv all_vars all_COMBINED.tsv hfsapiens.freqfilt.tsv hf_strict_vars hf_strictCOMBINED.tsv Nafixed_positions.tsv fixed_vars fixed_COMBINED.tsv > lines.txt

#Removes everything but results
#Check that you don't have rm -r as default - otherwise it'll erase everything, including folders

rm !(Timeline_project/*COMBINED*) 

#OR just intermidiate files
#rm hf_vars all_vars hf_strict_vars fixed_vars lines.txt
mv Timeline_project/*.tsv Timeline_project//1_data/

Rscript KB19_distributions.R
mv *.pdf Timeline_project/2_plots
# This folder is then used to send stuff to github in an organized manner