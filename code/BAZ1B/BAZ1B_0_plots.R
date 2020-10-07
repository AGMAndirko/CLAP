library(tidyverse)
library(reshape2)

temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/4D01/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/4D01/",temp[i]), header = FALSE))

p <- NULL
p$ATP6AP1 <- ATP6AP1.out$V23
p$CYP2R1 <- CYP2R1.out$V23
p$DNASE1 <- DNASE1.out$V23
p$F12 <- F12.out$V23
p$GRK6 <- GRK6.out$V23
p$IGF2 <- IGF2.out$V23
p$MMP15 <- MMP15.out$V23
p$MXD3 <- MXD3.out$V23
p$NUMA1 <- NUMA1.out$V23
p$PAFAH1B1 <- PAFAH1B1.out$V23
p$PRKAR2A <- PRKAR2A.out$V23
p$PSMD8 <- PSMD8.out$V23
p$`PTBP1` <- `PTBP1.out`$V23
p$`RP11-867G23` <- `RP11-867G23.out`$V23
p$TAF12 <- TAF12.out$V23
p$VAV1 <- VAV1.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)

#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_4DFDR01.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B 4D .01 list") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()

rm(list = ls())
 
temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/4D025/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/4D025/",temp[i]), header = FALSE))

p <- NULL
p$APRT <- APRT.out$V23
p$ATCAY <- ATCAY.out$V23
p$ATP11A <- ATP11A.out$V23
p$ATP6AP1 <- ATP6AP1.out$V23
p$AURKC <- AURKC.out$V23
p$C14orf93 <- C14orf93.out$V23
p$C9orf89 <- C9orf89.out$V23
p$CADM1 <- CADM1.out$V23
p$CCDC159 <- CCDC159.out$V23
p$CCDC71 <- CCDC71.out$V23
p$CD81 <- CD81.out$V23
p$CDC25B <- CDC25B.out$V23
p$CEL <- CEL.out$V23
p$CEP19 <- CEP19.out$V23
p$CHID1 <- CHID1.out$V23
p$CLASRP <- CLASRP.out$V23
p$CLPTM1 <- CLPTM1.out$V23
p$CNN1 <- CNN1.out$V23
p$COG4 <- COG4.out$V23
p$COLEC11 <- COLEC11.out$V23
p$COX6B1 <- COX6B1.out$V23
p$CPXM1 <- CPXM1.out$V23
p$CREB3 <- CREB3.out$V23
p$CSNK2A2 <- CSNK2A2.out$V23
p$CYP2R1 <- CYP2R1.out$V23
p$DDX19A <- DDX19A.out$V23
p$DKFZP761J1410 <- DKFZP761J1410.out$V23
p$DNASE1 <- DNASE1.out$V23
p$DNASE2 <- DNASE2.out$V23
p$DNM2 <- DNM2.out$V23
p$DSN1 <- DSN1.out$V23
p$EHD1 <- EHD1.out$V23
p$EIF4H <- EIF4H.out$V23
p$ENST00000384478 <- ENST00000384478.out$V23
p$ENST00000413042 <- ENST00000413042.out$V23
p$EP400 <- EP400.out$V23
p$F12 <- F12.out$V23
p$FAM129A <- FAM129A.out$V23
p$FGF8 <- FGF8.out$V23
p$FTCD <- FTCD.out$V23
p$GPAA1 <- GPAA1.out$V23
p$GRK6 <- GRK6.out$V23
p$GRM4 <- GRM4.out$V23
p$HDAC5 <- HDAC5.out$V23
p$HMGA1 <- HMGA1.out$V23
p$HPN <- HPN.out$V23
p$HPS3 <- HPS3.out$V23
p$IGF2 <- IGF2.out$V23
p$INO80B <- INO80B.out$V23
p$INTS4 <- INTS4.out$V23
p$ITGAL <- ITGAL.out$V23
p$KANK2 <- KANK2.out$V23
p$KCTD10 <- KCTD10.out$V23
p$KLHDC8B <- KLHDC8B.out$V23
p$LAD1 <- LAD1.out$V23
p$LAMB2 <- LAMB2.out$V23
p$LCN1 <- LCN1.out$V23
p$LDLRAP1 <- LDLRAP1.out$V23
p$LDLR <- LDLR.out$V23
p$LMNB2 <- LMNB2.out$V23
p$LRP10 <- LRP10.out$V23
p$LZTR1 <- LZTR1.out$V23
p$LZTS3 <- LZTS3.out$V23
p$MBD3 <- MBD3.out$V23
p$MED15 <- MED15.out$V23
p$MGEA5 <- MGEA5.out$V23
p$MINK1 <- MINK1.out$V23
p$MMP11 <- MMP11.out$V23
p$MMP15 <- MMP15.out$V23
p$MRPS2 <- MRPS2.out$V23
p$MXD3 <- MXD3.out$V23
p$MYCBPAP <- MYCBPAP.out$V23
p$MYL9 <- MYL9.out$V23
p$NEDD9 <- NEDD9.out$V23
p$NKAIN1 <- NKAIN1.out$V23
p$NLGN2 <- NLGN2.out$V23
p$NLRP1 <- NLRP1.out$V23
p$NOP2 <- NOP2.out$V23
p$NUMA1 <- NUMA1.out$V23
p$NUP210 <- NUP210.out$V23
p$PABPC4 <- PABPC4.out$V23
p$PAFAH1B1 <- PAFAH1B1.out$V23
p$PHB2 <- PHB2.out$V23
p$PIGV <- PIGV.out$V23
p$PIGX <- PIGX.out$V23
p$PLK3 <- PLK3.out$V23
p$PRAM1 <- PRAM1.out$V23
p$PRKAR2A <- PRKAR2A.out$V23
p$PRKCSH <- PRKCSH.out$V23
p$PRR14 <- PRR14.out$V23
p$PSMD8 <- PSMD8.out$V23
p$PTBP1 <- PTBP1.out$V23
p$PUF60 <- PUF60.out$V23
p$QARS <- QARS.out$V23
p$QRICH1 <- QRICH1.out$V23
p$RAB3D <- RAB3D.out$V23
p$RALGDS <- RALGDS.out$V23
p$RALY <- RALY.out$V23
p$RANGRF <- RANGRF.out$V23
p$RARA <- RARA.out$V23
p$RBM12 <- RBM12.out$V23
p$`RP11-867G23` <- `RP11-867G23.out$V23`
p$RPL14 <- RPL14.out$V23
p$RPS28 <- RPS28.out$V23
p$SALL4 <- SALL4.out$V23
p$SENP3 <- SENP3.out$V23
p$SEPT9 <- SEPT9.out$V23
p$SFMBT1 <- SFMBT1.out$V23
p$SFXN3 <- SFXN3.out$V23
p$SH2D6 <- SH2D6.out$V23
p$SLC22A24 <- SLC22A24.out$V23
p$SLC22A6 <- SLC22A6.out$V23
p$SLC27A5 <- SLC27A5.out$V23
p$SMARCB1 <- SMARCB1.out$V23
p$SYNDIG1 <- SYNDIG1.out$V23
p$TAF12 <- TAF12.out$V23
p$TGFB1I1 <- TGFB1I1.out$V23
p$TH <- TH.out$V23
p$TMEM184B <- TMEM184B.out$V23
p$TMEM205 <- TMEM205.out$V23
p$TMEM25 <- TMEM25.out$V23
p$TMEM62 <- TMEM62.out$V23
p$TMEM63C <- TMEM63C.out$V23
p$TNNT2 <- TNNT2.out$V23
p$TRMT1 <- TRMT1.out$V23
p$TXLNA <- TXLNA.out$V23
p$UBXN1 <- UBXN1.out$V23
p$VAV1 <- VAV1.out$V23
p$WDR6 <- WDR6.out$V23
p$WNT2 <- WNT2.out$V23
p$ZNF280A <- ZNF280A.out$V23
p$ZNF324 <- ZNF324.out$V23
p$ZNF384 <- ZNF384.out$V23
p$ZNF544 <- ZNF544.out$V23
p$ZNF747 <- ZNF747.out$V23
p$ZNF768 <- ZNF768.out$V23
p$ZNF775 <- ZNF775.out$V23
p$ZNF79 <- ZNF79.out$V23
p$ZNF8 <- ZNF8.out$V23
p$ZSCAN18 <- ZSCAN18.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)

