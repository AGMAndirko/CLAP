library(tidyverse) 
library(reshape2)

Altai_AFR10nonAFR01 <- read_csv("Altai_AFR10nonAFR01_full", 
                                     col_names = FALSE)
Vindija_AFR10nonAFR01 <- read_csv("Vindija_AFR10nonAFR01_full", 
                                col_names = FALSE)
Denisova_AFR10nonAFR01 <- read_csv("Denisova_AFR10nonAFR01_full", 
                                col_names = FALSE)
Altai_AFR03nonAFR10 <- read_csv("Altai_AFR03nonAFR10_full", 
                                col_names = FALSE)
Vindija_AFR03nonAFR10 <- read_csv("Vindija_AFR03nonAFR10_full", 
                                  col_names = FALSE)
Denisova_AFR03nonAFR10 <- read_csv("Denisova_AFR03nonAFR10_full", 
                                   col_names = FALSE)

p <- NULL
p$Altai <- Altai_AFR03nonAFR10$X23
p$Vindija  <- Vindija_AFR03nonAFR10$X23
p$Denisova  <- Denisova_AFR03nonAFR10$X23
p$Altai2 <-  Altai_AFR10nonAFR01$X23
p$Vindija2  <-  Vindija_AFR10nonAFR01$X23
p$Denisova2  <- Denisova_AFR10nonAFR01$X23
p <- melt(p)
filter <- rep("3% AFR / 10% non AFR", 728803)
filter <- append(filter, rep("10% AFR / 1% non AFR", 452133))
p$filter <- filter
p$L1 <- str_replace_all(p$L1, "2", "")

pdf("population_and_archaics_filters_all.pdf")
ggplot(p, aes(value*29, group = L1, color = L1))+
  theme_minimal() +
  ggtitle("Populations filters") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_freqpoly(stat = "bin", bins = 100, show.legend = FALSE) +
  labs(x = "Years", y = "Variant count", color = "Filter") +
  facet_grid(L1 ~ filter)
dev.off()
