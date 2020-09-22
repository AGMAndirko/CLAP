#!/usr/bin/env bash

mkdir Timeline_project/1_data/RNAseq
cd Timeline_project/1_data/RNAseq

echo "Downloading data..."
wget -q http://human.brain-map.org/api/v2/well_known_file_download/278447594 --show-progress
gzip -d rnaseq_donor9861.zip 
ark --batch 278447594
cd ../../..

Rscript heatmaps_1.R

mv Rplots.pdf DE_controls.pdf