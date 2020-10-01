library(tidyverse) 
library(reshape2)

AFR10nonAFR01_Combined <- read_csv("AFR10nonAFR01_Combined.csv", 
                                   col_names = FALSE)

AFR03nonAFR10_Combined <- read_csv("AFR03nonAFR10_Combined.csv")

hf_COMBINED <- read_csv("Timeline_project/1_data/hf_COMBINED.tsv", 
                        col_names = FALSE)

hf_strictCOMBINED <- read_csv("Timeline_project/1_data/hf_strictCOMBINED.tsv", 
                              col_names = FALSE)

p <- NULL
p$`10% AFR, 1% non AFR` <- AFR10nonAFR01_Combined$X23
p$`3% AFR, 10% non AFR` <- AFR03nonAFR10_Combined$X23
p$HF <- hf_COMBINED$X23
p$`HF strict` <- hf_strictCOMBINED$X23
p <- melt(p)

pdf("population_filters.pdf")
ggplot(p, aes(value*29, group = L1, color = L1))+
  theme_minimal() +
  ggtitle("Populations filters") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 100) +
  labs(x = "Years", y = "Variant count", color = "Filter")
dev.off()