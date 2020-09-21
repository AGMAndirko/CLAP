all <- read_csv("Timeline_project/1_data/all_COMBINED.tsv", col_names = FALSE)
hf <- read_csv("Timeline_project/1_data/hf_COMBINED.tsv", col_names = FALSE)
hf_strict <- read_csv("Timeline_project/1_data/hf_strictCOMBINED.tsv", col_names = FALSE)
fixed <- read_csv("Timeline_project/1_data/fixed_COMBINED.tsv", col_names = FALSE)


ks.test(hf$X23, hf_strict$X23)
ks.test(all$X23, hf$X23)
ks.test(all$X23, hf_strict$X23) 

#Divided in two peaks: a recent one and a late one, since the distribution is bimodal
hfrecent <- hf %>% 
  subset(X23*29 <= 300000)

hf_strictrecent <- hf_strict %>% 
  subset(X23*29 <= 300000)

allrecent <- all %>% 
  subset(X23*29 <= 300000)

#Statistical tests
ks.test(hfrecent$X23, hf_strictrecent$X23)
ks.test(allrecent$X23, hfrecent$X23)
ks.test(allrecent$X23, hf_strictrecent$X23)
rm(allrecent, hf_strictrecent, hfrecent)


hfolderpeak <- hf %>% 
  subset(X23*29 >= 300000)

hf_strictolderpeak <- hf_strict %>% 
  subset(X23*29 >= 300000)

allolderpeak <- all %>% 
  subset(X23*29 >= 300000)

#Statistical tests
ks.test(hfolderpeak$X23, hf_strictolderpeak$X23)
ks.test(allolderpeak$X23, hfolderpeak$X23)
ks.test(allolderpeak$X23, hf_strictolderpeak$X23)
rm(allolderpeak, hf_strictolderpeak, hfolderpeak)