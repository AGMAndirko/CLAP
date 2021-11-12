library(tidyverse)
library(reshape)
library(ggridges)

import_data <- function(path, id) {
  file_COMBINED <- read_csv(path, col_names = FALSE)
  file <- NULL
  file$value <- file_COMBINED$X23*29
  file$variable <- rep(c(id), length(file$value))
  file <- as.data.frame(file)
  return(file)
}

df <- NULL
ind = 1
#note: printing the 1000 permutations might take a while or overload memory
while(ind < 1000 ){
  print(paste0("Doing permutation nr:", ind))
  perm <- read_csv(paste0("perm", ind, ".csv"), col_names = FALSE)
  df[[paste0("X", ind)]] <- perm$X2
  ind = ind+1
} 

#Modify path directory accordingly
all <- import_data("../../distributions/all_COMBINED.tsv", "All derived")
hf <- import_data("../../distributions/hf_COMBINED.tsv", "HF derived")
hf_strict <- import_data("../../distributions/hf_strictCOMBINED.tsv", "HF derived (pop. filter)")
fixed <- import_data("../../distributions/fixed_COMBINED.tsv", "Fixed derived")

df <- as.data.frame(df)
df <- melt(df)
df['variable'] <- "Control regions"
df <- rbind(df, hf, hf_strict, all, fixed)

df <- df %>% 
  mutate(variable = fct_relevel(variable, 
                                "Fixed derived",
                                "HF derived (pop. filter)",
                                "HF derived", "All derived",
                                "Control regions"))

pdf("fig1.pdf", width =10, height=6  )
ggplot(df, aes(value, variable)) +
  theme_minimal() +
  #ggtitle("Random regions (n=1000) and H. sapiens specific-variants") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 200000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75), trim = TRUE, adjust = 4) +
  labs(x = "Years", y = "Dataset") 
dev.off()