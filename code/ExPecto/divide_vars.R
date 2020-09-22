#!/usr/bin/env Rscript

rm(list=ls())

#Import HF
hf <- read_csv("1_data/hf_COMBINED.tsv", col_names = FALSE)

hf$X1 <- str_replace(hf$X1, ".*csv:", "")

chunk1 <- hf %>% 
filter(hf$X23*29 <= 60000)

chunk2 <- hf %>% 
filter(X23*29 >= 60000 & X23*29 <= 100000)

chunk3 <- hf %>% 
filter(X23*29 >= 100000 & X23*29 <= 200000)

chunk4 <- hf %>% 
filter(X23*29 >= 200000 & X23*29 <= 300000)

chunk5 <- hf %>% 
filter(X23*29 >= 300000 & X23*29 <= 500000)

chunk6 <- hf %>% 
filter(X23*29 >= 500000 & X23*29 <= 800000)


write.csv(chunk1, "Timeline_project/1_data/ExPecto/run1.vcf")
write.csv(chunk2, "Timeline_project/1_data/ExPecto/run2.vcf")
write.csv(chunk3, "Timeline_project/1_data/ExPecto/run3.vcf")
write.csv(chunk4, "Timeline_project/1_data/ExPecto/run4.vcf")
write.csv(chunk5, "Timeline_project/1_data/ExPecto/run5.vcf")
write.csv(chunk6, "Timeline_project/1_data/ExPecto/run6.vcf") 
