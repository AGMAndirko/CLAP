library(tidyverse)
library(reshape2)
library(gprofiler2)
library(ggrepel)
library(gghighlight)
library(locfdr)
library(coin)
library(fdrtool)

#ONLY BRAIN-RELATED VIOLIN PLOT
#select columns
select_n_plot <- function (out, whichtitleplot) {	
  #Discard from tin also the first ten columns!!!!!
  out <- out %>% 
    dplyr::select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 
  tin <- melt(out)
  
  #positive and negative value filtering, since they are two different columns
  pos <- tin %>% 
    dplyr::filter(value >= 0)
  neg <- tin %>% 
    dplyr::filter(value <= 0)
  
  #Aggregate values per column
  one <- aggregate(value ~ variable, pos, sum)
  neg <- aggregate(value ~ variable, neg, sum)
  one$negval <- neg$value
  
  #get them in one place, melt, rename a duplicated column name to reflect +0 or -0 value
  inp <- one
  inp <- melt(inp)
  colnames(inp)[2] <- "group"
  #order values
  inp2 <- inp %>%
    group_by(group) %>% 
    arrange(value, by_group = TRUE) %>%
    mutate(variable=factor(variable, levels=unique(variable)))
  inp2$variable <- fct_rev(inp2$variable)
  
  #plot
  p <- ggplot(inp2,aes(x=value,y=variable, fill = group))+
    theme_minimal() +
    geom_bar(stat="identity") +
    labs(title=whichtitleplot,
         x = "Predicted expression (logFC)",
         y = "Structure", 
         fill = "Expression") +
    scale_fill_discrete(labels=c("Upregulation", "Downregulation"))
  
  #Print
  pdf(paste0(whichtitleplot, "_1.pdf"))
  print(p)
  dev.off()
  
  #Alternative plot
  #test if same structures:
  one$variable == neg$variable
  #create alternative dataframe
  alt <- NULL
  alt$variable <- one$variable
  alt$value <- c(one$value+neg$value)
  alt$database <- c(rep("GTEX", 14), "Road map", rep("Encode", 7))
  alt <- as.data.frame(alt)
  #arrange
  alt <- alt %>%
    arrange(value) %>%
    mutate(variable=factor(variable, levels=unique(variable)))
  #plot!
  p <- ggplot(alt,aes(x=value,y=variable,fill =database))+
    theme_minimal() +
    geom_bar(stat="identity") +
    labs(title=whichtitleplot, 
         x = "Sum of Predicted expression (logFC)",
         y = "Structure", 
         fill = "Expression")
  #Print
  pdf(paste0(whichtitleplot, "_2.pdf"))
  print(p)
  dev.off()
  return(alt)
}
genewiseplot <- function(originalout) {
  #Select as before, reshape
  output <- originalout[,-(1:10),drop=FALSE] %>% 
    dplyr::select(3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 
                  42, 61, 136, 145, 161, 186, 187, 189, 209)  %>% 
    melt()
  
  #Keep the gene!
  output$genes <- originalout$gene
  
  #Variation potential +directionality = value here
  inp <- aggregate(value ~ genes, output, sum)
  colnames(inp)[2] <- "directionality"
  
  #Variation potential magnitude to a new dataframe (inpm+number of time window)
  inpm <- aggregate(abs(value) ~ genes, output, sum)
  colnames(inpm)[2] <- "magnitude"
  
  #Testing íf columns are the same
  #Replies with FALSE here if everything ok to merge
  test <- inp$genes == inpm$genes
  FALSE %in% test
  
  #adds magnitude, removes aggregate 
  inp$magnitude <- inpm$magnitude
  
  return(inp)
}
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

#false discovery rate for cone plots
shape_data_FDR <- function (timewindow) {
  output <- timewindow[,-(1:10),drop=FALSE] 
  
  output <- output %>% 
    dplyr::select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) %>% 
    melt()
  output$genes <- timewindow$gene
  return(output)
  
  # variant number control for FDR - commented out
  if(FALSE){
    output <- output %>%
      group_by$gene %>%
      summarize(mean_aggregated_variants = (mean(value)))
    # problematic - maybe median is better?
  }
}
FDRgenes <- function(output){
  #conserve time window info
  output$time <- NA
  l1 <- as.numeric(length(output0300$value))
  l2 <- as.numeric(length(output300500$value))
  l3 <- as.numeric(length(output5001m$value))
  output$time[1:l1] <- rep("0-300k", l1)
  output$time[l1+1:l2] <-  rep("300-500k", l2)
  output$time[l2+1:l3] <-  rep("500-1m", l3)
  
  output <- output %>% 
    group_by(variable, genes) %>% 
    mutate(value = sum(value)) %>% 
    filter(value != 0) %>% 
    unique()
  
  output$z_scores  <-  output$value-mean(output$value)/sd(output$value)
  
  #commented out
  if(FALSE){
    inp <- aggregate(value ~ genes, output, sum)
    colnames(inp)[2] <- "directionality"
    
    inpm <- aggregate(abs(value) ~ genes, output, sum)
    colnames(inpm)[2] <- "magnitude"
    
    test <- inp$genes == inpm$genes
    FALSE %in% test
    inp$magnitude <- inpm$magnitude
  }
  return(output)
}


