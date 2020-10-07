library(tidyverse)
library(reshape2)

#The input files for positive selection and deserts are prepared in the #others section
#Preparing peyregné
pey <- read_csv("Timeline_project/1_data/inputplot_pey", col_names = FALSE)

#Preparing deserts of introgression
desert <- read_csv("Timeline_project/1_data/inputplot_desert", col_names = FALSE)

#Preparing akey2020
akey <- read_csv("Timeline_project/1_data/inputplot_akey", col_names = FALSE) 
akey$X1 <- str_replace(akey$X1, ".*csv:", "") #clean rsIDs

# Preparing HF
hf <- read_csv("Timeline_project/1_data/hf_COMBINED.tsv", col_names = FALSE)
hf$X1 <- str_replace(hf$X1, ".*csv:", "") #clean rsIDs 

#Preparing HF strict
hf_strict <- read_csv("Timeline_project/1_data/hf_strictCOMBINED.tsv", col_names = FALSE)
hf_strict$X1 <- str_replace(hf_strict$X1, ".*csv:", "") #clean rsIDs

#Preparing special Martin files (lenght, excess)
lenght <- read_csv("Timeline_project/1_data/dated_lenght", col_names = FALSE)
excess <- read_csv("Timeline_project/1_data/dated_excess", col_names = FALSE)

#Puts relevant column in a list of lists
p <- NULL
p$Akey <- akey$X23
p$Peyregne <- pey$X23 
p$Deserts <- desert$X23
p$HF <- hf$X23
p$HFstrict <- hf_strict$X23
p$Lenght <- lenght$X23
p$Excess <- excess$X23

#Formats for ggplot
p <- melt(p)

pdf("seven_files_plot.pdf")
ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  ggtitle("") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 500) +
  labs(x = "Years", y = "Variant count", title = "A comparison of several files", color= "File:") +
  scale_color_brewer(palette="Set1") +
  theme(legend.position = "top") +
  scale_y_sqrt() 
dev.off()


ks.test(hf$X23, hf_strict$X23) # p < 2.2e-16
ks.test(hf$X23, akey$X23) # p < 2.2e-16
ks.test(hf$X23, desert$X23) #p = 0.01193, sign?
ks.test(hf$X23, pey$X23) # p < 2.2e-16
ks.test(excess$X23, lenght$X23) # p = 4.567e-13
ks.test(excess$X23, akey$X23) # < 2.2e-16
ks.test(excess$X23, pey$X23) # < 2.2e-16
