library(readr)
library(ggplot2)
library(ggpmisc)
library(gghighlight)
library(ggridges)
library(reshape2)


#Assuming you have the files in place
X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results <- read_csv("200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results",
    col_names = FALSE)
X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results <- read_csv("200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results",
    col_names = FALSE)
X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results <- read_csv("200501_H3K27ac_TC_onlyHuman2497_rsIDs_results",
   col_names = FALSE)
missense_COMBINED <- read_csv("missense_COMBINED.tsv",
  col_names = FALSE)

lenght <- read_csv("lenght", col_names = FALSE)
excess <- read_csv("excess", col_names = FALSE)



p <- NULL
p$missense <- missense_COMBINED$X23
p$enhPCF <- X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results$X23
p$enhCBC <- X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results$X23
p$enhTC  <- X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results$X23
p$excess <- excess$X23
p$lenght <- lenght$X23
p <- melt(p)

pdf("enh_pr_miss_lenght.pdf")
ggplot(p, aes(value*29, colour = L1)) +
  theme_minimal() +
  ggtitle("Enhancers, promoters, missense (squared)") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 50000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 100) +
  coord_cartesian(xlim=c(0, 500000))+
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  scale_y_sqrt()
dev.off()