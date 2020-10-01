library(tidyverse)
library(reshape)

inputplot_pey <- read_csv("peyregne/inputplot_pey", 
                          col_names = FALSE)
hf_COMBINED_clean <- read_csv("peyregne/hf_COMBINED_clean.tsv", 
                              col_names = FALSE)

p <- NULL
p$Peyregne <- inputplot_pey$X23
p$HF <- hf_COMBINED_clean$X23
p <- melt(p)

pdf("peyregne.pdf")
ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  ggtitle("") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count", title = "HF mutations in Peyregne (vs HF file)", color= "File:") +
  scale_color_brewer(palette="Set1") +
  theme(legend.position = "top") +
  scale_y_sqrt() 
dev.off()