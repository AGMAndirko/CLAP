#!/usr/bin/env Rscript

library(tidyverse)

hf_COMBINED <- read.csv("hf_COMBINED.tsv", header=FALSE) #Human high-freq SNPs mapped

#in a function:
filtering <- function (limit1, limit2) {
	a <- data.frame(hf_COMBINED$V23 * 29)
	a$rsID <- hf_COMBINED$V1
	names(a) <- c("V23*29", "rsID")
	names(a)
	nrow(a)
	res <- filter(a, between(`V23*29`, limit1,limit2))
	nrow(res)
	n1 <- as.data.frame(str_split_fixed(res$rsID, ":", 2))
	res$rsID <- n1$V2
	return(res)
}

a1 <- filtering(500000,1000000) #nrow 32099
a2 <- filtering(0,300000) #nrow 18331
a3 <- filtering(300000,500000) #nrow 18331

write.csv(a1, "hf_COMBINED_500kya_1mya.csv", row.names = FALSE)
write.csv(a2, "hf_COMBINED_0kya_300kya.csv", row.names = FALSE)
write.csv(a3, "hf_COMBINED_300kya_500kya.csv", row.names = FALSE)

