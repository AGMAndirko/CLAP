#!/usr/bin/env bash

grep -P -o "rs\d*" 200501_H3K27ac_CBC_onlyHuman1485.csv > 200501_H3K27ac_CBC_onlyHuman1485_rsIDs
grep -w -f 200501_H3K27ac_CBC_onlyHuman1485_rsIDs Timeline_project/1_data/hf_COMBINED.tsv > 200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results

grep -P -o "rs\d*" ~/200501_H3K27ac_PFC_onlyHuman2487.csv > 200501_H3K27ac_PFC_onlyHuman2487_rsIDs
grep -w -f 200501_H3K27ac_PFC_onlyHuman2487_rsIDs Timeline_project/1_data/hf_COMBINED.tsv > 200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results

grep -P -o "rs\d*" 200501_H3K27ac_TC_onlyHuman2497.csv > 200501_H3K27ac_TC_onlyHuman2497_rsIDs
grep -w -f 200501_H3K27ac_TC_onlyHuman2497_rsIDs Timeline_project/1_data/hf_COMBINED.tsv > 200501_H3K27ac_TC_onlyHuman2497_rsIDs_results 

Rscript enrichment_ENH.R