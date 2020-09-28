#!/bin/usr/env Rscript
library(tidyverse)
library(reshape2)
Denisova_dated <- read_csv("Timeline_project/1_data/archaics_KB/Denisova_dated", 
                           col_names = FALSE)

Vindija_dated <- read_csv("Timeline_project/1_data/archaics_KB/Vindija_dated", 
                          col_names = FALSE)

Altai_dated <- read_csv("Timeline_project/1_data/archaics_KB/Altai_dated", 
                             col_names = FALSE)

p <- NULL
p$Altai <- Altai_dated$X23
p$Vindija <- Vindija_dated$X23
p$Denisova <- Denisova_dated$X23
p <- melt(p)

rm(Altai_dated,Vindija_dated,Denisova_dated)

pdf(file="archaics_KB.pdf")
ggplot(p, aes(value*29, group = L1, color = L1))+
  theme_minimal() +
  ggtitle("Archaic ALT alleles (NNaall) - 0 to 3Mll years") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0,3000000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count")
dev.off()
