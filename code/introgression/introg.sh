#!/usr/bin/env bash


#Download introgression data
mkdir Timeline_project/1_data/introgression
mkdir Timeline_project/1_data/introgression/vernot


#Vernot:
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9Pc7_zItMCVLWt1NHNvSkRTejg' -O all_tag_snps.SAS.merged.ALL.0.3_R2_cluster.1KG_phase3_essentials.bed
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9Pc7_zItMCVUU0yTjZ4UUdmWkk' -O all_tag_snps.PNG.merged.ALL.0.3_R2_cluster.1KG_phase3_essentials.bed
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9Pc7_zItMCVa2lqWE9Ucm16RU0' -O all_tag_snps.EUR.merged.ALL.0.3_R2_cluster.1KG_phase3_essentials.bed
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9Pc7_zItMCVWlVpTWV4ZlBTcGc' -O all_tag_snps.ASN.merged.ALL.0.3_R2_cluster.1KG_phase3_essentials.bed

#COLUMN LEGEND
#chr
#start
#stop
#Ancestral allele
#Derived allele
#Anc/Der code
#AFA allele frequency
#AFR allele frequency
#AMR allele frequency
#EAS allele frequency
#EUR allele frequency
#PNG allele frequency
#SAS allele frequency
#Neanderthal base
#Denisova base
#haplotype tag

mv all_tag* Timeline_project/1_data/introgression/vernot/

cat Timeline_project/1_data/introgression/vernot/* > Timeline_project/1_data/introgression/vernot/allintro
awk '{print $1, $3}' Timeline_project/1_data/introgression/vernot/allintro | sed 's/"//g' | sed 's/ /, /g' | sed 's/chr//g' | grep -w -f - Timeline_project/1_data/all_COMBINED.tsv > Timeline_project/1_data/introgression/vernot/allintro_dated

#Sankararaman:
wget https://sriramlab.cass.idre.ucla.edu/public/sankararaman.curbio.2016/summaries.tgz

tar -xvf summaries.tgz

rm -r summaries/1 
cd 
#Takes argument "neandertal"
findfilt () {
	find summaries/2/$1/ -name 'pred*' -exec cat {} \; >> uber.txt;
	awk 'NR=27 { if ($11 >= 0.50 && !="?") {print} }' uber.txt > temp;
	rm uber.txt;
	wc -l temp;
}

findfilt neandertal

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
cd ..

tail -n +27 filt.neandintro.txt | awk '{print $1}' | sed 's/\:/, /g' | grep -wf - *.csv | grep 'Combined' > dated_intro_neand

mv dated_intro_neand Timeline_project/1_data/introgression/sankararaman/

#Denisovan
findfilt2 () {
        find summaries/2/$1/*/summaries/haplotypes/ -name '*\.haplotypes' -exec cat {} \; >> uber.txt;
        wc -l uber.txt;
        awk '{ if ($7 >= 0.5) {print} }' uber.txt | awk -F, '{print $1, $3, $4}' | tail -n +4 > filtranges;
        wc -l filtranges;
        head filtranges;
        rm uber.txt;
	sed -i 's/\t/\, /g' filtranges;
	head filtranges;
	tail -n 3 atlas.chr1.csv | awk -F, '{range[$1]=$1; range[$2]=$3; range[$3]=$4} (($2 in range[$1]) && (($3 >= range[$2]) && ($3 <= range[$3]))) {print $0}' - filtranges > test
} 

findfilt2 denisova > dated_intro_deni

#Put all neanderthal introgression files into one
awk '{print "Sankarararaman", $23}' Timeline_project/1_data/introgression/sankararaman/dated_intro_neand > Timeline_project/1_data/introgression/rinput
awk '{print "Vernot", $23}' Timeline_project/1_data/introgression/sankararaman/dated_intro_neand > Timeline_project/1_data/introgression/rinput
rm -r summaries
rm *.csv

Rscript introg_plots.R