library(pheatmap)
library(tidyverse)
library(magrittr)
library(reshape2)
library(factoextra)

input <- read_csv("Timeline_project/1_data/ExPecto/outputall.csv")
out <- input[,-(1:10),drop=FALSE]
out <- out %>% 
  select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 

test <- cor(out, method="pearson")
test <- as.data.frame(test)

#dendogram
d <- dist(test, method = "euclidean")
fit <- hclust(d, method="ward")
pdf("tissues_dendrogram.pdf")
plot(fit) # display dendogram
dev.off()

pdf("expecto_similarity_value.pdf")
pheatmap(test)
dev.off()


