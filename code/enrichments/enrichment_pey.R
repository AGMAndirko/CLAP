library(gprofiler2)
library(tidyverse)

hf_COMBINED_Peycoords_0kya_300kya_RESULTS_enrich005 <- gost(Na_high_freq_in_Peycoords_0kya_300kya_29_only_rsIDs_RESULTS$V3, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.05, evcodes = TRUE) #get names: evcodes = TRUE 
#table <- apply(hf_COMBINED_Peycoords_0kya_300kya_RESULTS_enrich005[["result"]],2,as.character)
#table <- as.data.frame(#table)
#write.csv(#table, file="~/hf_COMBINED_Peycoords_0kya_300kya_RESULTS_enrich005.csv", row.names = FALSE)

hf_COMBINED_Peycoords_0kya_300kya_RESULTS_enrich001 <- gost(Na_high_freq_in_Peycoords_0kya_300kya_29_only_rsIDs_RESULTS$V3, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.01, evcodes = TRUE) #get names: evcodes = TRUE 
#table <- apply(hf_COMBINED_Peycoords_0kya_300kya_RESULTS_enrich001[["result"]],2,as.character)
#table <- as.data.frame(#table)
#write.csv(#table, file="~/hf_COMBINED_Peycoords_0kya_300kya_RESULTS_enrich001.csv", row.names = FALSE)

hf_COMBINED_Peycoords_500kya_1mya_RESULTS_enrich005 <- gost(Na_high_freq_in_Peycoords_500kya_1mya_29_only_rsIDs_only_rsIDs_RESULTS$V3, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.05, evcodes = TRUE) #get names: evcodes = TRUE 
#table <- apply(hf_COMBINED_Peycoords_500kya_1mya_RESULTS_enrich005[["result"]],2,as.character)
#table <- as.data.frame(#table)
#write.csv(#table, file="~/hf_COMBINED_Peycoords_500kya_1mya_RESULTS_enrich005.csv", row.names = FALSE)

hf_COMBINED_Peycoords_500kya_1mya_RESULTS_enrich001 <- gost(Na_high_freq_in_Peycoords_500kya_1mya_29_only_rsIDs_only_rsIDs_RESULTS$V3, organism = "hsapiens", correction_method = "gSCS", user_threshold = 0.01, evcodes = TRUE) #get names: evcodes = TRUE 
#table <- apply(hf_COMBINED_Peycoords_500kya_1mya_RESULTS_enrich001[["result"]],2,as.character)
#table <- as.data.frame(#table)
#write.csv(#table, file="~/hf_COMBINED_Peycoords_500kya_1mya_RESULTS_enrich001.csv", row.names = FALSE)