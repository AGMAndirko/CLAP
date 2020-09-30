 
#!/usr/bin/env bash


cd Timeline_project/1_data/BAZ1B
mkdir BAZ1B_3
cp hf_COMBINED.tsv BAZ1B_3/hf_COMBINED.tsv
cd BAZ1B_3
#Once we have permission, host the BAZ1B files here maybe - I'll just assume the'll be in this script

cd BAZ1B_3 && wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv

CLAPgene () {
	grep -P $1 Na_high_freq.tsv | grep -P -o "rs\d*" | grep -w -f - hf_COMBINED.tsv
}


while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < degsDir.atl2HPTM.genes.txt

mkdir resultsdir
mv *.out resultsdir

while IFS= read -r LINE;do
	CLAPgene "$LINE" > $LINE.out; 
done < degsInv.atl2HPTM.genes.txt

mkdir resultsinv
mv *.out resultsdir

find -size  0 -print -delete

CLAPgene "BAZ1B" > BAZ1B.out


cd ../../..
Rscrip_clap newBAZ1B_plots.R