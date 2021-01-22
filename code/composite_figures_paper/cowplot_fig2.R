library(ggplot2)
library(VennDiagram)
library(RColorBrewer)
library(cowplot)

#0.01
first001 <- read.csv("CLAP/code/GOterms/files_001/hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS_enrich001.csv", header=TRUE)
second001 <- read.csv("CLAP/code/GOterms/files_001/hf_COMBINED_300_500kya_only_rsIDs_RESULTS_enrich001.csv", header=TRUE)
third001 <- read.csv("CLAP/code/GOterms/files_001/hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS_enrich001.csv", header=TRUE)
first001 <- as.data.frame(first001$term_name)
second001 <-as.data.frame(second001$term_name)
third001 <- as.data.frame(third001$term_name)

mycol <- brewer.pal(3, "RdYlBu")
p1 <- venn.diagram(x = list(first001$`first001$term_name`, second001$`second001$term_name`, third001$`third001$term_name`), category.names = c("0-300kya", "300kya-500kya", "500kya-1mya"), 
                  lwd=2, lty = 'blank', fill=mycol, cex = 1, cat.cex = 1.5, cat.fontface = "bold",cat.pos = c(-27, 27, 135), cat.dist = c(0.055, 0.055, 0.085),filename = NULL)


##Top 3 plotEXCterms_GO:BP_CC_MF .01
plotEXCterms_top3_g001_BP_CC_MF <- read.csv("plotEXCterms_top3_g001_BP_CC_MF.csv", header=FALSE)
plotEXCterms_top3_g001_BP_CC_MF$V10 <- factor(plotEXCterms_top3_g001_BP_CC_MF$V10, levels = plotEXCterms_top3_g001_BP_CC_MF$V10)

p2 <- ggplot(plotEXCterms_top3_g001_BP_CC_MF, aes(plotEXCterms_top3_g001_BP_CC_MF$V10, plotEXCterms_top3_g001_BP_CC_MF$V1)) +
  theme_minimal() +
  geom_point(aes(size = plotEXCterms_top3_g001_BP_CC_MF$V6, colour=plotEXCterms_top3_g001_BP_CC_MF$V3))+
  labs(size="Number genes",col="Adj p value") + 
  scale_x_discrete(expand = c(0,0.9), ) +
  xlab("GO Terms") +
  ylab("")+
  theme(axis.text.x = element_text(angle = 90, size=10, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))

#wrapped


plot_grid(p, p, p, labels = "auto")