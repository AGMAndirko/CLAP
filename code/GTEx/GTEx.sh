#!/usr/bin/env bash

wget https://human.genome.dating/bulk/atlas.chr1.csv.gz
wget https://human.genome.dating/bulk/atlas.chr2.csv.gz
wget https://human.genome.dating/bulk/atlas.chr3.csv.gz
wget https://human.genome.dating/bulk/atlas.chr4.csv.gz
wget https://human.genome.dating/bulk/atlas.chr5.csv.gz
wget https://human.genome.dating/bulk/atlas.chr6.csv.gz
wget https://human.genome.dating/bulk/atlas.chr7.csv.gz
wget https://human.genome.dating/bulk/atlas.chr8.csv.gz
wget https://human.genome.dating/bulk/atlas.chr9.csv.gz
wget https://human.genome.dating/bulk/atlas.chr10.csv.gz
wget https://human.genome.dating/bulk/atlas.chr11.csv.gz
wget https://human.genome.dating/bulk/atlas.chr12.csv.gz
wget https://human.genome.dating/bulk/atlas.chr13.csv.gz
wget https://human.genome.dating/bulk/atlas.chr14.csv.gz
wget https://human.genome.dating/bulk/atlas.chr15.csv.gz
wget https://human.genome.dating/bulk/atlas.chr16.csv.gz
wget https://human.genome.dating/bulk/atlas.chr17.csv.gz
wget https://human.genome.dating/bulk/atlas.chr18.csv.gz
wget https://human.genome.dating/bulk/atlas.chr19.csv.gz
wget https://human.genome.dating/bulk/atlas.chr20.csv.gz
wget https://human.genome.dating/bulk/atlas.chr21.csv.gz
wget https://human.genome.dating/bulk/atlas.chr22.csv.gz

gzip -d *

#First argument: tissue file from Timeline_project/1_data/gtex/
#Second: new filename
GTExCLAP () {
	awk '{print $2}' $1 | grep -w -f - *.csv | grep "Combined" > $2
}

GTExCLAP Timeline_project/1_data/gtex/Adrenal_Gland.v8.signif_variant_gene_pairs.txt.out.rs AdrenalGland
GTExCLAP Timeline_project/1_data/gtex/Brain_Amygdala.v8.signif_variant_gene_pairs.txt.out.rs Amygdala
GTExCLAP Timeline_project/1_data/gtex/Brain_Anterior_cingulate_cortex_BA24.v8.signif_variant_gene_pairs.txt.out.rs BA24
GTExCLAP Timeline_project/1_data/gtex/Brain_Caudate_basal_ganglia.v8.signif_variant_gene_pairs.txt.out.rs Caudate
GTExCLAP Timeline_project/1_data/gtex/Brain_Cerebellar_Hemisphere.v8.signif_variant_gene_pairs.txt.out.rs Cerebellar_Hemisphere
GTExCLAP Timeline_project/1_data/gtex/Brain_Cerebellum.v8.signif_variant_gene_pairs.txt.out.rs erebellum
GTExCLAP Timeline_project/1_data/gtex/Brain_Cortex.v8.signif_variant_gene_pairs.txt.out.rs Cortex
GTExCLAP Timeline_project/1_data/gtex/Brain_Frontal_Cortex_BA9.v8.signif_variant_gene_pairs.txt.out.rs Frontal_Cortex
GTExCLAP Timeline_project/1_data/gtex/Brain_Hippocampus.v8.signif_variant_gene_pairs.txt.out.rs Hippocampus
GTExCLAP Timeline_project/1_data/gtex/Brain_Hypothalamus.v8.signif_variant_gene_pairs.txt.out.rs Hypothalamus
GTExCLAP Timeline_project/1_data/gtex/Brain_Nucleus_accumbens_basal_ganglia.v8.signif_variant_gene_pairs.txt.out.rs Nucleus_accumbens_basal_ganglia
GTExCLAP Timeline_project/1_data/gtex/Brain_Putamen_basal_ganglia.v8.signif_variant_gene_pairs.txt.out.rs Putamen_basal_ganglia
GTExCLAP Timeline_project/1_data/gtex/Brain_Spinal_cord_cervical_c-1.v8.signif_variant_gene_pairs.txt.out.rs Spinal_cord_cervical
GTExCLAP Timeline_project/1_data/gtex/Brain_Substantia_nigra.v8.signif_variant_gene_pairs.txt.out.rs Substantia_nigra
GTExCLAP Timeline_project/1_data/gtex/Pituitary.v8.signif_variant_gene_pairs.txt.out.rs Pituitary

Rscript GTEx.R