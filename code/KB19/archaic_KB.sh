#!/usr/bin/env bash

#Downloads raw files (Martin)
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=19tQMjCfwH9zNHY072IK0ou4LNns8UAXu' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=19tQMjCfwH9zNHY072IK0ou4LNns8UAXu" -O NNaall_positions.tsv && rm -rf /tmp/cookies.txt

mkdir Timeline_project/1_data/archaics_KB
mv NNaall_positions.tsv Timeline_project/1_data/archaics_KB/NNaall_positions.tsv

cd Timeline_project/1_data/archaics_KB/

#Download timing
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

awk '{print $1, $19, $7, $10, $13}' NNaall_positions.tsv  > NNaall_relevantcols.txt

#Altai
awk '{if ($3==1) print $0}' NNaall_relevantcols.txt | grep -P -o 'rs\d*' | grep -w -f - *.csv | grep 'Combined' > Altai_dated

#Vindija
awk '{if ($4==1) print $0}' NNaall_relevantcols.txt | grep -P -o 'rs\d*' | grep -w -f - *.csv | grep 'Combined' > Vindija_dated
 
#Denisova
awk '{if ($5==1) print $0}' NNaall_relevantcols.txt | grep -P -o 'rs\d*' | grep -w -f - *.csv | grep 'Combined' >  Denisova_dated

rm NNaall_relevantcols.txt NNaall_positions.tsv atlas*



cd ../../..
Rscript archaic_KB.R