#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_4DFDR025.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B 4D .025 list") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()

rm(list = ls())

temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/Prom01/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/Prom01/",temp[i]), header = FALSE))

p <- NULL
p$AMH <- AMH.out$V23
p$AP2A1 <- AP2A1.out$V23
p$CERS1 <- CERS1.out$V23
p$COL18A1 <- COL18A1.out$V23
p$CROCC <- CROCC.out$V23
p$GDF1 <- GDF1.out$V23
p$GGN <- GGN.out$V23
p$ITIH4-AS1 <- ITIH4-AS1.out$V23
p$ITIH4 <- ITIH4.out$V23
p$KDM4B <- KDM4B.out$V23
p$LGR6 <- LGR6.out$V23
p$MAD1L1 <- MAD1L1.out$V23
p$MAMDC4 <- MAMDC4.out$V23
p$MIR3187 <- MIR3187.out$V23
p$MIR3940 <- MIR3940.out$V23
p$NLRC3 <- NLRC3.out$V23
p$NOP2 <- NOP2.out$V23
p$NPAS4 <- NPAS4.out$V23
p$OSBPL10 <- OSBPL10.out$V23
p$PDE2A <- PDE2A.out$V23
p$PFKFB4 <- PFKFB4.out$V23
p$RANBP1 <- RANBP1.out$V23
p$SERF2 <- SERF2.out$V23
p$SLC16A3 <- SLC16A3.out$V23
p$SLC41A3 <- SLC41A3.out$V23
p$SMARCA4 <- SMARCA4.out$V23
p$SNORA51 <- SNORA51.out$V23
p$SNORD56 <- SNORD56.out$V23
p$TAF12 <- TAF12.out$V23
p$TBC1D2 <- TBC1D2.out$V23
p$TBCD <- TBCD.out$V23
p$TNS3 <- TNS3.out$V23
p$UCN2 <- UCN2.out$V23
p$USP28 <- USP28.out$V23
p$ZNF618 <- ZNF618.out$V23


