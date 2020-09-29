#usr/bin/env Rscript

library(tidyverse)

HF_population_freqs <- read_table2("Timeline_project/1_data/HF_population_freqs.txt", 
                                   col_names = FALSE, col_types = cols(X1 = col_character()))

colnames(HF_population_freqs) <- c("location", 
                                   "rsid", 
                                   "global_MAF",
                                   "AFR_MAF",
                                   "AMR_MAF",
                                   "EAS_MAF",
                                   "EUR_MAF",
                                   "SAS_MAF")

filter1 <- 