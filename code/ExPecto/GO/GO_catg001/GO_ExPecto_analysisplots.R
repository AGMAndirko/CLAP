library(tidyverse)
library(biomaRt)
library(reshape2)
library(gprofiler2)
library(ggrepel)

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

#Now for the cone plots
rm(list = ls())

#Import
output0300 <- read_csv("output0_300.csv")
output300500 <- read_csv("output300_500.csv")
output500800 <- read_csv("output500_800.csv")

#select columns

dataprep <- function (timewindow) {
  output <- timewindow[,-(1:10),drop=FALSE] 
  
  output <- output %>% 
    dplyr::select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) %>% 
    melt()
  output$genes <- timewindow$gene
  
  inp <- aggregate(value ~ genes, output, sum)
  colnames(inp)[2] <- "directionality"
  
  inpm <- aggregate(abs(value) ~ genes, output, sum)
  colnames(inpm)[2] <- "magnitude"
  
  test <- inp$genes == inpm$genes
  FALSE %in% test
  inp$magnitude <- inpm$magnitude
  return(inp)
}

output0300 <- dataprep(output0300)
output300500 <- dataprep(output300500)
output500800 <- dataprep(output500800)

plotinp <- rbind(output0300, output300500, output500800)
plotinp$timing <- c(rep("0 - 300k", nrow(output0300)),
                    rep("300k - 500k", nrow(output300500)),
                    rep("500k - 800k", nrow(output500800)))


#order levels 
plotinp$timing <- factor(plotinp$timing, levels = c("0 - 300k", "300k - 500k", "500k - 800k"))

#clean a bit
rm(output060, output60100, output100200, output200300, output300500, output500800)

genenames<- gconvert(query = plotinp$genes, organism = "hsapiens",
                     target="ENSG", filter_na = FALSE)

test <- genenames$input == plotinp$genes
# Interestingly there are targets here that produce FALSE! 
# No clue why though
FALSE %in% test # should be FALSE
#produces some NA! some ensemble ID genes are not recognized for some reason (71 genes)
#I can live with that
plotinp$genes <- as.character(genenames$name)

#plot like in the Expecto paper!
pdf("GOconeplot.pdf")
ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  ggtitle("GO genes only") +
  geom_point(size = 3) +
  labs(x= "Absolute magnitude of change", y = "Directionality (altternative allele)") +
  geom_label_repel(data = subset(plotinp,  magnitude > 2), colour = "black", nudge_y = 1 ) 
dev.off()

pdf("GOwrapped.pdf")
ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  ggtitle("GO genes only") +
  geom_point(size = 3) +
  labs(x= "Absolute magnitude of change", y = "Directionality (altternative allele)") +
  geom_label_repel(data = subset(plotinp,  magnitude > 2), colour = "black", nudge_y = 1 ) +
  facet_wrap(timing ~ ., ncol = 2)
dev.off()