#read
output0300 <- read_csv("~/data_clap_Alejandro/expecto/run0300.csv")
output300500 <- read_csv("~/data_clap_Alejandro/expecto/run300500.csv")
output5001m <- read_csv("~/data_clap_Alejandro/expecto/run5001m.csv")
output <- read_csv("~/data_clap_Alejandro/expecto/outputall.csv")

#shapes data for violin plot 
output0300 <- select_n_plot(output0300[,-(1:10),drop=FALSE], "0-300k")
output300500 <- select_n_plot(output300500[,-(1:10),drop=FALSE], "300-500k")
output5001m <- select_n_plot(output5001m[,-(1:10),drop=FALSE], "500-1m")

allexpr <- full_join(output0300, output300500)
allexpr <- full_join(allexpr, output5001m)

windows <-c("0-300kya",  "300-500kya", "500-1mya")
#allexpr$time <- unlist(lapply(windows, rep, 218))

allexpr$time <- unlist(lapply(windows, rep, 22))
#allexpr$time <- unlist(lapply(windows, rep, 218))


allexpr$time <- factor(allexpr$time, levels = unique(allexpr$time))

braintissues <- output[,-(1:10),drop=FALSE] %>% 
  dplyr::select(3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 
                42, 61, 136, 145, 161, 186, 187, 189, 209) %>% 
  colnames()


#filter specific points 
highlight <- allexpr %>% 
  filter(variable %in% braintissues )

allexpr$highlight <- allexpr$variable %in% braintissues

allexpr$bottom4 <- rep(0,66)

allexpr[c(1,2,3,4,23,24,25,26,45,46,47,48),]$bottom4 <- 1
#allexpr[c(1,22,23,44,45,66),]$top2 <- 1

#pdf("~/tmp_fig3A.pdf", width = 12, height = 8)
a1 <- ggplot(allexpr, aes(x=time, y=value, label = variable)) +
  theme_classic() +
  theme(legend.position = "top") +
  #geom_line( color="grey") +
  geom_violin(color="grey50") +
  geom_jitter(aes(group = variable, 
                  colour = ifelse(highlight == TRUE, 
                                  "Brain-related", "Not brain-related")), 
              width = 0.02)+
  geom_label_repel(data = subset(allexpr, bottom4 > 0),size = 2.5,
                   box.padding   = 0.35,
                   point.padding = 0.5,
                   force         = 5,
                   segment.size  = 0.5,
                   segment.color = "black",
                   direction     = "x"
  )+
  labs(title="", x = "",
       y = "Sum variant predicted expression (logFC)", colour = "Type of tissue:")
dev.off()
#write.csv(allexpr, file="~/tmp_dataFig3A.csv")




#Kruskal test
#By variable - not significant
kruskal_test(value ~ variable, data = allexpr)
#By age - significant
kruskal_test(value ~ time, data = allexpr)
#By both - significant
kruskal_test(value ~ variable |time, data = allexpr)
#Brain vs control - significant
kruskal_test(value ~ as.factor(highlight) | time, data = allexpr) #error

#Now for the cone plots
rm(list = ls())
output0300 <- read_csv("~/data_clap_Alejandro/expecto/run0300.csv")
output300500 <- read_csv("~/data_clap_Alejandro/expecto/run300500.csv")
output5001m <- read_csv("~/data_clap_Alejandro/expecto/run5001m.csv")
output0300 <- shape_data_FDR(output0300)
output300500 <- shape_data_FDR(output300500)
output5001m <-  shape_data_FDR(output5001m)
outputall <- rbind(output0300, output300500, output5001m)

#FDR
outputall <- FDRgenes(outputall)
par(mar=c(1,1,1,1)) # prevents R complains about margins
fdrout <- fdrtool(outputall[[5]], statistic = c("normal"))
outputall$fdr <- fdrout$lfdr

highlight <- outputall %>% 
  filter(fdr < 0.05)

output0300 <- read_csv("~/data_clap_Alejandro/expecto/run0300.csv")
output300500 <- read_csv("~/data_clap_Alejandro/expecto/run300500.csv")
output5001m <- read_csv("~/data_clap_Alejandro/expecto/run5001m.csv")

inp1 <- genewiseplot(output0300)
inp2 <- genewiseplot(output300500)
inp3 <- genewiseplot(output5001m)

plotinp <- rbind(inp1, inp2, inp3)
plotinp$timing <- c(rep("0 - 300k", nrow(inp1)),
                    rep("300k - 500k", nrow(inp2)),
                    rep("500k - 1m", nrow(inp3)))


#order levels 
plotinp$timing <- factor(plotinp$timing, levels = c("0 - 300k", "300k - 500k", "500k - 1m"))

