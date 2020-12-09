library(tidyverse)
library(cowplot)
library(egg)
#library(stringr)

hf <- read_csv("hf_COMBINED.tsv", col_names = FALSE)
a <- ggplot(hf, aes(X23*29)) + 	
  theme_classic() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 200000), limits =  c(0, 2750000)) +
	geom_freqpoly(stat = "bin", bins = 500) +
	ylab("Count") +
	xlab("") +
	ggtitle("")

genenames <- list.files(".", pattern = "*.out")
genes <- lapply(genenames, read_table2, col_names = FALSE)

plot <- NULL
plot$value <- unlist(lapply(genes, '[[', 23))
plot <- as.data.frame(plot)
times <- unlist(lapply(genes, nrow))
genenames <- str_remove_all(genenames, ".out")
plot$gene <- rep(genenames, times)

names <- read.delim("listgenes", sep="\n", fill=TRUE, header=FALSE, as.is=TRUE)
names <- names[,1]

plot$gene <- factor(plot$gene, levels = names)
plot <- as.data.frame(plot)

b <- ggplot(plot, aes(value*29, fct_rev(as_factor(gene)))) +
   theme_minimal() +
   scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 200000), limits =  c(0, 2750000)) +
   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
   #annotate("rect", xmin = 300000, xmax = 600000, ymin = -Inf,ymax = Inf, alpha=.3) +
   geom_point(size = 3, alpha = 0.2, color = "red") +
   labs(x = "Years", y = "Genes") +
   theme(legend.position = "top") +
   xlab("") +
   scale_y_discrete(position = "left")


#BAZ1B figure
# excess <- read_csv("dated_excess", col_names = FALSE)
# c <- ggplot(excess, aes(X23*29)) + 	
#   theme_classic() +
#   scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 200000), limits =  c(0, 2750000)) +
#   geom_freqpoly(stat = "bin", bins = 500) +
#   ylab("Count") +
#   xlab("")

#Selection
 b <- ggplot(plot, aes(value*29, fct_rev(as_factor(gene)))) +
   theme_minimal() +
   scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 200000), limits =  c(0, 2750000)) +
   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
   #annotate("rect", xmin = 300000, xmax = 600000, ymin = -Inf,ymax = Inf, alpha=.3) +
   geom_point(size = 3, alpha = 0.2, color = "red") +
   #gli3
   geom_point(data = plot[28:29,], size = 3, alpha = 0.2, color = "blue") +
   #runx2
   geom_point(data = plot[3,], size = 3, alpha = 0.2, color = "blue") +
   labs(x = "Years", y = "Genes") +
   theme(legend.position = "top") +
   xlab("") +
   scale_y_discrete(position = "left")

 
test <- ggarrange(a + theme(axis.text.x = element_blank()), b, ncol = 1, heights = c(5,1), clip = "off")
ggsave("plot.pdf", test)
 
#test <- ggarrange(a + theme(axis.text.x = element_blank()), c + theme(axis.text.x = element_blank()), b, ncol = 2, heights = c(1,1,3), clip = "off")
#ggsave("plot.pdf", test)
