#!/usr/bin/env bash


#wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv

Rscript time_filtering.R

CLAPing () {
	grep -P -o "rs\d*" $1 | grep -w -f - Na_high_freq.tsv
}

CLAPing hf_COMBINED_500kya_1mya.csv > hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS
CLAPing hf_COMBINED_0kya_300kya.csv > hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS
CLAPing hf_COMBINED_300kya_500kya.csv > hf_COMBINED_300_500kya_only_rsIDs_RESULTS
rm hf_COMBINED_500kya_1mya.csv hf_COMBINED_0kya_300kya.csv hf_COMBINED_300kya_500kya.csv


Rscript enrich.R