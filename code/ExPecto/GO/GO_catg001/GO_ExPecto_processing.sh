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

echo "Enrichment done - now for Expecto analysis"
git clone https://github.com/FunctionLab/ExPecto.git
cd ExPecto
echo "Downloading resources:"
wget -q http://deepsea.princeton.edu/media/code/expecto/resources_20190807.tar.gz --show-progress
tar xf resources_20190807.tar.gz

echo "moving files"
mv hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS ExPecto/hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS
mv hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS ExPecto/hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS
mv hf_COMBINED_300_500kya_only_rsIDs_RESULTS ExPecto/hf_COMBINED_300_500kya_only_rsIDs_RESULTS

cd ExPecto

echo "Cleaning pseudoVCFs..."
clean_psVCF () {
	sed 's/\,/\t/g' $1 | awk '{print "chr"$1, "-", $4, $5}' | sed 's/\:/\t/g' | sed 's/ /\t/g'> temp && mv temp $1.vcf
}
 
clean_psVCF hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS
clean_psVCF hf_COMBINED_300_500kya_only_rsIDs_RESULTS
clean_psVCF hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS
echo "Done"
echo ""
echo "Organizing in folders..."
mkdir 0_300k && mv hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS.vcf 0_300k/hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS
mkdir 300_500k && mv hf_COMBINED_300_500kya_only_rsIDs_RESULTS.vcf 300_500k/hf_COMBINED_300_500kya_only_rsIDs_RESULTS
mkdir 500_1m && mv hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS.vcf 500_1m/hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS


echo "Chromatin predition process"
#NOTE: this should run, but in the event it doesn't due to system requirements, dividing the files in equal sizes (6000 variants is manageable) helps
python chromatin.py 0_300k/hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS
python chromatin.py 0_300k/hf_COMBINED_300_500kya_only_rsIDs_RESULTS
python chromatin.py 0_300k/hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS
echo "First done!"

#and the rest of the expecto process. Not running here because it takes ages. Imagine an output called output0_300.csv (which is the result of just cat-ting the relevant outputs of the expecto code)
#checking the genes and crossing this against GO Categories
awk -F, '{print $3":"$4}' output0_300.csv | tail -n+2 | sed 's/ /\t/g' | grep -wf -  Na_high_freq.tsv | awk '{print $1, $3}' > locations_genes
#
csvcut --columns term_name,intersection hf_COMBINED_0_300kya_only_rsIDs_RESULTS_enrich001.csv > terms_n_genes0300
csvcut --columns term_name,intersection hf_COMBINED_300_500kya_only_rsIDs_RESULTS_enrich001.csv > terms_n_genes300500
csvcut --columns term_name,intersection hf_COMBINED_500_800kya_only_rsIDs_RESULTS_enrich001.csv > terms_n_genes500800
# 4 variants lost