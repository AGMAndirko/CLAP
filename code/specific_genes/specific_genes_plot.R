library(tidyverse)

genename <- commandArgs(TRUE)
print(genename)

hf <- read_csv("Timeline_project/1_data/hf_COMBINED.tsv", col_names = FALSE)
gene <- read_csv(paste0(genename,"_results.tsv"), col_names = FALSE)


ggplot(hf, aes(X23*29)) + 	
	theme_minimal() +
	geom_freqpoly(stat = "bin", bins = 500) +
	geom_vline(xintercept = gene$X23*29, colour = "darkred") +
	ylab("Count") +
	xlab("Years") +
	ggtitle(genename)
dev.off() 
