#!/usr/bin/env Rscript
library(tidyverse)
library(reshape2)
library(gprofiler2)
library(ggrepel)
library(cowplot)
library(ggplotify)

b <- ggplot(plotinp, aes(x=magnitude, y=directionality, colour = timing, label = genes)) +
  theme_minimal() +
  geom_point(size = 3) +
  labs(x= "Absolute magnitude of change", y = "Directionality (altternative allele)") +
  geom_label_repel(data = subset(plotinp,  magnitude > 2), colour = "black", nudge_y = 1 ) +
  facet_wrap(timing ~ ., ncol = 2)

#after Expecto_plots.R
a <- ggplot(allexpr, aes(x=time, y=value, group = variable)) +
  theme_minimal() +
  theme(legend.position = "top") +
  geom_line( color="grey") +
  geom_point( color="black") +
  geom_point(data = highlights, aes(x=time,y=value), color="red") +
  geom_label_repel(data = highlights, 
                   aes(x=time,y=value, label = variable), 
                   nudge_x = 0.1, nudge_y = -0.1, 
                   label.size = 0.05) +
  labs(title="", x = "Time window",
       y = "Sum of variant predicted expression (logFC)")


# hf <- hf_COMBINED %>% 
#   mutate(variab = case_when(
#     (X23 >= 0 & X23*29 <= 60000) ~ "1",
#     (X23*29 >= 60000 & X23*29 <=100000) ~ "2",
#     (X23*29 >= 100000 & X23*29 <=200000) ~ "3",
#     (X23*29 >= 200000 & X23*29 <=300000) ~ "4",
#     (X23*29 >= 300000 & X23*29 <=500000) ~ "5",
#     (X23*29 >= 500000 & X23*29 <=800000) ~ "6",
#     (X23*29 > 8000000) ~ "7",
#     TRUE ~ NA_character_
#   ))
# 
# c <- ggplot(hf, aes(X23*29))+
#   theme_minimal() +
#   ggtitle("Selected time windows timemarks") +
#   scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = c(0, 60000, 100000, 200000, 300000, 500000, 800000), limits = c(0,800000)) + # 6218702 = max(all$X23*29) 
#   theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
#   geom_density(stat = "bin", bins = 500) +
#   geom_density(data = dplyr::filter(hf, variab == '1'), stat = "bin", bins = 500, fill = "#39568CFF") +
#   geom_density(data = dplyr::filter(hf, variab == '2'), stat = "bin", bins = 500, fill = "#73D055FF") +
#   geom_density(data = dplyr::filter(hf, variab == '3'), stat = "bin", bins = 500, fill = "#1F968BFF") +
#   geom_density(data = dplyr::filter(hf, variab == '4'), stat = "bin", bins = 500, fill = "#404788FF") +
#   geom_density(data = dplyr::filter(hf, variab == '5'), stat = "bin", bins = 500, fill = "#2D708EFF") +
#   geom_density(data = dplyr::filter(hf, variab == '6'), stat = "bin", bins = 500, fill = "#B8DE29FF") +
#   geom_density(data = dplyr::filter(hf, variab == '7'), stat = "bin", bins = 500, fill = "gray98") +
#   labs(x = "Years", y = "HF Variant count")

plot1 <- plot_grid(a, b, ncol = 2, labels = c("A", "B"), rel_widths = c(1,1))
#plot2 <- plot_grid(c, ncol = 1, labels = c("C"))
#plot <- plot_grid(plot2, plot1,  ncol = 1)
ggsave("fig3.pdf", plot1, width = 20, height = 10)
