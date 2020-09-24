#!/usr/bin/env Rscript

library(readr)
library(tidyverse)

plotinp <- read_table2("Timeline_project/1_data/introgression/rinput", 
                        col_names = FALSE)


pdf("both_neand.pdf")
ggplot(plotinp, aes(X2*29,  group =X1, colour = X1))+
  theme_minimal() +
  ggtitle("Neanderthal and denisovan introgressed variants", subtitle = "Vernot & Sankarararaman no filters - squared") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count") +
  scale_y_sqrt() 
dev.off()

