library(readr)
library(ggplot2)
library(ggpmisc)
library(gghighlight)
library(ggridges)
library(reshape2)
library(gridExtra)


#Assuming you have the files in place
X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results <- read_csv("~/enhancer_data/200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results",
                                                            col_names = FALSE)
X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results <- read_csv("~/enhancer_data/200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results",
                                                            col_names = FALSE)
X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results <- read_csv("~/enhancer_data/200501_H3K27ac_TC_onlyHuman2497_rsIDs_results",
                                                           col_names = FALSE)
missense_COMBINED <- read_csv("missense_COMBINED.tsv",
                              col_names = FALSE)

p <- NULL
p$missense <- missense_COMBINED$X23
p$enhPCF <- X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results$X23
p$enhCBC <- X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results$X23
p$enhTC  <- X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results$X23
p <- melt(p)

#Independent plots
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


pdf("missense_dist.pdf")
ggplot(missense_COMBINED, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF Missense")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()


pdf("PFC_dist.pdf")
ggplot(X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF PFC")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()

pdf("TC_dist.pdf")
ggplot(X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF TC")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()

pdf("CBL_dist.pdf")
ggplot(X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF CBL")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()

#Four plots
p1 <- ggplot(missense_COMBINED, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF Missense")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))

p2 <- ggplot(X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF PFC")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))

p3 <- ggplot(X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF TC")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))

p4 <- ggplot(X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results, aes(X23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 30)+ylab("Count")+xlab("Years")+ggtitle("HF CBL")+
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))

grid.arrange(p1, p2, p3, p4, nrow = 2)

#Counting SNPs

library(dplyr)
t1 <- filter(X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results, between(X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results$X23*29, 0, 250000))
t11 <- filter(X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results, between(X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results$X23*29, 750000, 1500000))

t2 <- filter(X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results, between(X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results$X23*29, 0, 250000))
t22 <- filter(X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results, between(X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results$X23*29, 750000, 1500000))

t3 <- filter(X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results, between(X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results$X23*29, 0, 250000))
t33 <- filter(X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results, between(X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results$X23*29, 750000, 1500000))

t4 <- filter(missense_COMBINED, between(missense_COMBINED$X23*29, 0, 250000))
t44 <- filter(missense_COMBINED, between(missense_COMBINED$X23*29, 750000, 1500000))

#Percentage left vs right
print(paste0("Cerebellum: ", nrow(t1)/nrow(t11)*100))
print(paste0("PFC: ", nrow(t2)/nrow(t22)*100))
print(paste0("TC: ", nrow(t3)/nrow(t33)*100))
print(paste0("Missense: ", nrow(t4)/nrow(t44)*100))

#Percentage right vs total
print(paste0("Cerebellum: ", nrow(t11)/nrow(X200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results)*100))
print(paste0("PFC: ", nrow(t22)/nrow(X200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results)*100))
print(paste0("TC: ", nrow(t33)/nrow(X200501_H3K27ac_TC_onlyHuman2497_rsIDs_results)*100))
print(paste0("Missense: ", nrow(t44)/nrow(missense_COMBINED)*100))