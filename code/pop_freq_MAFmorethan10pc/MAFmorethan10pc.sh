#!/usr/bin/env bash

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mtd-feRUhXLhm5oJOvH7C0LKaRR98BID' -O Na_high_freq.tsv
grep MAF\=.\:0\.1 Na_high_freq.tsv > filteredout
grep MAF\=.\:0\.2 Na_high_freq.tsv >> filteredout
grep MAF\=.\:0\.3 Na_high_freq.tsv >> filteredout
grep MAF\=.\:0\.4 Na_high_freq.tsv >> filteredout
grep MAF\=.\:0\.5 Na_high_freq.tsv >> filteredout
grep MAF\=.\:0\.6 Na_high_freq.tsv >> filteredout
grep MAF\=.\:0\.7 Na_high_freq.tsv >> filteredout
grep MAF\=.\:0\.8 Na_high_freq.tsv >> filteredout
grep MAF\=.\:0\.9 Na_high_freq.tsv >> filteredout
rm Na_high_freq.tsv

sed 's/|/\t/g' filteredout | grep -o "...\_MAF\=.\:0\.[1-9]" > difference_HFstrict_Hfnormal.txt

#Print number of instances of each in a file 
echo "Populations that have more than 10% in their MAF (ie, contained in HF but not HF_strict)"
echo ""
echo "AFR:"
grep AFR difference_HFstrict_Hfnormal.txt | wc -l
echo ""
echo "SAS:"
grep SAS difference_HFstrict_Hfnormal.txt | wc -l
echo ""
echo "EAS:"
grep EAS difference_HFstrict_Hfnormal.txt | wc -l
echo ""
echo "EUR:"
grep EUR difference_HFstrict_Hfnormal.txt | wc -l
echo ""
echo "AMR:"
grep AMR difference_HFstrict_Hfnormal.txt | wc -l


rm difference_Hf* filteredout difference_HFstrict_Hfnormal.txt 
