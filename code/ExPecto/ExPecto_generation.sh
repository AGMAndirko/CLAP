#!/usr/bin/env bash

cd Timeline_project/1_data
git clone https://github.com/FunctionLab/ExPecto.git
cd ExPecto
echo "Downloading resources:"
wget -q http://deepsea.princeton.edu/media/code/expecto/resources_20190807.tar.gz --show-progress
tar xf resources_20190807.tar.gz

echo "IMPORTANT:"
echo "ExPecto has some python library dependencies."
echo "We suggest you just run the code to the point of chromatin prediction, and there Python should inform you of what is missing"

#Divided pseudo-vcf files
cd ../../..
echo "Creating pseudoVCFs per time window..."

Rscript divide_vars.R

#takes as input a list of variants in pseudovcf, transforms them in tab-separated proper vcfs
cd Timeline_project/1_data/ExPecto

echo "Cleaning pseudoVCFs..."
clean_psVCF (runs, runname) {
	sed 's/\,/\t/g' runs | awk '{print $2, $3, "-", $4, $5}' | sed 's/\s/\t/g' | awk FNR-1 > temp && mv temp $runname.vcf
}

clean_psVCF(run1.vcf, 'run060')
clean_psVCF(run2.vcf, 'run60100')
clean_psVCF(run3.vcf, 'run100200')
clean_psVCF(run4.vcf, 'run100200')
clean_psVCF(run5.vcf, 'run300500')
clean_psVCF(run6.vcf, 'run500800')
rm run1.vcf run2.vcf run3.vcf run4.vcf run5.vcf run6.vcf
echo "Done"
echo ""
echo "Organizing in folders..."
#Organize 
mkdir run1 && mv run060.vcf run1/run060.vcf
mkdir run2 && mv run60100.vcf run2/run60100.vcf
mkdir run3 && mv run100200.vcf run3/run100200.vcf
mkdir run4 && mv run200300.vcf run4/run200300.vcf
mkdir run5 && mv run300500.vcf run5/run300500.vcf
mkdir run6 && mv run50080.vcf run6/run50080.vcf
echo "Done"
echo ""
echo "Runnin chromatin prediction - this might take a ~10h per file time in your computer"
#TIMEFRAME:
#0 - 60
python chromatin.py run1/run060.vcf
#60 - 100
python chromatin.py run2/run60100.vcf
#100 - 200
python chromatin.py run3/run100200.vcf
#200 - 300
python chromatin.py run4/run200300.vcf
#300 - 500
python chromatin.py run5/run300500.vcf
#500 - 800 // Longest list, takes some time
python chromatin.py run6/run500800.vcf
echo "Done!"

#gets closest gene and TSS 
closest-features --delim '\t' --closest --dist <(awk '{printf $1"\t"$2-1"\t"$2"\n"}' ./run1/run060.vcf|sed s/chr//g|sed s/^/chr/g|sort-bed - ) ./resources/geneanno.pc.sorted.bed > ./run1/run060.vcf.bed.sorted.bed.closestgene

closest-features --delim '\t' --closest --dist <(awk '{printf $1"\t"$2-1"\t"$2"\n"}' ./run2/run60100.vcf|sed s/chr//g|sed s/^/chr/g|sort-bed - ) ./resources/geneanno.pc.sorted.bed > ./run2/run60100.vcf.bed.sorted.bed.closestgene

closest-features --delim '\t' --closest --dist <(awk '{printf $1"\t"$2-1"\t"$2"\n"}' ./run3/run100200.vcf|sed s/chr//g|sed s/^/chr/g|sort-bed - ) ./resources/geneanno.pc.sorted.bed > ./run1/run100200.vcf.bed.sorted.bed.closestgene

closest-features --delim '\t' --closest --dist <(awk '{printf $1"\t"$2-1"\t"$2"\n"}' ./run4/run200300.vcf|sed s/chr//g|sed s/^/chr/g|sort-bed - ) ./resources/geneanno.pc.sorted.bed > ./run4/run200300.vcf.bed.sorted.bed.closestgene

closest-features --delim '\t' --closest --dist <(awk '{printf $1"\t"$2-1"\t"$2"\n"}' ./run5/run300500.vcf|sed s/chr//g|sed s/^/chr/g|sort-bed - ) ./resources/geneanno.pc.sorted.bed > ./run5/run300500.vcf.bed.sorted.bed.closestgene

closest-features --delim '\t' --closest --dist <(awk '{printf $1"\t"$2-1"\t"$2"\n"}' ./run6/run500800.vcf|sed s/chr//g|sed s/^/chr/g|sort-bed - ) ./resources/geneanno.pc.sorted.bed > ./run6/run500800.vcf.bed.sorted.bed.closestgene

echo "Running ExPecto. This might take hours as well"
python predict.py --coorFile ./run1/run060.vcf --geneFile ./run1/run060.vcf.bed.sorted.bed.closestgene --snpEffectFilePattern ./run1/run060.vcf.shift_SHIFT.diff.h5 --modelList ./resources/modellist --output output060.csv
python predict.py --coorFile ./run2/run60100.vcf --geneFile ./run2/run60100.vcf.bed.sorted.bed.closestgene --snpEffectFilePattern ./run2/run60100.vcf.shift_SHIFT.diff.h5 --modelList ./resources/modellist --output output60100.csv
python predict.py --coorFile ./run3/run100200.vcf --geneFile ./run3/run100200.vcf.bed.sorted.bed.closestgene --snpEffectFilePattern ./run3/run100200.vcf.shift_SHIFT.diff.h5 --modelList ./resources/modellist --output output100200.csv
python predict.py --coorFile ./run4/run200300.vcf --geneFile ./run4/run200300.vcf.bed.sorted.bed.closestgene --snpEffectFilePattern ./run4/run200300.vcf.shift_SHIFT.diff.h5 --modelList ./resources/modellist --output output200300.csv
python predict.py --coorFile ./run5/run300500.vcf --geneFile ./run5/run300500.vcf.bed.sorted.bed.closestgene --snpEffectFilePattern ./run5/run300500.vcf.shift_SHIFT.diff.h5 --modelList ./resources/modellist --output output300500.csv
python predict.py --coorFile ./run6/run500800.vcf --geneFile ./run6/run500800.vcf.bed.sorted.bed.closestgene --snpEffectFilePattern ./run6/run500800.vcf.shift_SHIFT.diff.h5 --modelList ./resources/modellist --output output500800.csv
echo "Done!"

Rscript