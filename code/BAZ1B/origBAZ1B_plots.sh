#!/usr/bin/env bash

#Assuming we have the lists
mkdir Timeline_project/1_data/BAZ1B/orig
# mv them here
cd Timeline_project/1_data/BAZ1B/

CLAPgene () {
	grep -P $1 Na_high_freq.tsv | grep -P -o "rs\d*" | grep -w -f - hf_COMBINED.tsv > $1.res
}

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < orig/BAZ1BboundDEGsinv.txt

mkdir orig/inv && mv *.out orig/inv


while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < orig/BAZ1BboundDEGsdir.txt

mkdir orig/dir && mv *.out orig/dir

Rscript origBAZ1B_plots.R