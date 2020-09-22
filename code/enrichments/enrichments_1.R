library(tidyverse)


input_300k <- hf_strict %>% 
  filter(X23*29 <= 300000)

#Cleans up rsid name
input_300k$X1 <- str_replace(input_300k$X1, ".*rs", "rs")

#Gprofiler
results300k <- gost(input_300k$X1, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.01)

#Optional: printing
#print <- apply(results300k[["result"]],2,as.character)
#print <- as.data.frame(print) 

#Filters by age
input_500k_1m <- hf_strict %>% 
  filter(X23*29 >= 500000 & X23*29 <= 1000000)

#Cleans up rsid name
input_500k_1m$X1 <- str_replace(input_500k_1m$X1, ".*rs", "rs")

#Gprofiler
results500k_1m <- gost(input_500k_1m$X1, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.01)

#Optional: printing
#print <- apply(results500k_1m[["result"]],2,as.character)
#print <- as.data.frame(print)
#write.csv(print, "HFstrict_500kto1m.csv", row.names = FALSE)
