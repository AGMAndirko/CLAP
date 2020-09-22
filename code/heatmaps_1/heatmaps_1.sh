#!/usr/bin/env bash

mkdir Timeline_project/1_data/RNAseq
cd Timeline_project/1_data/RNAseq

wget http://human.brain-map.org/api/v2/well_known_file_download/278447594
gzip -d rnaseq_donor9861.zip
cd ../../..

Rscript heatmaps_1.R
