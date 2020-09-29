#!/usr/bin/env bash

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv

 
awk '{print $1, $2, $19, $32}' Na_high_freq.tsv
