library(ggpmisc)
library(gghighlight)
library(reshape2)
library(kSamples)
library(knitr)
library(tidyverse)

all <- read_csv("Timeline_project/1_data/all_COMBINED.tsv", col_names = FALSE)
hf <- read_csv("Timeline_project/1_data/hf_COMBINED.tsv", col_names = FALSE)
hf_strict <- read_csv("Timeline_project/1_data/hf_strictCOMBINED.tsv", col_names = FALSE)
fixed <- read_csv("Timeline_project/1_data/fixed_COMBINED.tsv", col_names = FALSE)

#The three distributions - squared
pdf(file="3dist_sqrd.pdf")
ggplot(all, aes(X23*29))+
    theme_minimal() +
    ggtitle("All VS 90% non strict (red) VS 90 strict (blue)") +
    scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_freqpoly(stat = "bin", bins = 500) +
    geom_freqpoly(data = hf, aes(X23*29), stat = "bin", bins = 500, colour = "red") +
    geom_freqpoly(data = hf_strict, aes(X23*29), stat = "bin", bins = 500, colour = "blue") +
    labs(x = "Years", y = "Variant count") +
    scale_y_sqrt()
  dev.off()

#Just all
pdf(file="all.pdf")
ggplot(all, aes(X23*29))+
  theme_minimal() +
  ggtitle("All") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) + # 6218702 = max(all$X23*29) 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count") 
dev.off()

# All vs 90 strict
pdf(file="all_HFstr.pdf")
ggplot(all, aes(X23*29))+
  theme_minimal() +
  ggtitle("All (black) VS 90% strict (red)") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 500) +
  geom_freqpoly(data = hf_strict, aes(X23*29), stat = "bin", bins = 500, colour = "red") +
  labs(x = "Years", y = "Variant count")
dev.off()

#All vs 90% non strict
pdf(file="all_HF.pdf")
ggplot(all, aes(X23*29))+
  theme_minimal() +
  ggtitle("All VS 90% non strict (red)") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 500) +
  geom_freqpoly(data = hf, aes(X23*29), stat = "bin", bins = 500, colour = "red") +
  labs(x = "Years", y = "Variant count") +
  scale_y_sqrt()

#90 regular vs hf_strict  
pdf(file="HF_HFstr.pdf")
ggplot(hf, aes(X23*29))+
  theme_minimal() +
  ggtitle("90% regular (black) VS 90% strict (red)") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 500) +
  geom_freqpoly(data = hf_strict, aes(X23*29), stat = "bin", bins = 500, colour = "red") +
  labs(x = "Years", y = "Variant count")

#different genetarion values
hfages <- NULL
hfages$tw <- hf$X23*20
hfages$tw1 <- hf$X23*21
hfages$tw2 <- hf$X23*22
hfages$tw3 <- hf$X23*23
hfages$tw4 <- hf$X23*24
hfages$tw5 <- hf$X23*25
hfages$tw6 <- hf$X23*26
hfages$tw7 <- hf$X23*27
hfages$tw8 <- hf$X23*28
hfages$tw9 <- hf$X23*29
hfages$th <- hf$X23*30
hfages <- as.data.frame(hfages)
hfages <- melt(hfages)

pdf(file="alt_gen_values.pdf")
ggplot(hfages, aes(value, colour = variable))+
  theme_minimal() +
  ggtitle("Years per generation distribution" ) +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count", colour = "Generation time") +
  scale_color_discrete(labels = c("20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"))
dev.off()

# New time period divisions
pdf(file="timing_windows.pdf")
ggplot(hf, aes(X23*29))+
  theme_minimal() +
  ggtitle("Selected time slices") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = c(0, 60000, 100000, 200000, 300000, 500000, 800000)) + # 6218702 = max(all$X23*29) 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count") +
  geom_vline(xintercept = 60000, color = "red") +
  geom_vline(xintercept = 100000, color = "red") +
  geom_vline(xintercept = 200000, color = "red") +
  geom_vline(xintercept = 300000, color = "red") +
  geom_vline(xintercept = 500000, color = "red") +
  geom_vline(xintercept = 800000, color = "red") 
dev.off()

km <- kmeans(hf_strict$X23,centers=4) #Change the numbers after centers to set a different k
hf_strict$cluster <- as.factor(km$cluster)


#Some density histograms with clusters
pdf(file="HFstr_density_clust.pdf")
ggplot(hf_strict, aes(X23*29)) + 
  geom_density(adjust=1/2) +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Measured values")
dev.off()


pdf(file="kmeans_HFstr.pdf")
ggplot(hf_strict, aes(x=X23*29)) +
  ggtitle("K-clustering (using 90% strict)")  +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  #stat_density(geom="line", color="red") +
  geom_histogram(aes(fill=cluster), stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count") 
dev.off()