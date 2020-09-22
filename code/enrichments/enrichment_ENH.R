library(ggplot2)

ggplot(hf_COMBINED, aes(V23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 500)+geom_vline(xintercept =  `200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results`$V23*29, colour = "green", alpha = 0.05)+ylab("Count")+xlab("Years")+ggtitle("ENH ONLY HUMAN CBC")

ggplot(hf_COMBINED, aes(V23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 500)+geom_vline(xintercept =  `200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results`$V23*29, colour = "red", alpha = 0.05)+ylab("Count")+xlab("Years")+ggtitle("ENH ONLY HUMAN PFC")

ggplot(hf_COMBINED, aes(V23*29))+
  theme_minimal() +
  geom_freqpoly(stat = "bin", bins = 500)+geom_vline(xintercept =  `200501_H3K27ac_TC_onlyHuman2497_rsIDs_results`$V23*29, colour = "blue", alpha = 0.05)+ylab("Count")+xlab("Years")+ggtitle("ENH ONLY HUMAN TC")

#Checking numbers
cbc <- data.frame(`200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results`$V23 * 29)
pfc <- data.frame(`200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results`$V23 * 29)
tc <- data.frame(`200501_H3K27ac_TC_onlyHuman2497_rsIDs_results`$V23 * 29)

cbc$rsID <- `200501_H3K27ac_CBC_onlyHuman1485_rsIDs_results`$V1
pfc$rsID <- `200501_H3K27ac_PFC_onlyHuman2487_rsIDs_results`$V1
tc$rsID <- `200501_H3K27ac_TC_onlyHuman2497_rsIDs_results`$V1

names(cbc) <- c("V23*29", "rsID")
names(pfc) <- c("V23*29", "rsID")
names(tc) <- c("V23*29", "rsID")

nrow(cbc) #1174
nrow(pfc) #2009
nrow(tc) #1994

cbc1 <-filter(cbc, between(`V23*29`,  0, 300000))
cbc2 <-filter(cbc, between(`V23*29`, 500000, 1000000))
(length(cbc1$`V23*29`)/length(cbc$`V23*29`))*100
(length(cbc2$`V23*29`)/length(cbc$`V23*29`))*100

pfc1 <-filter(pfc, between(`V23*29`,  0, 300000))
pfc2 <-filter(pfc, between(`V23*29`, 500000, 1000000))
(length(pfc1$`V23*29`)/length(pfc$`V23*29`))*100
(length(pfc2$`V23*29`)/length(pfc$`V23*29`))*100

tc1 <-filter(tc, between(`V23*29`,  0, 300000))
tc2 <-filter(tc, between(`V23*29`, 500000, 1000000))
(length(tc1$`V23*29`)/length(tc$`V23*29`))*100
(length(tc2$`V23*29`)/length(tc$`V23*29`))*100 