#clean a bit
rm(inp1, inp2, inp3)
#plotinp_significant <- plotinp %>% 
#  filter(genes %in% highlight$)

genenames<- gconvert(query = plotinp$genes, organism = "hsapiens",
                     target="ENSG", filter_na = FALSE)

test <- genenames$input == plotinp$genes
FALSE %in% test # should be FALSE
#produces some NA! some ensemble ID genes are not recognized for some reason (71 genes)
#I can live with that
plotinp$genes <- as.character(genenames$name)

#Plots a cone
#pdf("genewise.pdf")

ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  geom_point(size = 2) +
  labs(x= "Absolute magnitude of change", y = "Directionality (altternative allele)")
geom_label_repel(data = subset(plotinp,  magnitude > 2), colour = "black", nudge_y = 1 ) 

#dev.off()
#Overall Q-Q plot
output <- read_csv("~/data_clap_Alejandro/expecto/outputall.csv")
out <- output[,-(1:10),drop=FALSE]
out <- melt(out)

out <- out %>% 
  group_by(variable) %>% 
  summarize(sum = sum(as.numeric(value)))


out <- output[,-(1:10),drop=FALSE]
out <- out%>% 
  select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 
out <- melt(out)

out <- out %>% 
  group_by(variable) %>% 
  summarize(sum = sum(as.numeric(value)))

ggplot(out, aes(sample=sum)) + 
  theme_minimal() +
  ggtitle("Q-Q plot - extreme value skewedness", subtitle = "ExPecto (all time windows - only brain tissues)") +
  geom_qq() +
  stat_qq_line()


ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  geom_point(size = 3) +
  labs(x= "Absolute magnitude of change", y = "Directionality (alternative allele)") +
  geom_label_repel(data = subset(plotinp,  magnitude > 2 && directionality > 2), colour = "black", nudge_y = 1 ) 

#Wrapped
pdf("~/wrapped.pdf")
ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  geom_point(size = 1) +
  labs(x= "Absolute magnitude of change", y = "Directionality (alternative allele)") +
  geom_label_repel(data = subset(plotinp, magnitude > 2), colour = "black", nudge_y = 1 ) +
  facet_wrap(timing ~ ., ncol = 2)
dev.off()

a <- ggplot(allexpr, aes(x=time, y=value, label = variable)) +
  theme_classic() +
  theme(legend.position = "top") +
  #geom_line( color="grey") +
  geom_violin(color="grey50") +
  geom_jitter(aes(group = variable, 
                  colour = ifelse(highlight == TRUE, 
                                  "Brain-related", "Not brain-related")), 
              width = 0.02)+
  geom_label_repel(data = subset(allexpr, bottom4 > 0),size = 2.5,
                   box.padding   = 0.35,
                   point.padding = 0.5,
                   force         = 5,
                   segment.size  = 0.5,
                   segment.color = "black",
                   direction     = "x"
  )+
  labs(title="", x = "",
       y = "Sum variant predicted expression (logFC)", colour = "Type of tissue:")

#after Expecto_plots.R
b <- ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  geom_point(size = 1) +
  labs(x= "Absolute magnitude of change", y = "Directionality (alternative allele)") +
  geom_label_repel(data = subset(plotinp, magnitude > 2), colour = "black", nudge_y = 1 ) +
  facet_wrap(timing ~ ., ncol = 2)

library(cowplot)
plot1 <- plot_grid(a, b, ncol = 2, labels = c("A", "B"), rel_widths = c(1,1))
ggsave("~/Fig3_brain.pdf", plot1, width = 20, height = 10)


#ALL STRUCTURES VIOLIN PLOT
select_n_plot <- function (out, whichtitleplot) {	
  tin <- melt(out)
  
  #positive and negative value filtering, since they are two different columns
  pos <- tin %>% 
    dplyr::filter(value >= 0)
  neg <- tin %>% 
    dplyr::filter(value <= 0)
  
  #Aggregate values per column
  one <- aggregate(value ~ variable, pos, sum)
  neg <- aggregate(value ~ variable, neg, sum)
  one$negval <- neg$value
  
  #get them in one place, melt, rename a duplicated column name to reflect +0 or -0 value
  inp <- one
  inp <- melt(inp)
  colnames(inp)[2] <- "group"
  #order values
  inp2 <- inp %>%
    group_by(group) %>% 
    arrange(value, by_group = TRUE) %>%
    mutate(variable=factor(variable, levels=unique(variable)))
  inp2$variable <- fct_rev(inp2$variable)
  
  #Alternative plot
  #test if same structures:
  one$variable == neg$variable
  #create alternative dataframe
  alt <- NULL
  alt$variable <- one$variable
  alt$value <- c(one$value+neg$value)
  #alt$database <- c(rep("GTEX", 14), "Road map", rep("Encode", 7))
  alt <- as.data.frame(alt)
  # #arrange
  alt <- alt %>%
    arrange(value) %>%
    mutate(variable=factor(variable, levels=unique(variable)))
  return(alt)
}
##
allexpr$time <- unlist(lapply(windows, rep, 218))
