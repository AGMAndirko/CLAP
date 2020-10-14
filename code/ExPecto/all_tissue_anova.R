library(tidyverse)
library(magrittr)
library(reshape2)
library(ggfortify)

input <- read_csv("alloutput.csv") 
#Here I'm getting all locations affecting brain tissue expression
out <- input[,-(1:10),drop=FALSE]
out <- out %>% 
  select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 
out <- melt(out)

model <- lm(value ~ variable,
           data=out)

anova(model)     
summary(model) 

boxplot(value ~ variable,
        data = out,
        xlab = "Tissue",
        ylab = "Variant expression")

