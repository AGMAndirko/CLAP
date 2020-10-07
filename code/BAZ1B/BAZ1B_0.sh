#!/usr/bin/env bash

#Assuming we have the lists
mkdir Timeline_project/1_data/BAZ1B/BAZ1B_0
# mv them here
cd Timeline_project/1_data/BAZ1B/

CLAPgene () {
	grep -P $1 Na_high_freq.tsv | grep -P -o "rs\d*" | grep -w -f - hf_COMBINED.tsv
}

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < BAZ1B_0/4D.BAZ1B.fdr01.genes

mkdir BAZ1B_0/4D01
mv *.out BAZ1B_0/4D01/

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < BAZ1B_0/4D.BAZ1B.fdr025.genes

mkdir BAZ1B_0/4D025
mv *.out BAZ1B_0/4D025/

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < BAZ1B_0/Prom.BAZ1B.fdr01.genes

mkdir BAZ1B_0/Prom01
mv *.out BAZ1B_0/Prom01/

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < BAZ1B_0/Prom.BAZ1B.fdr025.genes

mkdir BAZ1B_0/Prom025
mv *.out BAZ1B_0/Prom025/

find -size  0 -print -delete

CLAPgene "BAZ1B" > BAZ1B.out

cd ../../..

cat Timeline_project/1_data/BAZ1B/BAZ1B_0/4D01/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_4D01
cat Timeline_project/1_data/BAZ1B/BAZ1B_0/4D025/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_4D025
cat Timeline_project/1_data/BAZ1B/BAZ1B_0/Prom01/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_Prom01
cat Timeline_project/1_data/BAZ1B/BAZ1B_0/Prom025/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_Prom025


Rscript origBAZ1B_plots.R
