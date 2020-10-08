#Stats against regular expecto
library(tidyverse)
library(biomaRt)
library(reshape2)
library(gprofiler2)
#Formatting function
formatforstats <- function(input) {
  out <- input[,-(1:10),drop=FALSE]
  out <- out %>% 
    dplyr::select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 
  melt(out)
}

#Formats input from normal ExPecto
regularExP <- function (window1, window2) {
  a <- formatforstats(window1)
  b <- formatforstats(window2)
  res <- rbind(a,b)
  rm(a, b)
  res <- res %>% 
    group_by(variable) %>% 
    summarize(mean = mean(value))
  return(res)
}

#Prepare GO subset
GOforStats <- function (window) {
  go <- strsplit(terms_n_genes$intersection, ",")
  names(go) <- terms_n_genes$term_name
  go <- melt(go)

  alt <- gconvert(go$value) #get alt gene ids
  table(go$value == alt$input) #true
  go$altid <- alt$target

  #select brain tissues
  output <- window %>% 
    dplyr::select(9,13,18,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 52, 71, 146, 155, 171, 196, 197, 199, 219)

  #Create the GO subset
  combined <- merge(go, output, by.x = "altid", by.y="gene")
  combined <- combined[,-(1:3),drop=FALSE]
  combined <- unique(combined)
  combined <- melt(combined)
  GO <- combined %>% 
   group_by(variable) %>% 
   summarize(mean = mean(value))
return(GO)
}

#Compares GO genes variants in a certain time frame with all variants in the other two time categories
testing <- function (one, two) {
  st <- NULL
  st$GO <- one$mean
  st$reg <- two$mean
  st <- as.data.frame(st)
  row.names(st) <- GO$variable
  st <- melt(st)
  return(kruskal.test(value ~ variable, data = st))
}


#Import
output0_300 <- read_csv("output0_300.csv") 
output0_300 <- drop_na(output0_300) #Has NAs, probably from `cat` shell command: drop
output300_500 <- read_csv("output300_500.csv") 
output500_800 <- read_csv("output500_800.csv") 

#0_300
terms_n_genes <- read_csv("terms_n_genes0300") 
GO <- GOforStats(output0_300)
reg <- regularExP(output300_500,output500_800)
# testing(GO, reg) # pval = 0.1887 - NON SIGNIFICANT

#300_500
terms_n_genes <- read_csv("terms_n_genes300500") 
GO <- GOforStats(output300_500)
reg <- regularExP(output0_300,output500_800)
testing(GO, reg) # pval = 1.344e-08

#500_800
terms_n_genes <- read_csv("terms_n_genes500800") 
GO <- GOforStats(output500_800)
reg <- regularExP(output0_300,output300_500)
testing(GO, reg) # pval = same! 1.344e-08
 
