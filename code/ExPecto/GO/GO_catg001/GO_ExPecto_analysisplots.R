library(tidyverse)
library(biomaRt)
library(reshape2)
library(gprofiler2)

output0_300 <- read_csv("output0_300.csv") 
terms_n_genes <- read_csv("terms_n_genes")

go <- strsplit(terms_n_genes$intersection, ",")
names(go) <- terms_n_genes$term_name
go <- melt(go)
rm(terms_n_genes)

alt <- gconvert(go$value)
table(go$value == alt$input) #true
go$altid <- alt$target
rm(alt)

output <- output0_300 %>% 
  dplyr::select(9,13,18,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 52, 71, 146, 155, 171, 196, 197, 199, 219)

output <- melt(output)
output <- aggregate(output$value, by = list(output$gene, output$variable), sum)

colnames(output) <- c("altid","tissue", "value")
combined <- merge(go, output, by.x = "altid", by.y="altid")
colnames(combined) <- c("gene", "gene2", "term", "tissue", "value")

test <- combined %>% 
  group_by(term) %>% 
  summarize(sum = sum(value))

#Quantile / quantile distribution
ggplot(test, aes(sample=sum)) + 
  theme_minimal() +
  ggtitle("Q-Q plot - extreme value skewedness", subtitle = "ExPecto predictions (GO terms - 0-300)") +
  geom_qq() +
  stat_qq_line()
  
test <- combined %>% 
  group_by(tissue) %>% 
  summarize(sum = sum(value))

ggplot(test, aes(x = sum, , y = tissue)) + 
  theme_minimal() +
  ggtitle("Abs value of expression in GO-enriched genes", subtitle = "By tissue (0-300kya)") +
  geom_col()
