  #Linear mixed model
  library(tidyverse)
  library(magrittr)
  library(reshape2)
  library(lme4)
  library(nlme)
  library(multcomp)
  library(lsmeans)
  library(multcompView)
  library(coin)
  library(FSA)
  
  output060 <- read_csv("avenues/ml/ExPecto/output060.csv")
  output60100 <- read_csv("avenues/ml/ExPecto/output60100.csv")
  output100200 <- read_csv("avenues/ml/ExPecto/output100200.csv")
  output200300 <- read_csv("avenues/ml/ExPecto/output200300.csv")
  output300500 <- read_csv("avenues/ml/ExPecto/output300500.csv")
  output500800 <- read_csv("avenues/ml/ExPecto/output500800.csv")
  
  #Select the relevant one for plotting
  output060 <- output060[,-(1:10),drop=FALSE] 
  output60100 <- output60100[,-(1:10),drop=FALSE] 
  output100200 <- output100200[,-(1:10),drop=FALSE] 
  output200300 <- output200300[,-(1:10),drop=FALSE] 
  output300500 <- output300500[,-(1:10),drop=FALSE] 
  output500800 <- output500800[,-(1:10),drop=FALSE] 
  
  #select columns, format for anova
  select_tissues<- function(tab, name) {
    tab %>% 
      dplyr::select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) %>% 
      melt(value.name = "expression") %>% 
      cbind(group = c(name)) %>% 
      relocate(group, .before = variable)
  }
  
  test1 <- select_tissues(output060, "0to60")
  test2 <- select_tissues(output60100, "60to100")
  test3 <- select_tissues(output100200, "100to200")
  test4 <- select_tissues(output200300, "200to300")
  test5 <- select_tissues(output300500, "300to500")
  test6 <- select_tissues(output500800, "500to800")
  res <- rbind(test1, test2, test3, test4, test5, test6)
  rm(list = ls(pattern='test*'))
  rm(list = ls(pattern='output*'))
  
#Is data normal?  Shouldn't be, as shown by QQ plots
hist(res$expression, breaks=2000, xlim = range(-.005, .005))
#Log transformation
hist(log10(res$expression), breaks=50)

#By variable - not significant
kruskal_test(expression ~ variable, data = res,
             distribution = approximate(nresample = 1000))
#By age - significant
kruskal_test(expression ~ group, data = res,
             distribution = approximate(nresample = 1000))
#By both - not significant
kruskal_test(expression ~ group | variable, data = res,
             distribution = approximate(nresample = 1000))

#Posthoc analysis
dunnTest(expression ~ group,
              data=res,
              method="bh") 

#How about with age, in general
all_COMBINED <- read_csv("data/Timeline_project/1_data/all_COMBINED.tsv", col_names = FALSE)
all_COMBINED <- all_COMBINED %>% 
  dplyr::select(X2, X3, X23)

output060 <- read_csv("avenues/ml/ExPecto/output060.csv")
output60100 <- read_csv("avenues/ml/ExPecto/output60100.csv")
output100200 <- read_csv("avenues/ml/ExPecto/output100200.csv")
output200300 <- read_csv("avenues/ml/ExPecto/output200300.csv")
output300500 <- read_csv("avenues/ml/ExPecto/output300500.csv")
output500800 <- read_csv("avenues/ml/ExPecto/output500800.csv")

tissue_rep <- function(x) {
  rep(x, 22)
}

res$chr <- unlist(rbind(tissue_rep(output060[3]),
                 tissue_rep(output60100[3]), 
                 tissue_rep(output100200[3]), 
                 tissue_rep(output200300[3]), 
                 tissue_rep(output300500[3]), 
                 tissue_rep(output500800[3])))

res$pos <- unlist(rbind(tissue_rep(output060[4]),
                        tissue_rep(output60100[4]), 
                        tissue_rep(output100200[4]), 
                        tissue_rep(output200300[4]), 
                        tissue_rep(output300500[4]), 
                        tissue_rep(output500800[4])))

res_dated <- res %>% 
  left_join(all_COMBINED, by = c("chr" = "X2", "pos" = "X3"))

#Pearson should be 
cor.test(res_dated[["expression"]], res_dated[["X23"]], method = "pearson")
#not sign
