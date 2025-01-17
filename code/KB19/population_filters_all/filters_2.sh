#!/usr/bin/env bash 

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=19tQMjCfwH9zNHY072IK0ou4LNns8UAXu' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=19tQMjCfwH9zNHY072IK0ou4LNns8UAXu" -O NNaall_positions.tsv && rm -rf /tmp/cookies.txt

awk '{print $1, $19, $2, $32}' NNaall_positions.tsv  | grep 'rs\d*' | sed 's/|/ /g' | sed 's/\b...\_MAF\=.\://g' > population_freqs.txt

Rscript filters.R

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

awk -F, '{print $3}' AFR03nonAFR10.csv | sed 's/"//g' | grep -wf - NNaall_positions.tsv > AFR03nonAFR10_full
awk -F, '{print $3}' AFR10nonAFR01.csv | sed 's/"//g' | grep -wf - NNaall_positions.tsv > AFR10nonAFR01_full

archaic_filt () {
	awk '{print $1, $19, $7, $10, $13}' $1 > temp
	awk '{if ($3==1) print $0}' temp | grep -P -o 'rs\d*' | grep -w -f - *.csv | grep 'Combined' > Altai_$1
	awk '{if ($4==1) print $0}' temp | grep -P -o 'rs\d*' | grep -w -f - *.csv | grep 'Combined' > Vindija_$1
	awk '{if ($5==1) print $0}' temp | grep -P -o 'rs\d*' | grep -w -f - *.csv | grep 'Combined' >  Denisova_$1
	rm temp
}

archaic_filt AFR03nonAFR10_full
archaic_filt AFR10nonAFR01_full
