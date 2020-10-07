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
done < BAZ1B_0/13DirDegs3marksgenes.csv

mkdir BAZ1B_0/13Dir
mv *.out BAZ1B_0/13Dir/

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < BAZ1B_0/17InvDegs3marksgenes.csv

mkdir BAZ1B_0/17Inv
mv *.out BAZ1B_0/17Inv/

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < BAZ1B_0/25InvDegsK27acme3okgenes.csv

mkdir BAZ1B_0/25Inv
mv *.out BAZ1B_0/25Inv/

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < BAZ1B_0/27DirDegsK27acme3okgenes.csv

mkdir BAZ1B_0/27Dir
mv *.out BAZ1B_0/27Dir/

find -size  0 -print -delete

CLAPgene "BAZ1B" > BAZ1B.out

cd ../../..

cat Timeline_project/1_data/BAZ1B/BAZ1B_0/13Dir/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_13Dir
cat Timeline_project/1_data/BAZ1B/BAZ1B_0/17Inv/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_17Inv
cat Timeline_project/1_data/BAZ1B/BAZ1B_0/25Inv/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_25Inv
cat Timeline_project/1_data/BAZ1B/BAZ1B_0/27Dir/*.out >> Timeline_project/1_data/BAZ1B/BAZ1B_0/all_27Dir


Rscript origBAZ1B_plots.R
