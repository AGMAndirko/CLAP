library(tidyverse)
library(reshape2)

temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/13Dir/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/13Dir/",temp[i]), header = FALSE))

p <- NULL
p$ABLIM2 <- ABLIM2.out$V23
p$B3GAT1 <- B3GAT1.out$V23
p$BAZ1B <- BAZ1B.out$V23
p$OLFM1 <- OLFM1.out$V23
p$PLXNA4 <- PLXNA4.out$V23
p$PRKCQ <- PRKCQ.out$V23
p$SH3TC1 <- SH3TC1.out$V23
p$SLC6A6 <- SLC6A6.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)
#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_13dir.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B 13 Bona fide - DIR") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()
 
rm(list = ls()) #clean env space
 
temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/17Inv/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/17Inv/",temp[i]), header = FALSE))

p <- NULL
p$CHST15 <- CHST15.out$V23
p$COL12A1 <- COL12A1.out$V23
p$GMPR <- GMPR.out$V23
p$MRC2 <- MRC2.out$V23
p$NR2F2 <- NR2F2.out$V23
p$PHACTR1 <- PHACTR1.out$V23
p$PXDC1 <- PXDC1.out$V23
p$RAB11FIP1 <- RAB11FIP1.out$V23
p$SEMA6A <- SEMA6A.out$V23
p$SLC1A4 <- SLC1A4.out$V23
p$TIAM2 <- TIAM2.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)

#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_17_inv.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B 17 bona fide targets - INV") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()

rm(list = ls()) #clean env space

temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/27Dir/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/27Dir/",temp[i]), header = FALSE))

p <- NULL
p$ABLIM2 <- ABLIM2.out$V23
p$B3GAT1 <- B3GAT1.out$V23
p$C9orf129 <- C9orf129.out$V23
p$DNAJB6 <- DNAJB6.out$V23
p$DPF3 <- DPF3.out$V23
p$ETS2 <- ETS2.out$V23
p$KCNIP1 <- KCNIP1.out$V23
p$OLFM1 <- OLFM1.out$V23
p$PLXNA4 <- PLXNA4.out$V23
p$PRKCQ <- PRKCQ.out$V23
p$RGS3 <- RGS3.out$V23
p$RPRD1B <- RPRD1B.out$V23
p$SCML4 <- SCML4.out$V23
p$SH3TC1 <- SH3TC1.out$V23
p$SLC6A6 <- SLC6A6.out$V23
p$SRC <- SRC.out$V23
p$UQCRFS1 <- UQCRFS1.out$V23
p$VAPA <- VAPA.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)

#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_27_DIR.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B 27 Bona fide - DIR") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()

rm(list = ls())
temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/25Inv/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/25Inv/",temp[i]), header = FALSE))

p <- NULL
p$AACS <- AACS.out$V23
p$CBX4 <- CBX4.out$V23
p$CHST15 <- CHST15.out$V23
p$COL12A1 <- COL12A1.out$V23
p$COL6A3 <- COL6A3.out$V23
p$FAM174B <- FAM174B.out$V23
p$GMPR <- GMPR.out$V23
p$MRC2 <- MRC2.out$V23
p$NR2F2 <- NR2F2.out$V23
p$PHACTR1 <- PHACTR1.out$V23
p$PXDC1 <- PXDC1.out$V23
p$RAB11FIP1 <- RAB11FIP1.out$V23
p$RNF4 <- RNF4.out$V23
p$SEL1L3 <- SEL1L3.out$V23
p$SEMA6A <- SEMA6A.out$V23
p$SLC1A4 <- SLC1A4.out$V23
p$TIAM2 <- TIAM2.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)
#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

  pdf("BAZ1B_25_INV.pdf")
  ggplot(p, aes(value*29, L1)) +
      theme_minimal() +
      ggtitle("BAZ1B 25 Bona fide - INV") +
      scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      geom_point(size = 3, alpha = 0.1) +
      labs(x = "Years", y = "Variant count") +
      theme(legend.position = "top") +
      geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
  dev.off()

  
rm(list = ls())
  
`13Dir` <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_0/all_13Dir", 
                      col_names = FALSE)
`17Inv` <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_0/all_17Inv", 
                    col_names = FALSE)
`25Inv` <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_0/all_25Inv", 
                    col_names = FALSE)
`27Dir` <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_0/all_27Dir", 
                    col_names = FALSE)

p <- NULL
p$`13Dir` <- `13Dir`$X23
p$`17Inv` <- `17Inv`$X23
p$`25Inv` <- `25Inv`$X23
p$`27Dir` <- `27Dir`$X23
p <- melt(p)

model = lm(value ~ L1,
           data=p)

anova(model)
# 0.08031 - not significant variation among the groups

p <- NULL
p$dir <- append(p$dir, `27Dir`$X23)
p$inv <- append(`25Inv`$X23,`17Inv`$X23)
p <- melt(p)

model = lm(value ~ L1,
           data=p)
anova(model)
# Not significant among categories

#From specific genes script
BAZ1B <- read_csv("../Timeline_project/1_data/BAZ1B/BAZ1B_3/BAZ1B.out", 
                  col_names = FALSE)

pdf("BAZ1B_dists.pdf")
ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count", color= "List") +
  theme(legend.position = "top")
dev.off()


pdf("BAZ1B_dots.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top")
dev.off()
  
pdf("BAZ1B_dists_alt.pdf")
ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count", color= "List") +
  theme(legend.position = "top") +
  facet_grid(L1 ~ .) +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "grey")
dev.off()

#How many inv/dir?
filt <- function(input, dirinv, beg, end){
  input %>% 
    filter(L1 == dirinv & value*29 > beg & value*29 < end) %>% 
    count
}

filt(p, "dir", 0, 300000) 
filt(p, "inv", 0, 300000)

filt(p, "dir", 300000, 500000)
filt(p, "inv", 300000, 500000)

filt(p, "dir", 500000, 1000000)
filt(p, "inv", 500000, 1000000)


filt(p, "dir", 1000000, 1300000)
filt(p, "inv", 1000000, 1300000)