#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)

#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)


pdf("BAZ1B_PromFDR01.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B bound by Promoter - .01 list") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()

rm(list = ls())
temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_0/Prom025/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_0/Prom025/",temp[i]), header = FALSE))

p<- NULL
p$ABAT <- ABAT.out$V23
p$ACAP3 <- ACAP3.out$V23
p$ACSL1 <- ACSL1.out$V23
p$ACSS1 <- ACSS1.out$V23
p$ADAP1 <- ADAP1.out$V23
p$ADORA2A <- ADORA2A.out$V23
p$AHCYL1 <- AHCYL1.out$V23
p$ALKBH4 <- ALKBH4.out$V23
p$AMH <- AMH.out$V23
p$ANKLE2 <- ANKLE2.out$V23
p$AP2A1 <- AP2A1.out$V23
p$APBA2 <- APBA2.out$V23
p$APC2 <- APC2.out$V23
p$APOC2 <- APOC2.out$V23
p$APOC4-APOC2 <- APOC4-APOC2.out$V23
p$APOC4 <- APOC4.out$V23
p$ARHGEF11 <- ARHGEF11.out$V23
p$ARRB1 <- ARRB1.out$V23
p$ATAD2 <- ATAD2.out$V23
p$ATP6V0D1 <- ATP6V0D1.out$V23
p$BAIAP2L2 <- BAIAP2L2.out$V23
p$BIN1 <- BIN1.out$V23
p$C1orf35 <- C1orf35.out$V23
p$C20orf144 <- C20orf144.out$V23
p$C2CD2 <- C2CD2.out$V23
p$C2orf71 <- C2orf71.out$V23
p$C3orf67 <- C3orf67.out$V23
p$C6orf1 <- C6orf1.out$V23
p$C9orf114 <- C9orf114.out$V23
p$C9orf116 <- C9orf116.out$V23
p$CCDC12 <- CCDC12.out$V23
p$CCDC33 <- CCDC33.out$V23
p$CCDC88C <- CCDC88C.out$V23
p$CD81 <- CD81.out$V23
p$CDAN1 <- CDAN1.out$V23
p$CDT1 <- CDT1.out$V23
p$CERS1 <- CERS1.out$V23
p$CHAD <- CHAD.out$V23
p$COL18A1 <- COL18A1.out$V23
p$CORO2B <- CORO2B.out$V23
p$CPA5 <- CPA5.out$V23
p$CPNE1 <- CPNE1.out$V23
p$CROCC <- CROCC.out$V23
p$CTIF <- CTIF.out$V23
p$DISC1 <- DISC1.out$V23
p$DNAH9 <- DNAH9.out$V23
p$DNASE1 <- DNASE1.out$V23
p$DNMT3A <- DNMT3A.out$V23
p$DUSP7 <- DUSP7.out$V23
p$ECE1 <- ECE1.out$V23
p$EIF4EBP3 <- EIF4EBP3.out$V23
p$EPHB2 <- EPHB2.out$V23
p$FAM189B <- FAM189B.out$V23
p$FBLN7 <- FBLN7.out$V23
p$GALNT2 <- GALNT2.out$V23
p$GDF1 <- GDF1.out$V23
p$GGN <- GGN.out$V23
p$GPC1 <- GPC1.out$V23
p$GPR55 <- GPR55.out$V23
p$GPR62 <- GPR62.out$V23
p$GRAMD4 <- GRAMD4.out$V23
p$GRIP2 <- GRIP2.out$V23
p$GSE1 <- GSE1.out$V23
p$IL18BP <- IL18BP.out$V23
p$IQCG <- IQCG.out$V23
p$ISLR <- ISLR.out$V23
p$ITGB5 <- ITGB5.out$V23
p$ITIH4-AS1 <- ITIH4-AS1.out$V23
p$ITIH4 <- ITIH4.out$V23
p$KCNJ12 <- KCNJ12.out$V23
p$KDM4B <- KDM4B.out$V23
p$KIAA0930 <- KIAA0930.out$V23
p$KIF13A <- KIF13A.out$V23
p$KSR1 <- KSR1.out$V23
p$LAT <- LAT.out$V23
p$LDB1 <- LDB1.out$V23
p$LGI4 <- LGI4.out$V23
p$LGR6 <- LGR6.out$V23
p$LINC00487 <- LINC00487.out$V23
p$LINC00696 <- LINC00696.out$V23
p$LINC00926 <- LINC00926.out$V23
p$LMLN <- LMLN.out$V23
p$LRRC14 <- LRRC14.out$V23
p$LZTR1 <- LZTR1.out$V23
p$MAD1L1 <- MAD1L1.out$V23
p$MAMDC4 <- MAMDC4.out$V23
p$MAP3K10 <- MAP3K10.out$V23
p$MAP4K2 <- MAP4K2.out$V23
p$MARCH6 <- MARCH6.out$V23
p$MBNL2 <- MBNL2.out$V23
p$MCM3AP-AS1 <- MCM3AP-AS1.out$V23
p$MED16 <- MED16.out$V23
p$MED22 <- MED22.out$V23
p$MICALL2 <- MICALL2.out$V23
p$MIR1286 <- MIR1286.out$V23
p$MIR149 <- MIR149.out$V23
p$`MIR194-2` <- `MIR194-2.out`$V23
p$MIR3187 <- MIR3187.out$V23
p$MIR3940 <- MIR3940.out$V23
p$MIR4261 <- MIR4261.out$V23
p$MIR4288 <- MIR4288.out$V23
p$MIR4656 <- MIR4656.out$V23
p$MIR4745 <- MIR4745.out$V23
p$MIR4763 <- MIR4763.out$V23
p$MIRLET7A3 <- MIRLET7A3.out$V23
p$MIRLET7B <- MIRLET7B.out$V23
p$MLLT1 <- MLLT1.out$V23
p$MRPS2 <- MRPS2.out$V23
p$MTSS1 <- MTSS1.out$V23
p$MTUS2-AS1 <- MTUS2-AS1.out$V23
p$MYBPH <- MYBPH.out$V23
p$NADK <- NADK.out$V23
p$NECAB3 <- NECAB3.out$V23
p$NLRC3 <- NLRC3.out$V23
p$NOD1 <- NOD1.out$V23
p$NOP2 <- NOP2.out$V23
p$NOS3 <- NOS3.out$V23
p$NPAS4 <- NPAS4.out$V23
p$NSUN4 <- NSUN4.out$V23
p$NUPL2 <- NUPL2.out$V23
p$OBSCN <- OBSCN.out$V23
p$OSBPL10 <- OSBPL10.out$V23
p$OSBPL5 <- OSBPL5.out$V23
p$OSGIN1 <- OSGIN1.out$V23
p$P2RX3 <- P2RX3.out$V23
p$P2RY11 <- P2RY11.out$V23
p$PAK2 <- PAK2.out$V23
p$PDE2A <- PDE2A.out$V23
p$PFKFB4 <- PFKFB4.out$V23
p$PHACTR3 <- PHACTR3.out$V23
p$PIGQ <- PIGQ.out$V23
p$PLXNA1 <- PLXNA1.out$V23
p$PRICKLE2 <- PRICKLE2.out$V23
p$PSD2 <- PSD2.out$V23
p$PSD3 <- PSD3.out$V23
p$PTPN3 <- PTPN3.out$V23
p$PTPRS <- PTPRS.out$V23
p$PUSL1 <- PUSL1.out$V23
p$PXDC1 <- PXDC1.out$V23
p$PYY <- PYY.out$V23
p$RAD23A <- RAD23A.out$V23
p$RALGDS <- RALGDS.out$V23
p$RANBP1 <- RANBP1.out$V23
p$RECQL4 <- RECQL4.out$V23
p$RELT <- RELT.out$V23
p$RGS3 <- RGS3.out$V23
p$RNF2 <- RNF2.out$V23
p$RNPS1 <- RNPS1.out$V23
p$`RNU6-2` <- `RNU6-2.out`$V23
p$`RNU6-9` <- `RNU6-9.out`$V23
p$RPL14 <- RPL14.out$V23
p$RXRA <- RXRA.out$V23
p$S100Z <- S100Z.out$V23
p$SCRIB <- SCRIB.out$V23
p$SEPT9 <- SEPT9.out$V23
p$SERF2 <- SERF2.out$V23
p$SH2B3 <- SH2B3.out$V23
p$SH2D6 <- SH2D6.out$V23
p$SIPA1 <- SIPA1.out$V23
p$SLC16A3 <- SLC16A3.out$V23
p$SLC24A4 <- SLC24A4.out$V23
p$SLC25A34 <- SLC25A34.out$V23
p$SLC25A6 <- SLC25A6.out$V23
p$SLC27A5 <- SLC27A5.out$V23
p$SLC35D2 <- SLC35D2.out$V23
p$SLC41A3 <- SLC41A3.out$V23
p$SLC45A2 <- SLC45A2.out$V23
p$SLC45A4 <- SLC45A4.out$V23
p$SLC9A3R2 <- SLC9A3R2.out$V23
p$SMARCA4 <- SMARCA4.out$V23
p$SMTN <- SMTN.out$V23
p$SNORA51 <- SNORA51.out$V23
p$SNORA67 <- SNORA67.out$V23
p$`SNORD116-14` <- `SNORD116-14.out`$V23
p$`SNORD116-15` <- `SNORD116-15.out`$V23
p$`SNORD116-16` <- `SNORD116-16.out`$V23
p$`SNORD116-17` <- `SNORD116-17.out`$V23
p$`SNORD116-18` <- `SNORD116-18.out`$V23
p$`SNORD116-19` <- `SNORD116-19.out`$V23
p$SNORD24 <- SNORD24.out$V23
p$SNORD36A <- SNORD36A.out$V23
p$SNORD36B <- SNORD36B.out$V23
p$SNORD36C <- SNORD36C.out$V23
p$SNORD56 <- SNORD56.out$V23
p$SNORD66 <- SNORD66.out$V23
p$SPDEF <- SPDEF.out$V23
p$SSUH2 <- SSUH2.out$V23
p$ST8SIA2 <- ST8SIA2.out$V23
p$SURF1 <- SURF1.out$V23
p$SURF2 <- SURF2.out$V23
p$SYNRG <- SYNRG.out$V23
p$TAF12 <- TAF12.out$V23
p$TBC1D2 <- TBC1D2.out$V23
p$TBCD <- TBCD.out$V23
p$TEX22 <- TEX22.out$V23
p$TEX29 <- TEX29.out$V23
p$TIMM13 <- TIMM13.out$V23
p$TMEM25 <- TMEM25.out$V23
p$TMEM82 <- TMEM82.out$V23
p$TNS1 <- TNS1.out$V23
p$TNS3 <- TNS3.out$V23
p$TRMT2A <- TRMT2A.out$V23
p$TUBB4B <- TUBB4B.out$V23
p$UCN2 <- UCN2.out$V23
p$UNK <- UNK.out$V23
p$USP19 <- USP19.out$V23
p$USP28 <- USP28.out$V23
p$VASH1 <- VASH1.out$V23
p$WDR90 <- WDR90.out$V23
p$WHSC1 <- WHSC1.out$V23
p$ZBTB4 <- ZBTB4.out$V23
p$ZFAT <- ZFAT.out$V23
p$ZFP64 <- ZFP64.out$V23
p$ZFPM1 <- ZFPM1.out$V23
p$ZMIZ2 <- ZMIZ2.out$V23
p$ZNF219 <- ZNF219.out$V23
p$ZNF280B <- ZNF280B.out$V23
p$ZNF366 <- ZNF366.out$V23
p$ZNF3 <- ZNF3.out$V23
p$ZNF43 <- ZNF43.out$V23
p$ZNF543 <- ZNF543.out$V23
p$ZNF618 <- ZNF618.out$V23
p$ZNF70 <- ZNF70.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)
#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_PromFDR025.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B bound by Promoter - .025 list") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()
