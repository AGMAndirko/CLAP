#!/usr/bin/env Rscript
library(tidyverse)
library(reshape2)

#drop unnecessary columns
output060 <- read_csv("Timeline_project/1_data/ExPecto/output060.csv")
output60100 <- read_csv("Timeline_project/1_data/ExPecto/output60100.csv")
output100200 <- read_csv("Timeline_project/1_data/ExPecto/output100200.csv")
output200300 <- read_csv("Timeline_project/1_data/ExPecto/output200300.csv")
output300500 <- read_csv("Timeline_project/1_data/ExPecto/output300500.csv")
output500800 <- read_csv("Timeline_project/1_data/ExPecto/output500800.csv")


#select columns
select_n_plot <- function (out, whichtitleplot) {	
	tin <- out %>% 
	select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 
	#3,8:20 = gtex, minus 19 (spinal cord)
	colnames(out)
	tin <- melt(tin)
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
	#Plot
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
	p <- ggplot(alt,aes(x=value,y=variable, fill = database))+
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
}

select_n_plot(output060[,-(1:10),drop=FALSE], "0-60k")
select_n_plot(output60100[,-(1:10),drop=FALSE], "60-100k")
select_n_plot(output100200[,-(1:10),drop=FALSE], "100-200k")
select_n_plot(output200300[,-(1:10),drop=FALSE], "200-300k")
select_n_plot(output300500[,-(1:10),drop=FALSE], "300-500k")
select_n_plot(output500800[,-(1:10),drop=FALSE], "500-800k")


#As for gene-wise plots...
genewiseplot <- function(originalout) {
  #Select as before, reshape
  output <- originalout %>% 
  select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209)  %>% 
  melt()

  #Keep the gene!
  output$genes <- originalout$gene

  #Variation potential directionality = value here
	inp1 <- aggregate(value ~ genes, output, sum)
	colnames(inp)[2] <- "directionality"

	#Variation potential magnitude to a new dataframe (inpm+number of time window)
	inpm <- aggregate(abs(value) ~ genes, output, sum)
	colnames(inpm)[2] <- "magnitude"
	
	#Testing íf columns are the same
	#Replies with FALSE here if everything ok to merge
	test <- inp$genes == inpm$genes
	FALSE %in% test

	#adds magnitude, removes aggregate 
	inp1$magnitude <- inpm$magnitude
}

inp1 <- 
inp2 <- 
inp3 <- 
inp4 <- 
inp5 <- 
inp6 <- 



plotinp <- rbind(inp1, inp2, inp3, inp4, inp5, inp6)
plotinp$timing <- c(rep("0 - 60k", nrow(inp1)),
                    rep("60k - 100k", nrow(inp2)),
                    rep("100k - 200k", nrow(inp3)),
                    rep("200k - 300k", nrow(inp4)),
                    rep("300k - 500k", nrow(inp5)),
                    rep("500k - 800k", nrow(inp6)))


#order levels 
plotinp$timing <- factor(plotinp$timing, levels = c("0 - 60k", "60k - 100k", "100k - 200k", "200k - 300k", "300k - 500k", "500k - 800k"))

#clean a bit
rm(inpm1,inpm2,inpm3,inpm4,inpm5, inpm6)
rm(inp1,inp2,inp3,inp4,inp5, inp6)
rm(output1, output2, output3, output4, output5, output6)

genenames<- gconvert(query = plotinp$genes, organism = "hsapiens",
                     target="ENSG", filter_na = FALSE)

test <- genenames$target == plotinp$genes
FALSE %in% test # should be FALSE
#produces some NA! some ensemble ID genes are not recognized for some reason (71 genes)
#I can live with that
plotinp$genes <- as.character(genenames$name)

#Plots a cone
ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  geom_point(size = 3) +
  labs(x= "Absolute magnitude of change", y = "Directionality (altternative allele)") +
  geom_label_repel(data = subset(plotinp,  magnitude > 2), colour = "black", nudge_y = 1 ) 
