library(gwasglue)
library(tidyverse)
library(ieugwasr)
library(magrittr)
library(reshape2)
library(gwasglue)
library(TwoSampleMR)
library(rsnps)

input <- read_csv("combinedoutput.csv")
#as produced by the ExPecto_generation.sh script

#Here I'm getting all locations affecting brain tissue expression
out <- input[,-(1:10),drop=FALSE]
out <- out %>% 
  select(3,8,9, 10, 11, 12, 13, 14, 15, 16,17,18,20, 42, 61, 136, 145, 161, 186, 187, 189, 209) 
out <- as.data.frame(out)
out <- melt(out, value.name = "beta", variable.name = "Phenotype")

#Beta and phenotype to conform to future TwoSampleMR specifications

#This must give TRUE!
878614/39937 == 22

#Add locations, gene, effect allele
out$locations <- unite(input, `0`, `1`, col = "test", sep = ":") %>% 
  pull(test)
out$gene <- pull(input, var = 9) 
out$effect_allele <- pull(input, var = 6)

#Now I can filter as I want!

values with high expression
input <- out %>% 
  filter(value >= 0.001)
GO <- gprofiler2::gost(input$genes)
#Nice terms but not much to say 

howmanyleft <- table(input$variable) 
howmanyleft <- as.data.frame(howmanyleft)

#Not totally homogeneous but more or less consistent
ggplot(howmanyleft, aes(x = Freq, y = Var1)) +
  geom_col(color = "darkblue", fill = "steelblue")
#Related to original sample size?

#Trying out phewas
input <- out %>% 
  filter(value >= 0.001)

phe_works <- phewas(variants=input[[3]], pval=1e-5)
phe_works 
#Contains a list of all highly-expressed variants that are a top result in a gwas

#Are this variants more likely to be top results in a GWAS?


#Let's try something specific: formatting this as exposure data
#remove NA's
out <- out[complete.cases(out), ]
summary(out$beta)

snps <- unite(input, `0`, `1`, col = "test", sep = ":") %>% 
  pull(test)



#Standard error of effect size
std <- function(x) {
  sd(x)/sqrt(length(x))
}

#Add to column  
out  <- out %>%
  group_by(Phenotype) %>%
  mutate(se = std(beta))

#outcome: cerebellum size
# ao <- available_outcomes()
# ao[grepl("cerebell", ao$trait), ]$trait
# ao[grepl("cerebell", ao$trait), ]$id

#expd1 <- TwoSampleMR::extract_instruments("ubm-a-399")
chd_out_dat <- extract_outcome_data(
  snps = out$locations,
  outcomes = 'ubm-a-399'
)

out$SNP <- NA
test <- variants_chrpos(snps)
ld_matrix(snps)
# Get instruments
exp_dat <- format_data(out, type="exposure")



    dat <- harmonise_data(
  exposure_dat = out,
  outcome_dat = chd_out_dat
)
