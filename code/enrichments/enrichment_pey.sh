#!/usr/bin/env bash

# Na_high_freq_in_Peycoords is the product of crossing Na_high_freq (provided) with the correspondent list of positively selected genes from Peyrégne et al.
grep -P -o "rs\d*" Na_high_freq_in_Peycoords.csv > Na_high_freq_in_Peycoords_only_rsIDs
grep -w -f Na_high_freq_in_Peycoords_only_rsIDs Timeline_project/1_data/hf_COMBINED.tsv > Na_high_freq_in_Peycoords_only_rsIDs_results


#To retrieve gene names in PEY that could be mapped
#grep -P -o "rs\d*" ~/Na_high_freq_in_Peycoords_only_rsIDs_results > ~/Na_high_freq_in_Peycoords_only_rsIDs_resultsMAP
#grep -w -f ~/Na_high_freq_in_Peycoords_only_rsIDs_resultsMAP ~/Na_high_freq.tsv > ~/Na_high_freq_in_Peycoords_only_rsIDs_resultsGENES_NAMES 


Rscript enrichment_pey.R

