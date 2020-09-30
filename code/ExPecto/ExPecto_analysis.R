library(gwasglue)
library(tidyverse)
library(ieugwasr)
library(magrittr)
library(reshape2)
library(gwasglue)
library(TwoSampleMR)
library(rsnps)

input <- read_csv("Timeline_project/1_data/ExPecto/combinedoutput.csv")

#Here I'm getting all locations affecting brain tissue expression
out <- input[,-(1:10),drop=FALSE]
out <- out %>% 
  select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 
out <- as.data.frame(out)
out <- melt(out, value.name = "beta", variable.name = "Phenotype")

#Beta and phenotype to conform to future TwoSampleMR analysis specifications
#This must give TRUE:
878614/39937 == 22

#Add locations, gene, effect allele
out$locations <- unite(input, `0`, `1`, col = "test", sep = ":") %>% 
  pull(test)
out$gene <- pull(input, var = 9) 
out$effect_allele <- pull(input, var = 6)

#values with high expression
input <- out %>% 
  filter(value >= 0.001)
GO <- gprofiler2::gost(input$genes)
    
