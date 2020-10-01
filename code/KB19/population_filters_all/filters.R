#usr/bin/env Rscript

library(tidyverse)

HF_population_freqs <- read_table2("population_freqs.txt", 
                                   col_names = FALSE, col_types = cols(X1 = col_character()))

colnames(HF_population_freqs) <- c("location", 
                                   "rsid", 
                                   "global_MAF",
                                   "AFR_MAF",
                                   "AMR_MAF",
                                   "EAS_MAF",
                                   "EUR_MAF",
                                   "SAS_MAF")

HF_population_freqs$AFR_MAF <- as.numeric(HF_population_freqs$AFR_MAF)
HF_population_freqs$EAS_MAF <- as.numeric(HF_population_freqs$EAS_MAF)
HF_population_freqs$EUR_MAF <- as.numeric(HF_population_freqs$EUR_MAF)
HF_population_freqs$SAS_MAF <- as.numeric(HF_population_freqs$SAS_MAF)
HF_population_freqs$AMR_MAF <- as.numeric(HF_population_freqs$AMR_MAF)


HF_population_freqs <- HF_population_freqs %>% 
  mutate(nonAFR = (AMR_MAF + SAS_MAF + EUR_MAF + EAS_MAF)/4)
filter1 <- HF_population_freqs %>% 
  filter(AFR_MAF <= 0.03, nonAFR <= 0.1)
#  filter (<10% for non-africans, <3% for africans)

filter2 <- HF_population_freqs %>% 
  filter(AFR_MAF <= 0.1, nonAFR <= 0.01)
#<10 AFR & <1 non−AFR

table(filter2$rsid %in% filter1$rsid)
#16164/16579 divergent, 25573 common snps 

write.csv(filter1, "AFR03nonAFR10.csv")
write.csv(filter2, "AFR10nonAFR01.csv")
