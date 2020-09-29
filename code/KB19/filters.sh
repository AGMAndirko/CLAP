#!/usr/bin/env bash

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv

 
awk '{print $1, $19, $2, $32}' Na_high_freq.tsv | sed 's/|/ /g' | sed 's/\b...\_MAF\=.\://g' > HF_population_freqs.txt

Rscript filter.R

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

#For first filter
grep -P -o "rs\d*" AFR03nonAFR10.csv | grep -w -f - atlas.*.csv | grep "Combined" > AFR03nonAFR10_Combined.csv
rm AFR03nonAFR10.csv

#For second filter
grep -P -o "rs\d*" AFR10nonAFR01.csv | grep -w -f - *.csv | grep -P "Combined" > AFR10nonAFR01_Combined.csv
rm AFR10nonAFR01.csv

rm atlas*

Rscript filterplots.R
rm *_Combined*