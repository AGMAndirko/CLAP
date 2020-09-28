library(ggplot2)

#plotEXCterms_KEEG_REAC_WP .01
plotEXCterms_KEEG_REAC_WP <- read.csv("~/Desktop/tmp_GOterms/plotEXCterms_KEEG_REAC_WP.csv", header=FALSE)

plotEXCterms_KEEG_REAC_WP$V11 <- factor(plotEXCterms_KEEG_REAC_WP$V11, levels = plotEXCterms_KEEG_REAC_WP$V11)

ggplot(plotEXCterms_KEEG_REAC_WP, aes(plotEXCterms_KEEG_REAC_WP$V11,plotEXCterms_KEEG_REAC_WP$V1)) +
  geom_point(aes(size = plotEXCterms_KEEG_REAC_WP$V6, colour=plotEXCterms_KEEG_REAC_WP$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms: KEEG; REAC; WP") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=9, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))

#plotEXCterms_GO:BP_CC_MF .01
plotEXCterms_BP_CC_MF <- read.csv("~/Desktop/tmp_GOterms/plotEXCterms_BP_CC_MF.csv", header=FALSE)

plotEXCterms_BP_CC_MF$V11 <- factor(plotEXCterms_BP_CC_MF$V11, levels = plotEXCterms_BP_CC_MF$V11)

ggplot(plotEXCterms_BP_CC_MF, aes(plotEXCterms_BP_CC_MF$V11,plotEXCterms_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_BP_CC_MF$V6, colour=plotEXCterms_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms: KEEG; REAC; WP") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=5, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))

##Top 3 plotEXCterms_GO:BP_CC_MF .01
plotEXCterms_top3_g001_BP_CC_MF <- read.csv("/home/juanandres/Desktop/tmp_GOterms/exclusive/plots/plotEXCterms_top3_g001_BP_CC_MF.csv", header=FALSE)
plotEXCterms_top3_g001_BP_CC_MF$V10 <- factor(plotEXCterms_top3_g001_BP_CC_MF$V10, levels = plotEXCterms_top3_g001_BP_CC_MF$V10)

ggplot(plotEXCterms_top3_g001_BP_CC_MF, aes(plotEXCterms_top3_g001_BP_CC_MF$V10, plotEXCterms_top3_g001_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_top3_g001_BP_CC_MF$V6, colour=plotEXCterms_top3_g001_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms .05: GO:BP_CC_MF") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=10, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))


#plotEXCterms_KEEG_REAC_WP .05
plotEXCterms_g005_KEEG_REAC_WP <- read.csv("~/Desktop/tmp_GOterms/005/plots/plotEXCterms_g005_KEEG_REAC_WP.csv", header=FALSE)

plotEXCterms_g005_KEEG_REAC_WP$V11 <- factor(plotEXCterms_g005_KEEG_REAC_WP$V11, levels = plotEXCterms_g005_KEEG_REAC_WP$V11)

ggplot(plotEXCterms_g005_KEEG_REAC_WP, aes(plotEXCterms_g005_KEEG_REAC_WP$V11,plotEXCterms_g005_KEEG_REAC_WP$V1)) +
  geom_point(aes(size = plotEXCterms_g005_KEEG_REAC_WP$V6, colour=plotEXCterms_g005_KEEG_REAC_WP$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms .05: KEEG; REAC; WP; HPA") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=9, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))


#plotEXCterms_GO:BP_CC_MF .05
plotEXCterms_g005_BP_CC_MF <- read.csv("~/Desktop/tmp_GOterms/005/plots/plotEXCterms_g005_BP_CC_MF.csv", header=FALSE)

plotEXCterms_g005_BP_CC_MF$V11 <- factor(plotEXCterms_g005_BP_CC_MF$V11, levels = plotEXCterms_g005_BP_CC_MF$V11)

ggplot(plotEXCterms_g005_BP_CC_MF, aes(plotEXCterms_g005_BP_CC_MF$V11,plotEXCterms_g005_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_g005_BP_CC_MF$V6, colour=plotEXCterms_g005_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms .05: KEEG; REAC; WP; HPA") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=5, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))


##Top 3 plotEXCterms_GO:BP_CC_MF .05
plotEXCterms_top3_g005_BP_CC_MF <- read.csv("~/Desktop/tmp_GOterms/005/plots/plotEXCterms_top3_g005_BP_CC_MF.csv", header=FALSE)
plotEXCterms_top3_g005_BP_CC_MF$V10 <- factor(plotEXCterms_top3_g005_BP_CC_MF$V10, levels = plotEXCterms_top3_g005_BP_CC_MF$V10)

ggplot(plotEXCterms_top3_g005_BP_CC_MF, aes(plotEXCterms_top3_g005_BP_CC_MF$V10, plotEXCterms_top3_g005_BP_CC_MF$V1)) +
  geom_point(aes(size = plotEXCterms_top3_g005_BP_CC_MF$V6, colour=plotEXCterms_top3_g005_BP_CC_MF$V3))+labs(size="Number genes",col="Adj p value")+  scale_x_discrete(expand = c(0,0.9)) +xlab("GO Terms .05: GO:BP_CC_MF") +
  ylab("")+theme(axis.text.x = element_text(angle = 90, size=10, hjust=0.95), axis.text.y = element_text(face="bold", size=12), axis.ticks = element_line(),axis.line = element_line(size = 1, linetype = "solid"))

