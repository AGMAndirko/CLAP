library(readr)
library(ggplot2)
library(ggrepel)

all <- read_csv("Timeline_project/1_data/all_COMBINED.tsv", col_names = FALSE)

#Lines where McCoy et Al variants lie:
mccoy <- c(546992,208962,61227,935216,778036,1549819)

#All, with Mccoy et al highlighted
pdf("mcCoyetal_snps.pdf")
ggplot(all, aes(X23*29))+
  theme_minimal() +
  ggtitle("Top McCoy et al. (2017) Neanderthal-introgressed \nvariants linked to phenotypes") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0,1600000)) + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count") +
  geom_point(data=all[546992,], aes (x=X23*29, y=125000), colour = "red", size = 3, shape = 15) +
  geom_label_repel(data=all[546992,], aes (x=X23*29, y=125000), 
      label = "rs35370743, rs950169, rs5744258") +
  # geom_point(data=all[208962,], aes (x=X23*29, y=120000), colour = "blue", size = 3, shape = 15) +
  geom_point(data=all[61227,], aes (x=X23*29, y=65000), colour = "blue", size = 3, shape = 15) +
  geom_label_repel(data=all[61227,], aes (x=X23*29, y=65000), label = "rs61854810", nudge_y = 15) +
  geom_point(data=all[935216,], aes (x=X23*29, y=50000), colour = "black", size = 3, shape = 15) +
  geom_label_repel(data=all[935216,], aes (x=X23*29, y=50000), label = "rs2235371", nudge_x = 15) +
  geom_point(data=all[778036,], aes (x=X23*29, y=46000), colour = "darkgreen", size = 3, shape = 15) +
  geom_label_repel(data=all[778036,], aes (x=X23*29, y=46000), label = "rs10418340", nudge_x = 15)
  # geom_point(data=all[1549819,], aes (x=X23*29, y=130000), colour = "orange", size = 3, shape = 15) +
  #    geom_label_repel(data=all[1549819,], aes (x=X23*29, y=130000), label = "test7", nudge_x = 3)
dev.off()  
