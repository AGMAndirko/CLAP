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
