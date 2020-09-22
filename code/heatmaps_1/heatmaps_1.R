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

#Time picking: automatized with function if changed
time_n_DE <- function(time1, time2) { 
  hf$X1 <- str_replace(hf$X1, ".*csv:", "")
  chunk1 <- hf %>% 
    filter(hf$X23*29 >= time1, hf$X23*29 <= time2)
  
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
  
  #Design matrix with structures
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
}

# Change according to tissue to test - or automatize with function ideally, if included
con <- makeContrasts(structureCbCx-(structureCgG+
                                        structureFL+
                                        structureGP+
                                        structureIns+
                                        structureOL+
                                        structurePHG+
                                        structurePL+
                                        structureStr+
                                        structureTL)/9, levels=designMat)

#DE pipeline 
DEpipeline <- function(tissue, time) {
  fit <- glmQLFit(dgList, designMat, robust=TRUE)
  tr <- glmTreat(fit, contrast=con, lfc=log2(2))
  topTags(tr)
  summary(decideTests(tr))
  #Plot deGenes (different cuttoff from topDE below)
  deGenes <- decideTestsDGE(tr, p=0.0001, adjust.method = "BH")
  deGenes <- rownames(tr)[as.logical(deGenes)]
  plotSmear(tr, de.tags=deGenes) #plot DEgenes!
  abline(h=c(-1, 1), col=2)
  coeffs <- as.data.frame(tr$coefficients)
  coeffs <-  coeffs %>% 
    rownames_to_column('gene') 
  heatinp <- coeffs %>% 
    dplyr::filter(gene %in% deGenes)
  rownames(heatinp) <- heatinp[, 1] 
  heatinp <- heatinp [, -1]
  row.order <- hclust(dist(heatinp))$order
  col.order <- hclust(dist(t(heatinp)))$order
  heatinp <- heatinp[row.order, col.order]
  #	format for melting again
  heatinp <-  heatinp %>% 
    rownames_to_column('gene') 
  heatinp <- reshape2::melt(heatinp)
  heatinp$variable <- str_replace(heatinp$variable, "structureCbCx","Cerebellum Cortex")
  heatinp$variable <- str_replace(heatinp$variable, "structureCgG","Cingulate gyrus")
  heatinp$variable <- str_replace(heatinp$variable, "structureFL","Frontal lobe")
  heatinp$variable <- str_replace(heatinp$variable, "structureGP","Globus Pallidus")
  heatinp$variable <- str_replace(heatinp$variable, "structureIns","Insula")
  heatinp$variable <- str_replace(heatinp$variable, "structureOL","Occipital lobe")
  heatinp$variable <- str_replace(heatinp$variable, "structurePHG","Parahippocampal Gyrus")
  heatinp$variable <- str_replace(heatinp$variable, "structurePL","Parietal lobe")
  heatinp$variable <- str_replace(heatinp$variable, "structureStr","Striatum")
  heatinp$variable <- str_replace(heatinp$variable, "structureTL","Temporal lobe")
  #heatinp$gene <- factor(heatinp$gene, levels = levels(row.order), ordered = TRUE)
  ggplot(data = heatinp, aes(x = gene , y = variable, fill = value)) +
    geom_raster() +
    labs(x = "Genes", y = "Structures", title = "Brain Allen atlas heatmap", fill = "Coefficient GLM") +
    scale_fill_distiller(palette = "RdYlBu") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          axis.text.y = element_text(hjust = 1)) +
    ggtitle(paste0(tissue,"  DE ", time))
}

#Actually calling the functions:
time_n_DE(0,60000)
DEpipeline("Cerebellum","0-60k")
