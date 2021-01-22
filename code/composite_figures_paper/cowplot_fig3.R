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



plot1 <- plot_grid(a, b, ncol = 2, labels = c("A", "B"), rel_widths = c(1,1))

ggsave("fig3.pdf", plot1, width = 20, height = 10)
