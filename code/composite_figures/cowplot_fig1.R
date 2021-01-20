library(cowplot)
library(viridis)

#Commented: Names of script(s) required before running each bit

#KB19_distributions
one <- ggplot(all, aes(X23*29))+
  theme_minimal() +
  ggtitle("Distribution of overall derived, HF and HF (pop. filter)") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0,3000000), breaks = seq(0,3000000, by = 100000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 500, fill = "#39568CFF") +
  geom_density(data = hf, aes(X23*29), stat = "bin", bins = 500, fill = "#1F968BFF" ) +
  geom_density(data = hf_strict, aes(X23*29), stat = "bin", bins = 500, fill = "#73D055FF") +
  labs(x = "Years", y = "Variant count (squared)") +
  scale_y_sqrt()

hf <- hf %>% 
  mutate(variab = case_when(
    (X23 >= 0 & X23*29 <= 300000) ~ "1",
    (X23*29 >= 300000 & X23*29 <=500000) ~ "2",
    (X23*29 >= 500000 & X23*29 <=1000000) ~ "3",
    (X23*29 > 1000000) ~ "4",
    TRUE ~ NA_character_
  ))

two <- ggplot(hf, aes(X23*29))+
  theme_minimal() +
  ggtitle("Selected time windows timemarks") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0,2300000), breaks = c(0, 300000, 500000, 1000000, 2300000)) + # 6218702 = max(all$X23*29) 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_density(stat = "bin", bins = 500) +
  geom_density(data = dplyr::filter(hf, variab == '1'), stat = "bin", bins = 500, fill = "#39568CFF") +
  geom_density(data = dplyr::filter(hf, variab == '2'), stat = "bin", bins = 500, fill = "#73D055FF") +
  geom_density(data = dplyr::filter(hf, variab == '3'), stat = "bin", bins = 500, fill = "#1F968BFF") +
  geom_density(data = dplyr::filter(hf, variab == '4'), stat = "bin", bins = 500, fill = "gray98") +
  labs(x = "Years", y = "HF Variant count")

#seven_files_plots_stats
p$L1 <- str_replace_all(p$L1, "Akey", "Chen et al. 2020")
p$L1 <- str_replace_all(p$L1, "Lenght", "Length")
p$L1 <- str_replace_all(p$L1, "Peyregne", "Peyrégne et al. 2017")
p$L1 <- str_replace_all(p$L1, "Deserts", "Sankararaman et al. 2016")
p$L1 <- str_replace_all(p$L1, "strict", " (pop. filter)")
p$L1 <- str_replace_all(p$L1, fixed("high"), "HF") #changed this one in seven plots code file to avoid tweakin stringr


three <- ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  ggtitle("") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50, key_glyph = "timeseries") +
  #guides(colour = guide_legend(override.aes = list(size = 15)))+
  labs(x = "Years", y = "Variant count (squared)", title = "Evolutionarily relevant variant subsets", color= "File:") +
  theme(legend.position = "top") +
  scale_y_sqrt() 

peakratios <- ggplot_build(three)$data[[1]]
peaksratios_df <- peakratios %>% 
  group_by(group) %>% 
  arrange(desc(ncount)) %>% 
  slice(2) %>% 
  select(ncount, colour)
# Files identifiable by colour, they are still ordered as in the levels anyway
peaksratios_df$group <- factor(peaksratios_df$group, levels = peaksratios_df$group[order(peaksratios_df$ncount)])

threeplus <- ggplot(peaksratios_df, aes(x=group, y = 1-ncount)) +
  theme_minimal() +
  geom_bar(stat = "identity", fill = "#39568CFF") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "", y = "Peaks density difference") +
  theme(legend.position = "none") +
  scale_x_discrete(labels= c("7" = "Sankararaman et al. 2016", 
                             "6" = "Peyrégne et al. 2017", 
                             "5" = "Length", 
                             "4" = "HF (pop. filter)",
                             "3" = "HF",
                             "2" = "Excess",
                             "1" = "Chen et al. 2020"))



plotinp <- read_table2("Timeline_project/1_data/introgression/rinput", 
                       col_names = FALSE)
plotinp$X1 <- str_replace_all(plotinp$X1, "Sankarararaman", "Sankararaman et al. 2016")
plotinp$X1 <- str_replace_all(plotinp$X1, "Vernot", "Vernot et al. 2016")

four <-   ggplot(plotinp, aes(X2*29,  group =X1, colour = X1))+
  theme_minimal() +
  ggtitle("Introgressed variants") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,4750000, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 500, key_glyph = "timeseries") +
  labs(x = "Years", y = "Variant count (squared)", colour = "Study:") +
  theme(legend.position = "top") +
  scale_y_sqrt() 



fig1row <- plot_grid(one, two, nrow = 1, labels = c("a", "b"))
threetwice <- plot_grid(three, threeplus, rel_widths = c(1,0.7), scale = c(1,0.8),  labels = c("d", "e"))
fig1ro2 <- plot_grid(four,threetwice, labels = c("c", ""), nrow = 1, rel_widths = c(0.6,1))

fig1 <- plot_grid(fig1row,fig1ro2, nrow = 2)

ggsave2("~/Desktop/overleaf/fig1.pdf", fig1, width =17, height = 10)

