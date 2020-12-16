library(tidiverse)
library(cowplot)


x <- ggplot(p, aes(value*29, y = forcats::fct_rev(factor(L1)))) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  guides(color = FALSE) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top")

y <- ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50, key_glyph = "timeseries") +
  labs(x = "Years", y = "Variant count", color= "List") +
  guides(color = FALSE) +
  theme(legend.position = "top") +
  facet_grid(L1 ~ .) +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "black", alpha = 0.2)

col1 <- plot_grid(x, y, align = "v", axis = "b", ncol = 1, labels = c("a","b"))
test <- ggarrange(a + theme(axis.text.x = element_blank()), c + theme(axis.text.x = element_blank()), b, ncol = 2, heights = c(1,1,3), clip = "off", labels =  c("c", "", ""))
fig4 <- plot_grid(col1, test)
ggsave("fig4.pdf", fig4, width = 8 , height = 8)

