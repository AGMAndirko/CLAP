library(ggplot2)

#Venn diagram
library(VennDiagram)
library(RColorBrewer)
#0.01
first001 <- read.csv("~/CLAP/code/GOterms/files_001/hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS_enrich001.csv", header=TRUE)
second001 <- read.csv("~/CLAP/code/GOterms/files_001/hf_COMBINED_300_500kya_only_rsIDs_RESULTS_enrich001.csv", header=TRUE)
third001 <- read.csv("~/CLAP/code/GOterms/files_001/hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS_enrich001.csv", header=TRUE)
first001 <- as.data.frame(first001$term_name)
second001 <-as.data.frame(second001$term_name)
third001 <- as.data.frame(third001$term_name)

mycol <- brewer.pal(3, "RdYlBu")
p <- venn.diagram(x = list(first001$`first001$term_name`, second001$`second001$term_name`, third001$`third001$term_name`), category.names = c("0-300kya", "300kya-500kya", "500kya-1mya"), 
                  lwd=2, lty = 'blank', fill=mycol, cex = 1, cat.cex = 1.5, cat.fontface = "bold",cat.pos = c(-27, 27, 135), cat.dist = c(0.055, 0.055, 0.085),filename = NULL)
pdf(file="GOTerms_Venn_001.pdf")
grid.draw(p)
dev.off()
#0.05
first005 <- read.csv("~/CLAP/code/GOterms/files_005/hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS_enrich005.csv", header=TRUE)
second005 <- read.csv("~/CLAP/code/GOterms/files_005/hf_COMBINED_300_500kya_only_rsIDs_RESULTS_enrich005.csv", header=TRUE)
third005 <- read.csv("~/CLAP/code/GOterms/files_005/hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS_enrich005.csv", header=TRUE)

first005 <- as.data.frame(first005$term_name)
second005 <-as.data.frame(second005$term_name)
third005 <- as.data.frame(third005$term_name)

mycol1 <- brewer.pal(3, "Pastel2")
p <- venn.diagram(x = list(first005$`first005$term_name`, second005$`second005$term_name`, third005$`third005$term_name`), category.names = c("0-300kya", "300kya-500kya", "500kya-1mya"), 
                  lwd=2, lty = 'blank',  fill=mycol1, cex = 1, cat.cex = 1.5, cat.fontface = "bold",cat.pos = c(-27, 27, 135), cat.dist = c(0.055, 0.055, 0.085), filename = NULL)
pdf(file="GOTerms_Venn_005.pdf")
grid.draw(p)
dev.off()

#plotEXCterms_KEEG_REAC_WP .01
plotEXCterms_KEEG_REAC_WP <- read.csv("~/CLAP/code/GOterms/files_001/plotEXCterms001_KEEG_REAC_WP.csv", header=FALSE)

plotEXCterms_KEEG_REAC_WP$V11 <- factor(plotEXCterms_KEEG_REAC_WP$V11, levels = plotEXCterms_KEEG_REAC_WP$V11)

ggplot(plotEXCterms_KEEG_REAC_WP, aes(plotEXCterms_KEEG_REAC_WP$V11,plotEXCterms_KEEG_REAC_WP$V1)) +
  geom_point(aes(size = plotEXCterms_KEEG_REAC_WP$V6, colour=plotEXCterms_KEEG_REAC_WP$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms: KEEG; REAC; WP") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=9, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))

#plotEXCterms_GO:BP_CC_MF .01
plotEXCterms_BP_CC_MF <- read.csv("~/CLAP/code/GOterms/files_001/plotEXCterms001_BP_CC_MF.csv", header=FALSE)

plotEXCterms_BP_CC_MF$V11 <- factor(plotEXCterms_BP_CC_MF$V11, levels = plotEXCterms_BP_CC_MF$V11)

ggplot(plotEXCterms_BP_CC_MF, aes(plotEXCterms_BP_CC_MF$V11,plotEXCterms_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_BP_CC_MF$V6, colour=plotEXCterms_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms: KEEG; REAC; WP") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=5, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))

##Top 3 plotEXCterms_GO:BP_CC_MF .01
plotEXCterms_top3_g001_BP_CC_MF <- read.csv("~/CLAP/code/GOterms/files_001/plotEXCterms_top3_g001_BP_CC_MF.csv", header=FALSE)
plotEXCterms_top3_g001_BP_CC_MF$V10 <- factor(plotEXCterms_top3_g001_BP_CC_MF$V10, levels = plotEXCterms_top3_g001_BP_CC_MF$V10)

ggplot(plotEXCterms_top3_g001_BP_CC_MF, aes(plotEXCterms_top3_g001_BP_CC_MF$V10, plotEXCterms_top3_g001_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_top3_g001_BP_CC_MF$V6, colour=plotEXCterms_top3_g001_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms .05: GO:BP_CC_MF") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=10, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))


#plotEXCterms_KEEG_REAC_WP .05
plotEXCterms_g005_KEEG_REAC_WP <- read.csv("~/CLAP/code/GOterms/files_005/plotEXCterms_g005_KEEG_REAC_WP.csv", header=FALSE)

plotEXCterms_g005_KEEG_REAC_WP$V11 <- factor(plotEXCterms_g005_KEEG_REAC_WP$V11, levels = plotEXCterms_g005_KEEG_REAC_WP$V11)

ggplot(plotEXCterms_g005_KEEG_REAC_WP, aes(plotEXCterms_g005_KEEG_REAC_WP$V11,plotEXCterms_g005_KEEG_REAC_WP$V1)) +
  geom_point(aes(size = plotEXCterms_g005_KEEG_REAC_WP$V6, colour=plotEXCterms_g005_KEEG_REAC_WP$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms .05: KEEG; REAC; WP; HPA") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=9, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))


#plotEXCterms_GO:BP_CC_MF .05
plotEXCterms_g005_BP_CC_MF <- read.csv("~/CLAP/code/GOterms/files_005/plotEXCterms_g005_BP_CC_MF.csv", header=FALSE)

plotEXCterms_g005_BP_CC_MF$V11 <- factor(plotEXCterms_g005_BP_CC_MF$V11, levels = plotEXCterms_g005_BP_CC_MF$V11)

ggplot(plotEXCterms_g005_BP_CC_MF, aes(plotEXCterms_g005_BP_CC_MF$V11,plotEXCterms_g005_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_g005_BP_CC_MF$V6, colour=plotEXCterms_g005_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms .05: KEEG; REAC; WP; HPA") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=5, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))


##Top 3 plotEXCterms_GO:BP_CC_MF .05
plotEXCterms_top3_g005_BP_CC_MF <- read.csv("~/CLAP/code/GOterms/files_005/plotEXCterms_top3_g005_BP_CC_MF.csv", header=FALSE)
plotEXCterms_top3_g005_BP_CC_MF$V10 <- factor(plotEXCterms_top3_g005_BP_CC_MF$V10, levels = plotEXCterms_top3_g005_BP_CC_MF$V10)

ggplot(plotEXCterms_top3_g005_BP_CC_MF, aes(plotEXCterms_top3_g005_BP_CC_MF$V10, plotEXCterms_top3_g005_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_top3_g005_BP_CC_MF$V6, colour=plotEXCterms_top3_g005_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=10, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))

