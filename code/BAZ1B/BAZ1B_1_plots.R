library(tidyverse)
library(reshape2)

temp <- list.files(path = "Timeline_project/1_data/BAZ1B/orig/dir/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/orig/dir/",temp[i]), header = FALSE))

p <- NULL
p$ABCC4 <- ABCC4.out$V23
p$ABCG1 <- ABCG1.out$V23
p$ABLIM2 <- ABLIM2.out$V23
p$ACOT11 <- ACOT11.out$V23
p$ADK <- ADK.out$V23
p$AIM1L <- AIM1L.out$V23
p$AKR1B1 <- AKR1B1.out$V23
p$ANP32A <- ANP32A.out$V23
p$ARFGAP1 <- ARFGAP1.out$V23
p$B3GAT1 <- B3GAT1.out$V23
p$BANF1 <- BANF1.out$V23
p$C1orf35 <- C1orf35.out$V23
p$C9orf129 <- C9orf129.out$V23
p$CBX6 <- CBX6.out$V23
p$CCAR2 <- CCAR2.out$V23
p$CDK10 <- CDK10.out$V23
p$CDK18 <- CDK18.out$V23
p$CLEC2L <- CLEC2L.out$V23
p$COTL1 <- COTL1.out$V23
p$CRK <- CRK.out$V23
p$CYBA <- CYBA.out$V23
p$DNAJB6 <- DNAJB6.out$V23
p$DPF3 <- DPF3.out$V23
p$DTYMK <- DTYMK.out$V23
p$DUT <- DUT.out$V23
p$ELFN1 <- ELFN1.out$V23
p$ENG <- ENG.out$V23
p$EPHB1 <- EPHB1.out$V23
p$ERH <- ERH.out$V23
p$ETS2 <- ETS2.out$V23
p$FADS2 <- FADS2.out$V23
p$FAM49A <- FAM49A.out$V23
p$FBLN7 <- FBLN7.out$V23
p$FBXO41 <- FBXO41.out$V23
p$FEM1A <- FEM1A.out$V23
p$FLT4 <- FLT4.out$V23
p$FLVCR1 <- FLVCR1.out$V23
p$FRMD3 <- FRMD3.out$V23
p$FRMPD2 <- FRMPD2.out$V23
p$FXN <- FXN.out$V23
p$H2AFY <- H2AFY.out$V23
p$HDAC1 <- HDAC1.out$V23
p$HIPK1 <- HIPK1.out$V23
p$HMGN2 <- HMGN2.out$V23
p$HNRNPA2B1 <- HNRNPA2B1.out$V23
p$IL21R <- IL21R.out$V23
p$IL2RB <- IL2RB.out$V23
p$IMP3 <- IMP3.out$V23
p$ITGA6 <- ITGA6.out$V23
p$KCNIP1 <- KCNIP1.out$V23
p$KCNK9 <- KCNK9.out$V23
p$KIAA1147 <- KIAA1147.out$V23
p$LAPTM5 <- LAPTM5.out$V23
p$LARP4B <- LARP4B.out$V23
p$LMO1 <- LMO1.out$V23
p$LRRN4 <- LRRN4.out$V23
p$LSM6 <- LSM6.out$V23
p$MAGOH <- MAGOH.out$V23
p$MCM3AP <- MCM3AP.out$V23
p$MFN2 <- MFN2.out$V23
p$MLLT4 <- MLLT4.out$V23
p$MSH6 <- MSH6.out$V23
p$MTA1 <- MTA1.out$V23
p$MYO7A <- MYO7A.out$V23
p$NAT10 <- NAT10.out$V23
p$NCL <- NCL.out$V23
p$NSL1 <- NSL1.out$V23
p$NUP210 <- NUP210.out$V23
p$OLFM1 <- OLFM1.out$V23
p$PAX5 <- PAX5.out$V23
p$PIGY <- PIGY.out$V23
p$PLA2G3 <- PLA2G3.out$V23
p$PLXNA4 <- PLXNA4.out$V23
p$PMPCA <- PMPCA.out$V23
p$PPP1R15B <- PPP1R15B.out$V23
p$PRKAB1 <- PRKAB1.out$V23
p$PRKAR2B <- PRKAR2B.out$V23
p$PRKCQ <- PRKCQ.out$V23
p$PWP2 <- PWP2.out$V23
p$PYURF <- PYURF.out$V23
p$RAB4A <- RAB4A.out$V23
p$RCOR1 <- RCOR1.out$V23
p$RPL11 <- RPL11.out$V23
p$RPRD1B <- RPRD1B.out$V23
p$SALL4 <- SALL4.out$V23
p$SARNP <- SARNP.out$V23
p$SBK1 <- SBK1.out$V23
p$SEC14L6 <- SEC14L6.out$V23
p$SH3BP1 <- SH3BP1.out$V23
p$SH3TC1 <- SH3TC1.out$V23
p$SLC27A5 <- SLC27A5.out$V23
p$SLC35G1 <- SLC35G1.out$V23
p$SMYD3 <- SMYD3.out$V23
p$SRC <- SRC.out$V23
p$SRPK2 <- SRPK2.out$V23
p$SSB <- SSB.out$V23
p$STK39 <- STK39.out$V23
p$TAF1B <- TAF1B.out$V23
p$TARDBP <- TARDBP.out$V23
p$TFDP1 <- TFDP1.out$V23
p$TGFBR3 <- TGFBR3.out$V23
p$TMC8 <- TMC8.out$V23
p$TMCO4 <- TMCO4.out$V23
p$TMEM163 <- TMEM163.out$V23
p$TOMM7 <- TOMM7.out$V23
p$TRIQK <- TRIQK.out$V23
p$TSPAN3 <- TSPAN3.out$V23
p$UBE2V2 <- UBE2V2.out$V23
p$UQCRFS1 <- UQCRFS1.out$V23
p$USP13 <- USP13.out$V23
p$VAPA <- VAPA.out$V23
p$VASH1 <- VASH1.out$V23
p$XYLT1 <- XYLT1.out$V23
p$ZDHHC2 <- ZDHHC2.out$V23
p$ZNF22 <- ZNF22.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)

