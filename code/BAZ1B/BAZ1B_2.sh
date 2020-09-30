#!/usr/bin/env bash


cd Timeline_project/1_data
mkdir BAZ1B
cp hf_COMBINED.tsv BAZ1B/hf_COMBINED.tsv

#Once we have permission, host the BAZ1B files here maybe - I'll just assume the'll be in this script

cd BAZ1B && wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv

CLAPing () {
	grep -w -f $1 Na_high_freq.tsv | grep -P -o "rs\d*" >  $1.temp;
	grep -w -f $1.temp hf_COMBINED.tsv > $1.out;
	rm $1.temp
}

#just run: CLAPgene "BAZ1B"
CLAPgene () {
	grep -w $1 Na_high_freq.tsv | grep -P -o "rs\d*" >  $1.temp;
	grep -w -f $1.temp hf_COMBINED.tsv > $1.out;
	rm $1.temp
}

CLAPing BoundByBAZ1B_atEnhancers.genes
echo !$ " done"
CLAPing BoundByBAZ1B_atPromoters.genes
echo !$ " done"
CLAPing BoundByBAZ1B_atRegulatoryRegions.genes
echo !$ " done"
CLAPing BoundByBAZ1BbothProm_Enh.genes
echo !$ " done"
CLAPing dk27ac_DIR_atEnh.genes
echo !$ " done"
CLAPing dk27ac_INV_atEnh.genes
echo !$ " done"
CLAPing dk27me3_DIR_atEnh.genes
echo !$ " done"
CLAPing dk27me3_INV_atEnh.genes
echo !$ " done"
CLAPing dk4me1_DIR_atEnh.genes
echo !$ " done"
CLAPing dk4me1_INV_atEnh.genes
echo !$ " done"
CLAPgene BAZ1B
echo !$ " done"

cd ../../..
Rscrip_clap newBAZ1B_plots.R

rm Na_high_freq.tsv 


