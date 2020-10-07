#!/usr/bin/env Rscript

  library(tidyverse)
  library(magrittr)
  
  plotinp <- read_table2("Timeline_project/1_data/introgression/rinput", 
                          col_names = FALSE)
  plotinp$X1 <- str_replace_all(plotinp$X1, "Sankarararaman", "Sankararaman")
  
  
  pdf("all_neand_intro.pdf")
  ggplot(plotinp, aes(X2*29,  group =X1, colour = X1))+
    theme_minimal() +
    ggtitle("Neanderthal and denisovan introgressed variants", subtitle = "Vernot & Sankararaman no filters - squared") +
    scale_x_continuous(labels = function(x) format(x, scientific = FALSE)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_density(stat = "bin", bins = 500) +
    labs(x = "Years", y = "Variant count") +
    scale_y_sqrt() 
  dev.off()

  pdf("all_neand_intro2.pdf")
  ggplot(plotinp, aes(X2*29,  group =X1, colour = X1))+
    theme_minimal() +
    ggtitle("Neanderthal and denisovan introgressed variants", subtitle = "Vernot & Sankararaman no filters - squared") +
    scale_x_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0, 500000)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_density(stat = "bin", bins = 500) +
    labs(x = "Years", y = "Variant count") +
    scale_y_sqrt() 
  dev.off()
  
sank <- plotinp %>% 
  filter(X1 == "Sankarararaman")

vernot <- plotinp %>% 
  filter(X1 == "Vernot")


ks.test(vernot$X2, sank$X2) 
# < 2.2e-16! that was unexpected