#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B DIR DE genes.pdf")

ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("Dir") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")

dev.off()

 

#INV 
rm(list = ls())
temp <- list.files(path = "Timeline_project/1_data/BAZ1B/orig/inv/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/orig/inv/",temp[i]), header = FALSE))

p <- NULL
p$AACS <- AACS.out$V23
p$ABL1 <- ABL1.out$V23
p$AKNA <- AKNA.out$V23
p$ANK2 <- ANK2.out$V23
p$ANKFY1 <- ANKFY1.out$V23
p$ANKRD23 <- ANKRD23.out$V23
p$ANKRD44 <- ANKRD44.out$V23
p$AP2A1 <- AP2A1.out$V23
p$ARAP2 <- ARAP2.out$V23
p$ARHGAP42 <- ARHGAP42.out$V23
p$ARID5B <- ARID5B.out$V23
p$ATRN <- ATRN.out$V23
p$BASP1 <- BASP1.out$V23
p$BBX <- BBX.out$V23
p$BCAT2 <- BCAT2.out$V23
p$BCL2L11 <- BCL2L11.out$V23
p$BIK <- BIK.out$V23
p$C3orf70 <- C3orf70.out$V23
p$CBLB <- CBLB.out$V23
p$CBX4 <- CBX4.out$V23
p$CD36 <- CD36.out$V23
p$CDC42BPB <- CDC42BPB.out$V23
p$CDC42EP4 <- CDC42EP4.out$V23
p$CGNL1 <- CGNL1.out$V23
p$CHN1 <- CHN1.out$V23
p$CHST15 <- CHST15.out$V23
p$CLCN3 <- CLCN3.out$V23
p$CLDN15 <- CLDN15.out$V23
p$COL12A1 <- COL12A1.out$V23
p$COL13A1 <- COL13A1.out$V23
p$COL6A3 <- COL6A3.out$V23
p$COLEC12 <- COLEC12.out$V23
p$CPE <- CPE.out$V23
p$CREB3L2 <- CREB3L2.out$V23
p$DDX60L <- DDX60L.out$V23
p$DLGAP1 <- DLGAP1.out$V23
p$DNAJC3 <- DNAJC3.out$V23
p$DST <- DST.out$V23
p$FAM114A1 <- FAM114A1.out$V23
p$FAM160A1 <- FAM160A1.out$V23
p$FAM174B <- FAM174B.out$V23
p$FARP1 <- FARP1.out$V23
p$FBLN5 <- FBLN5.out$V23
p$FBXL18 <- FBXL18.out$V23
p$FBXL3 <- FBXL3.out$V23
p$FBXL7 <- FBXL7.out$V23
p$FERMT2 <- FERMT2.out$V23
p$FLRT2 <- FLRT2.out$V23
p$FN1 <- FN1.out$V23
p$FNDC3B <- FNDC3B.out$V23
p$FREM1 <- FREM1.out$V23
p$FRY <- FRY.out$V23
p$GAP43 <- GAP43.out$V23
p$GIT1 <- GIT1.out$V23
p$GJA1 <- GJA1.out$V23
p$GLIPR2 <- GLIPR2.out$V23
p$GLIS3 <- GLIS3.out$V23
p$GMPR <- GMPR.out$V23
p$GPR137B <- GPR137B.out$V23
p$GPR176 <- GPR176.out$V23
p$GREM2 <- GREM2.out$V23
p$GXYLT2 <- GXYLT2.out$V23
p$HECW1 <- HECW1.out$V23
p$HECW2 <- HECW2.out$V23
p$HN1 <- HN1.out$V23
p$HPS3 <- HPS3.out$V23
p$INHBA <- INHBA.out$V23
p$IRF2 <- IRF2.out$V23
p$IRF7 <- IRF7.out$V23
p$KALRN <- KALRN.out$V23
p$KIAA0232 <- KIAA0232.out$V23
p$KIAA1211 <- KIAA1211.out$V23
p$KIAA1217 <- KIAA1217.out$V23
p$KIF1A <- KIF1A.out$V23
p$KREMEN1 <- KREMEN1.out$V23
p$KSR1 <- KSR1.out$V23
p$LDLRAD3 <- LDLRAD3.out$V23
p$LHFPL2 <- LHFPL2.out$V23
p$LIMA1 <- LIMA1.out$V23
p$LRP1 <- LRP1.out$V23
p$MME <- MME.out$V23
p$MMP2 <- MMP2.out$V23
p$MRC2 <- MRC2.out$V23
p$MREG <- MREG.out$V23
p$MRO <- MRO.out$V23
p$MXRA7 <- MXRA7.out$V23
p$NAGLU <- NAGLU.out$V23
p$NBL1 <- NBL1.out$V23
p$NCOA7 <- NCOA7.out$V23
p$NDEL1 <- NDEL1.out$V23
p$NDRG1 <- NDRG1.out$V23
p$NFE2L2 <- NFE2L2.out$V23
p$NR2F2 <- NR2F2.out$V23
p$NTN1 <- NTN1.out$V23
p$NXN <- NXN.out$V23
p$OPCML <- OPCML.out$V23
p$PCDH9 <- PCDH9.out$V23
p$PDGFRA <- PDGFRA.out$V23
p$PDZRN3 <- PDZRN3.out$V23
p$PHACTR1 <- PHACTR1.out$V23
p$PKHD1 <- PKHD1.out$V23
p$PPP1R37 <- PPP1R37.out$V23
p$PPP6R2 <- PPP6R2.out$V23
p$PRKCE <- PRKCE.out$V23
p$PROX1 <- PROX1.out$V23
p$PTPN13 <- PTPN13.out$V23
p$PTPRD <- PTPRD.out$V23
p$PTPRG <- PTPRG.out$V23
p$PTPRM <- PTPRM.out$V23
p$PXDC1 <- PXDC1.out$V23
p$PXDN <- PXDN.out$V23
p$QKI <- QKI.out$V23
p$RAB11FIP1 <- RAB11FIP1.out$V23
p$RALGDS <- RALGDS.out$V23
p$RAPGEF5 <- RAPGEF5.out$V23
p$RARB <- RARB.out$V23
p$RIT1 <- RIT1.out$V23
p$RNF165 <- RNF165.out$V23
p$RNF4 <- RNF4.out$V23
p$RNH1 <- RNH1.out$V23
p$ROBO1 <- ROBO1.out$V23
p$ROBO2 <- ROBO2.out$V23
p$RPS6KA2 <- RPS6KA2.out$V23
p$SCD5 <- SCD5.out$V23
p$SEL1L3 <- SEL1L3.out$V23
p$SEMA3C <- SEMA3C.out$V23
p$SEMA5A <- SEMA5A.out$V23
p$SEMA6A <- SEMA6A.out$V23
p$SESN2 <- SESN2.out$V23
p$SESN3 <- SESN3.out$V23
p$SETD7 <- SETD7.out$V23
p$SFRP1 <- SFRP1.out$V23
p$SGK1 <- SGK1.out$V23
p$SH3BP5 <- SH3BP5.out$V23
p$SH3PXD2A <- SH3PXD2A.out$V23
p$SHC4 <- SHC4.out$V23
p$SIRT7 <- SIRT7.out$V23
p$SLC12A7 <- SLC12A7.out$V23
p$SLC1A4 <- SLC1A4.out$V23
p$SLC35B1 <- SLC35B1.out$V23
p$SLC38A10 <- SLC38A10.out$V23
p$SLC7A5 <- SLC7A5.out$V23
p$SLC9A9 <- SLC9A9.out$V23
p$SPAG9 <- SPAG9.out$V23
p$SPRYD3 <- SPRYD3.out$V23
p$SSPN <- SSPN.out$V23
p$ST3GAL2 <- ST3GAL2.out$V23
p$ST6GALNAC3 <- ST6GALNAC3.out$V23
p$ST8SIA2 <- ST8SIA2.out$V23
p$STARD13 <- STARD13.out$V23
p$STOX2 <- STOX2.out$V23
p$SULF1 <- SULF1.out$V23
p$SULF2 <- SULF2.out$V23
p$SUN2 <- SUN2.out$V23
p$SUSD1 <- SUSD1.out$V23
p$SVIL <- SVIL.out$V23
p$TBC1D16 <- TBC1D16.out$V23
p$TBC1D24 <- TBC1D24.out$V23
p$TEX22 <- TEX22.out$V23
p$TGFB2 <- TGFB2.out$V23
p$TGFB3 <- TGFB3.out$V23
p$TGFBR2 <- TGFBR2.out$V23
p$THSD7A <- THSD7A.out$V23
p$TIAM2 <- TIAM2.out$V23
p$TIPARP <- TIPARP.out$V23
p$TLR3 <- TLR3.out$V23
p$TMCC1 <- TMCC1.out$V23
p$TMCC3 <- TMCC3.out$V23
p$TMEM127 <- TMEM127.out$V23
p$TMEM184B <- TMEM184B.out$V23
p$TMEM241 <- TMEM241.out$V23
p$TNKS <- TNKS.out$V23
p$TP53I11 <- TP53I11.out$V23
p$TRABD2A <- TRABD2A.out$V23
p$TRAK1 <- TRAK1.out$V23
p$TRAM2 <- TRAM2.out$V23
p$TRIM2 <- TRIM2.out$V23
p$TSKU <- TSKU.out$V23
p$TSPAN5 <- TSPAN5.out$V23
p$TTC29 <- TTC29.out$V23
p$TTLL7 <- TTLL7.out$V23
p$USP46 <- USP46.out$V23
p$VGLL4 <- VGLL4.out$V23
p$VPS4B <- VPS4B.out$V23
p$WARS <- WARS.out$V23
p$WDR1 <- WDR1.out$V23
p$XYLT2 <- XYLT2.out$V23
p$ZBTB20 <- ZBTB20.out$V23
p$ZBTB4 <- ZBTB4.out$V23
p$ZEB1 <- ZEB1.out$V23
p$ZNF70 <- ZNF70.out$V23
p$NFE2L2 <- NFE2L2.out$V23
p$NR2F2 <- NR2F2.out$V23
p$NTN1 <- NTN1.out$V23
p$NXN <- NXN.out$V23
p$OPCML <- OPCML.out$V23
p$PCDH9 <- PCDH9.out$V23
p$PDGFRA <- PDGFRA.out$V23
p$PDZRN3 <- PDZRN3.out$V23
p$PHACTR1 <- PHACTR1.out$V23
p$PKHD1 <- PKHD1.out$V23
p$PPP1R37 <- PPP1R37.out$V23
p$PPP6R2 <- PPP6R2.out$V23
p$PRKCE <- PRKCE.out$V23
p$PROX1 <- PROX1.out$V23
p$PTPN13 <- PTPN13.out$V23
p$PTPRD <- PTPRD.out$V23
p$PTPRG <- PTPRG.out$V23
p$PTPRM <- PTPRM.out$V23
p$PXDC1 <- PXDC1.out$V23
p$PXDN <- PXDN.out$V23
p$QKI <- QKI.out$V23
p$RAB11FIP1 <- RAB11FIP1.out$V23
p$RALGDS <- RALGDS.out$V23
p$RAPGEF5 <- RAPGEF5.out$V23
p$RARB <- RARB.out$V23
p$RIT1 <- RIT1.out$V23
p$RNF165 <- RNF165.out$V23
p$RNF4 <- RNF4.out$V23
p$RNH1 <- RNH1.out$V23
p$ROBO1 <- ROBO1.out$V23
p$ROBO2 <- ROBO2.out$V23
p$RPS6KA2 <- RPS6KA2.out$V23
p$SCD5 <- SCD5.out$V23
p$SEL1L3 <- SEL1L3.out$V23
p$SEMA3C <- SEMA3C.out$V23
p$SEMA5A <- SEMA5A.out$V23
p$SEMA6A <- SEMA6A.out$V23
p$SESN2 <- SESN2.out$V23
p$SESN3 <- SESN3.out$V23
p$SETD7 <- SETD7.out$V23
p$SFRP1 <- SFRP1.out$V23
p$SGK1 <- SGK1.out$V23
p$SH3BP5 <- SH3BP5.out$V23
p$SH3PXD2A <- SH3PXD2A.out$V23
p$SHC4 <- SHC4.out$V23
p$SIRT7 <- SIRT7.out$V23
p$SLC12A7 <- SLC12A7.out$V23
p$SLC1A4 <- SLC1A4.out$V23
p$SLC35B1 <- SLC35B1.out$V23
p$SLC38A10 <- SLC38A10.out$V23
p$SLC7A5 <- SLC7A5.out$V23
p$SLC9A9 <- SLC9A9.out$V23
p$SPAG9 <- SPAG9.out$V23
p$SPRYD3 <- SPRYD3.out$V23
p$SSPN <- SSPN.out$V23
p$ST3GAL2 <- ST3GAL2.out$V23
p$ST6GALNAC3 <- ST6GALNAC3.out$V23
p$ST8SIA2 <- ST8SIA2.out$V23
p$STARD13 <- STARD13.out$V23
p$STOX2 <- STOX2.out$V23
p$SULF1 <- SULF1.out$V23
p$SULF2 <- SULF2.out$V23
p$SUN2 <- SUN2.out$V23
p$SUSD1 <- SUSD1.out$V23
p$SVIL <- SVIL.out$V23
p$TBC1D16 <- TBC1D16.out$V23
p$TBC1D24 <- TBC1D24.out$V23
p$TEX22 <- TEX22.out$V23
p$TGFB2 <- TGFB2.out$V23
p$TGFB3 <- TGFB3.out$V23
p$TGFBR2 <- TGFBR2.out$V23
p$THSD7A <- THSD7A.out$V23
p$TIAM2 <- TIAM2.out$V23
p$TIPARP <- TIPARP.out$V23
p$TLR3 <- TLR3.out$V23
p$TMCC1 <- TMCC1.out$V23
p$TMCC3 <- TMCC3.out$V23
p$TMEM127 <- TMEM127.out$V23
p$TMEM184B <- TMEM184B.out$V23
p$TMEM241 <- TMEM241.out$V23
p$TNKS <- TNKS.out$V23
p$TP53I11 <- TP53I11.out$V23
p$TRABD2A <- TRABD2A.out$V23
p$TRAK1 <- TRAK1.out$V23
p$TRAM2 <- TRAM2.out$V23
p$TRIM2 <- TRIM2.out$V23
p$TSKU <- TSKU.out$V23
p$TSPAN5 <- TSPAN5.out$V23
p$TTC29 <- TTC29.out$V23
p$TTLL7 <- TTLL7.out$V23
p$USP46 <- USP46.out$V23
p$VGLL4 <- VGLL4.out$V23
p$VPS4B <- VPS4B.out$V23
p$WARS <- WARS.out$V23
p$WDR1 <- WDR1.out$V23
p$XYLT2 <- XYLT2.out$V23
p$ZBTB20 <- ZBTB20.out$V23
p$ZBTB4 <- ZBTB4.out$V23
p$ZEB1 <- ZEB1.out$V23
p$ZNF70 <- ZNF70.out$V23

#Plus import baz1b rsids
BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B.out", 
                  col_names = FALSE)

#'tidy' data structure
p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B INV DE genes.pdf")

ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("Inv") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Variant count") +
  theme(legend.position = "top")  +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")

dev.off()


#Alternative plot

rm(list = ls())



p <- NULL
p$dir <- alldir$X23
p$inv <- allinv$X23

p <- melt(p)
p <- as.data.frame(p)

ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  ggtitle(subtitle = B) +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count", title = "BAZ1B targets", color= "List") +
  scale_color_brewer(palette="Set1") +
  theme(legend.position = "top") +
  geom_vline(xintercept = HF_selection_BAZ1B_rsIDs_results$X23*29, colour = "black", alpha = 0.5)
