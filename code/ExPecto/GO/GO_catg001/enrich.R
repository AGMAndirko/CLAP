library(tidyverse)
library(gprofiler2)

hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS <- read.delim("hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS", header=FALSE)
hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS <- read.delim("hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS", header=FALSE)
hf_COMBINED_300_500kya_only_rsIDs_RESULTS <- read.delim("hf_COMBINED_300_500kya_only_rsIDs_RESULTS", header=FALSE)

##500-1m .01
hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS_enrich001 <- gost(hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS$V3, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.01, evcodes = TRUE)
#Write:
table <- apply(hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS_enrich001[["result"]],2,as.character)
table <- as.data.frame(table)
tablegenes <- table$intersection
write.csv(table, file="hf_COMBINED_500kya_1mya_only_rsIDs_RESULTS_enrich001.csv", row.names = FALSE)
write.csv(tablegenes, file="hf_COMBINED_500kya_1mya_GOgenes.csv", row.names = FALSE)

##0-300 .01

hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS_enrich001 <- gost(hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS$V3, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.01, evcodes = TRUE)
#Write:
table <- apply(hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS_enrich001[["result"]],2,as.character)
table <- as.data.frame(table)
tablegenes <- table$intersection
write.csv(table, file="hf_COMBINED_0kya_300kya_only_rsIDs_RESULTS_enrich001.csv", row.names = FALSE)
write.csv(tablegenes, file="hf_COMBINED_0kya_300kya_GOgenes.csv", row.names = FALSE)

##300-500kya .01

hf_COMBINED_300_500kya_only_rsIDs_RESULTS_enrich001 <- gost(hf_COMBINED_300_500kya_only_rsIDs_RESULTS$V3, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.01, evcodes = TRUE)
#Write:
table <- apply(hf_COMBINED_300_500kya_only_rsIDs_RESULTS_enrich001[["result"]],2,as.character)
table <- as.data.frame(table)
tablegenes <- table$intersection
write.csv(table, file="hf_COMBINED_300_500kya_only_rsIDs_RESULTS_enrich001.csv", row.names = FALSE)
write.csv(tablegenes, file="hf_COMBINED_300_500kya_GOgenes.csv", row.names = FALSE)
