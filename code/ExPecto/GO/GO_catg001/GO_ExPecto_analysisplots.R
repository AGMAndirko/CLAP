library(tidyverse)
#library(biomaRt)
library(reshape2)
library(gprofiler2)
library(ggrepel)

output0_300 <- read_csv("output0_300.csv") 
terms_n_genes <- read_csv("terms_n_genes0300")

go <- strsplit(terms_n_genes$intersection, ",")
names(go) <- terms_n_genes$term_name
go <- melt(go, value.name = "name")
rm(terms_n_genes)

alt <- gconvert(go$name, organism = 'hsapiens', filter_na = FALSE)
#table(go$value == alt$input) #true

match <- alt[4:5] %>% semi_join(go, by=c("name"))
match2 <- go %>% semi_join(alt[4:5], by = c("name"))
table(test$name == go2$name) #true!
match$term <- match2$L1
rm(alt, match2, go)

output <- output0_300 %>% 
  dplyr::select(9,13,18,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 52, 71, 146, 155, 171, 196, 197, 199, 219)

output <- melt(output)
output <- aggregate(output$value, by = list(output$gene, output$variable), sum)

colnames(output) <- c("target","tissue", "value")
combined <- output %>% inner_join(match, by=c("target"))

test <- combined %>% 
  group_by(term) %>% 
  summarize(sum = sum(value))

#Quantile / quantile distribution
ggplot(test, aes(sample=sum)) + 
  theme_minimal() +
  ggtitle("Q-Q plot - value skewedness", subtitle = "GO terms - 0-300kya") +
  geom_qq() +
  stat_qq_line()
  
test <- combined %>% 
  group_by(tissue) %>% 
  summarize(sum = sum(value))

ggplot(test, aes(x = sum,  y = tissue)) + 
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

create_GOtable <- function(timewindow, terms_n_genes) {
  go <- strsplit(terms_n_genes$intersection, ",")
  names(go) <- terms_n_genes$term_name
  go <- melt(go)
  rm(terms_n_genes)
  
  alt <- gconvert(go$value)
  table(go$value == alt$input) #true
  go$altid <- alt$target
  rm(alt)
  
  output <- timewindow %>% 
    dplyr::select(9,13,18,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 52, 71, 146, 155, 171, 196, 197, 199, 219)
  
  output <- melt(output)
  output <- aggregate(output$value, by = list(output$gene, output$variable), sum)
  
  colnames(output) <- c("altid","tissue", "value")
  inp <- aggregate(value ~ altid, output, sum)
  inpm <- aggregate(abs(value) ~ altid, output, sum)
  test <- cbind(inp, inpm)
  colnames(test) <- c("altid", "directionality", "drop", "magnitude")
  combined <- merge(go, test, by.x = "altid", by.y="altid")
  return(combined)
}

terms_n_genes <- read_csv("terms_n_genes0300")
GOoutput0300 <- create_GOtable(output0300, terms_n_genes)
terms_n_genes <- read_csv("terms_n_genes300500")
GOoutput300500 <- create_GOtable(output300500, terms_n_genes)
terms_n_genes <- read_csv("terms_n_genes500800")
GOoutput500800 <- create_GOtable(output500800, terms_n_genes)
rm(output0300, output300500, output500800)

plotinp <- rbind(GOoutput0300, GOoutput300500, GOoutput500800)
plotinp$timing <- c(rep("0 - 300k", nrow(GOoutput0300)),
                    rep("300k - 500k", nrow(GOoutput300500)),
                    rep("500k - 800k", nrow(GOoutput500800)))


#order levels 
plotinp$timing <- factor(plotinp$timing, levels = c("0 - 300k", "300k - 500k", "500k - 800k"))

plotinp <- plotinp %>% 
  dplyr::select(value, directionality, magnitude, timing) %>% 
  unique()
  

#colnames(plotinp) <- c("genes", "directionality", "gene2", "magnitude", "timing")
#plot like in the Expecto paper!
pdf("GOconeplot.pdf")
ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = value)) +
    theme_minimal() +
    ggtitle("GO genes only") +
    geom_point(size = 3) +
    labs(x= "Absolute magnitude of change", y = "Directionality (altternative allele)") +
    geom_label_repel(data = subset(plotinp,  magnitude > 2), colour = "black") 
dev.off()

pdf("GOwrapped.pdf")
ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = value)) +
  theme_minimal() +
  ggtitle("GO genes only") +
  geom_point(size = 3) +
  labs(x= "Absolute magnitude of change", y = "Directionality (altternative allele)") +
  geom_label_repel(data = subset(plotinp,  magnitude > 2), colour = "black") +
  facet_wrap(timing ~ ., ncol = 2)
dev.off()

#Hallmark testing
#Where geneset can be whatever category in:
#https://www.gsea-msigdb.org/gsea/msigdb/genesets.jsp?collection=H
GMT <- function (timewindow, gmtf) {
  id <- upload_GMT_file(gmtfile = paste0(gmtf,".gmt"))
  gost(timewindow$gene, organism = id)
}

GMT(output0300, "notch")
GMT(output300500, "notch")
GMT(output500800, "notch")
GMT(output0300, "oxphos")
GMT(output300500, "oxphos")
GMT(output500800, "oxphos")
GMT(output0300, "TGF")
GMT(output300500, "TGF")
GMT(output500800, "TGF")
GMT(output0300, "WNT")
GMT(output300500, "WNT")
GMT(output500800, "WNT")