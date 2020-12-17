library(cowplot)
library(viridis)

one <- ggplot(all, aes(X23*29))+
  theme_minimal() +
  ggtitle("Distribution of overall derived, HF and HF (pop. filter)") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
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
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = c(0, 300000, 500000, 1000000)) + # 6218702 = max(all$X23*29) 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_density(stat = "bin", bins = 500) +
  geom_density(data = dplyr::filter(hf, variab == '1'), stat = "bin", bins = 500, fill = "#39568CFF") +
  geom_density(data = dplyr::filter(hf, variab == '2'), stat = "bin", bins = 500, fill = "#73D055FF") +
  geom_density(data = dplyr::filter(hf, variab == '3'), stat = "bin", bins = 500, fill = "#1F968BFF") +
  geom_density(data = dplyr::filter(hf, variab == '4'), stat = "bin", bins = 500, fill = "gray98") +
  labs(x = "Years", y = "HF Variant count")


p$L1 <- str_replace_all(p$L1, "Akey", "Akey et al. 2020")
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
  scale_y_sqrt() 

fig1 <- plot_grid(one, two, four, three, labels = "AUTO")
ggsave2("~/Desktop/deletw/test.pdf", fig1, width = 17, height = 10)

