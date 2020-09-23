#!/usr/bin Rscript

library(reshape2)
library(ggplot2)
library(viridis)

temp = list.files(pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i], header = FALSE))

#Plus import baz1b rsids
HF_selection_BAZ1B_rsIDs_results <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                                             col_names = FALSE)


#'tidy' data structure
p <- NULL
p$'Bound at Enhancers' <- BoundByBAZ1B_atEnhancers.out$V23
p$'Bound at Promoters' <- BoundByBAZ1B_atPromoters.out$V23
p$'Bound at reg. regions' <- BoundByBAZ1B_atRegulatoryRegions.out$V23
p$'Bound at Prom & Enh' <- BoundByBAZ1BbothProm_Enh.out$V23
p$'dk27ac DIR' <- dk27ac_DIR_atEnh.out$V23
p$'dk27ac INV' <- dk27ac_INV_atEnh.out$V23
p$'dk27me3 DIR' <- dk27me3_DIR_atEnh.out$V23
p$'dk27me3 INV' <- dk27me3_INV_atEnh.out$V23
p$'dk4me1 DIR' <- dk4me1_DIR_atEnh.out$V23
p$'dk4me1 INV' <- dk4me1_INV_atEnh.out$V23


p <- melt(p)
p <- as.data.frame(p)

ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count", color= "List") +
  scale_color_brewer(palette="Paired") +
  theme(legend.position = "top") +
  geom_vline(xintercept = HF_selection_BAZ1B_rsIDs_results$X23*29, colour = "black", alpha = 0.5)

ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0,500000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count", color= "List") +
  scale_color_brewer(palette="Paired") +
  theme(legend.position = "top") +
  geom_vline(xintercept = HF_selection_BAZ1B_rsIDs_results$X23*29, colour = "black", alpha = 0.5)
    
ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(1000000,1500000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count", color= "List") +
  scale_color_brewer(palette="Paired") +
  theme(legend.position = "top") +
  geom_vline(xintercept = HF_selection_BAZ1B_rsIDs_results$X23*29, colour = "black", alpha = 0.5) 
