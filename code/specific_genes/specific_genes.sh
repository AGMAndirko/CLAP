#!/usr/bin/env bash


#Get's as input one argument with a gene name
#F ex: get_gene "FOXP2"
#generates 

get_gene () {
	echo "Downloading Na_high_freq database..."
	wget -q --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv;
	echo "Getting gene result..."
	grep -P $1 Na_high_freq.tsv | grep -P -o "rs\d*" | grep -w -f - Timeline_project/1_data/hf_COMBINED.tsv > $1_results.tsv;
	echo "Done."
	rm Na_high_freq.tsv
	echo "Removed Na_high_freq."
	echo "Result file:"
	echo $1_results;
	Rscript specific_genes_plot.R $1
}

get_gene FOXP2