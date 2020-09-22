library(tidyverse)
library(gprofiler2)
library(DESeq2)
library(SummarizedExperiment)
library(edgeR)
library(mosaic)
library(pheatmap)
library(viridis)
library(ggrepel)

rm(list=ls())

#Import HF
hf <- read_csv("Timeline_project/1_data/hf_COMBINED.tsv", col_names = FALSE)


# Import RNAseq Counts
RNAseqCounts <- read_csv("Timeline_project/1_data/RNAseq/RNAseqCounts.csv", col_names = FALSE)
Genes <- read_csv("Timeline_project/1_data/RNAseq/Genes.csv")
SampleAnnot <- read_csv("Timeline_project/1_data/RNAseq/SampleAnnot.csv")

#Time chunks
hf$X1 <- str_replace(hf$X1, ".*csv:", "")
chunk1 <- hf %>% 
  filter(hf$X23*29 <= 60000)

#Search genes in gprofiler from variants
geneschunk1 <- gsnpense(query = chunk1[[1]])
rm(chunk1)
probeselection <- unlist(geneschunk1$gene_names)
datacounts <- RNAseqCounts %>% 
  filter(X1 %in% probeselection) #selects only the desired gene counts
#Note: the gprofiler, gene symbol method loses some genes (from initial 6k mapped variants to 3k genes!)

#Changing genes from column 1 to the row names
genenames <- datacounts[,1]
countDataMatrix <- as.matrix(datacounts[, -1])
rownames(countDataMatrix) <- genenames[[1]]

#Design matrix with structures - cbcx edition
structure <- SampleAnnot$main_structure
designMat <- model.matrix(~0+structure) #+0 to not create intercept
designMat

#EdgeR - CPM
colnames(countDataMatrix) <- SampleAnnot$RNAseq_sample_name
dgList <- DGEList(counts=countDataMatrix, genes=rownames(countDataMatrix), group = SampleAnnot$main_structure)

#filtering by expression
keep <- filterByExpr(dgList, designMat)
table(keep)
dgList <- dgList[keep, , keep.lib.sizes=FALSE]

#CPM
countsPerMillion <- cpm(dgList)
summary(countsPerMillion)

#filtering if CPM too low
countCheck <- countsPerMillion > 1
head(countCheck)
keep <- which(rowSums(countCheck) >= 1)
dgList <- dgList[keep,]
  
#Normalizing
dgList <- calcNormFactors(dgList, method="TMM")
colors <- rep(c("darkgreen", "red", "blue"), 2)
plotMDS(dgList) # a plot with the samples
plotMD(dgList, column=1) #plot an individual sample, number 32 for example
abline(h=0, col="red", lty=2, lwd=2) #with a red line

#Estimate dispersion 
dgList <- estimateGLMCommonDisp(dgList, design=designMat)
dgList <- estimateGLMTrendedDisp(dgList, design=designMat)
dgList <- estimateGLMTagwiseDisp(dgList, design=designMat)
plotBCV(dgList)
