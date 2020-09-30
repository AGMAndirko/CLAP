library(tidyverse)
library(reshape2)

temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_3/resultsdir/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_3/resultsdir/",temp[i]), header = FALSE))

p <- NULL

p$ABCC4 <- ABCC4.out$V23
p$ABCG1 <- ABCG1.out$V23
p$ABLIM2 <- ABLIM2.out$V23
p$AKR1B1 <- AKR1B1.out$V23
p$B3GAT1 <- B3GAT1.out$V23
p$C9orf129 <- C9orf129.out$V23
p$CDH4 <- CDH4.out$V23
p$CDK18 <- CDK18.out$V23
p$DNAJB6 <- DNAJB6.out$V23
p$DPF3 <- DPF3.out$V23
p$DTYMK <- DTYMK.out$V23
p$ELFN1 <- ELFN1.out$V23
p$ETS2 <- ETS2.out$V23
p$FADS2 <- FADS2.out$V23
p$FEM1A <- FEM1A.out$V23
p$FLT4 <- FLT4.out$V23
p$HMGA2 <- HMGA2.out$V23
p$IL21R <- IL21R.out$V23
p$IL2RB <- IL2RB.out$V23
p$KCNK9 <- KCNK9.out$V23
p$LARP4B <- LARP4B.out$V23
p$LMO1 <- LMO1.out$V23
p$MYO7A <- MYO7A.out$V23
p$NCAPH <- NCAPH.out$V23
p$OBSL1 <- OBSL1.out$V23
p$OLFM1 <- OLFM1.out$V23
p$PAX5 <- PAX5.out$V23
p$PLA2G3 <- PLA2G3.out$V23
p$PLXNA4 <- PLXNA4.out$V23
p$PRKCQ <- PRKCQ.out$V23
p$RAB4A <- RAB4A.out$V23
p$RPRD1B <- RPRD1B.out$V23
p$SALL4 <- SALL4.out$V23
p$SH3TC1 <- SH3TC1.out$V23
p$SLC37A4 <- SLC37A4.out$V23
p$SMYD3 <- SMYD3.out$V23
p$SRC <- SRC.out$V23
p$SSB <- SSB.out$V23
p$SYT13 <- SYT13.out$V23
p$TAF1B <- TAF1B.out$V23
p$TNR <- TNR.out$V23
p$UBE2V2 <- UBE2V2.out$V23
p$UBXN10 <- UBXN10.out$V23
p$UQCRFS1 <- UQCRFS1.out$V23
p$USP13 <- USP13.out$V23
p$VAPA <- VAPA.out$V23
p$XYLT1 <- XYLT1.out$V23

BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_3/BAZ1B.out", 
                  col_names = FALSE)

p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_3_dir.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B DIR", subtitle = "DE bound by enhancer / 2 histones") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Gene") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()

rm(list = ls())
temp <- list.files(path = "Timeline_project/1_data/BAZ1B/BAZ1B_3/resultsinv/", pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(paste0("Timeline_project/1_data/BAZ1B/BAZ1B_3/resultsinv/",temp[i]), header = FALSE))

p <- NULL

p$AACS <- AACS.out$V23
p$ABTB2 <- ABTB2.out$V23
p$ACSS3 <- ACSS3.out$V23
p$ADAM28 <- ADAM28.out$V23
p$ADAMTS16 <- ADAMTS16.out$V23
p$ADM2 <- ADM2.out$V23
p$ADRA2A <- ADRA2A.out$V23
p$AGTR1 <- AGTR1.out$V23
p$AKNA <- AKNA.out$V23
p$ANGPT1 <- ANGPT1.out$V23
p$ANK2 <- ANK2.out$V23
p$ANKRD44 <- ANKRD44.out$V23
p$APBA1 <- APBA1.out$V23
p$ARAP2 <- ARAP2.out$V23
p$ARHGAP18 <- ARHGAP18.out$V23
p$ARHGAP20 <- ARHGAP20.out$V23
p$ARHGAP42 <- ARHGAP42.out$V23
p$ARID5B <- ARID5B.out$V23
p$BASP1 <- BASP1.out$V23
p$BBX <- BBX.out$V23
p$BCL2L11 <- BCL2L11.out$V23
p$BNC2 <- BNC2.out$V23
p$CBLB <- CBLB.out$V23
p$CBX4 <- CBX4.out$V23
p$CD36 <- CD36.out$V23
p$CDH2 <- CDH2.out$V23
p$CGNL1 <- CGNL1.out$V23
p$CHN1 <- CHN1.out$V23
p$CHN2 <- CHN2.out$V23
p$CHST15 <- CHST15.out$V23
p$CLDN11 <- CLDN11.out$V23
p$COL12A1 <- COL12A1.out$V23
p$COL14A1 <- COL14A1.out$V23
p$COL1A1 <- COL1A1.out$V23
p$COL6A3 <- COL6A3.out$V23
p$COLEC12 <- COLEC12.out$V23
p$COLGALT2 <- COLGALT2.out$V23
p$CPE <- CPE.out$V23
p$DAB2 <- DAB2.out$V23
p$DLGAP1 <- DLGAP1.out$V23
p$DOCK6 <- DOCK6.out$V23
p$DST <- DST.out$V23
p$EDN3 <- EDN3.out$V23
p$ERBB4 <- ERBB4.out$V23
p$FAM174B <- FAM174B.out$V23
p$FAM198B <- FAM198B.out$V23
p$FARP1 <- FARP1.out$V23
p$FAT3 <- FAT3.out$V23
p$FBXL4 <- FBXL4.out$V23
p$FBXL7 <- FBXL7.out$V23
p$FLRT2 <- FLRT2.out$V23
p$FN1 <- FN1.out$V23
p$FOXF2 <- FOXF2.out$V23
p$FREM1 <- FREM1.out$V23
p$FRMD4B <- FRMD4B.out$V23
p$GAP43 <- GAP43.out$V23
p$GJA1 <- GJA1.out$V23
p$GLIPR2 <- GLIPR2.out$V23
p$GLIS3 <- GLIS3.out$V23
p$GMPR <- GMPR.out$V23
p$GNAI1 <- GNAI1.out$V23
p$GRID2 <- GRID2.out$V23
p$GUCY1A2 <- GUCY1A2.out$V23
p$GULP1 <- GULP1.out$V23
p$HECW2 <- HECW2.out$V23
p$HIVEP2 <- HIVEP2.out$V23
p$IGFBP7 <- IGFBP7.out$V23
p$IGSF11 <- IGSF11.out$V23
p$IL1R1 <- IL1R1.out$V23
p$INHBA <- INHBA.out$V23
p$IRF2 <- IRF2.out$V23
p$ITPR1 <- ITPR1.out$V23
p$KALRN <- KALRN.out$V23
p$KIAA1217 <- KIAA1217.out$V23
p$KREMEN1 <- KREMEN1.out$V23
p$KSR1 <- KSR1.out$V23
p$LAMA2 <- LAMA2.out$V23
p$LAMA4 <- LAMA4.out$V23
p$LDLRAD3 <- LDLRAD3.out$V23
p$LHFPL2 <- LHFPL2.out$V23
p$MID1 <- MID1.out$V23
p$MME <- MME.out$V23
p$MRC2 <- MRC2.out$V23
p$MREG <- MREG.out$V23
p$MYO16 <- MYO16.out$V23
p$NAGLU <- NAGLU.out$V23
p$NCAM2 <- NCAM2.out$V23
p$NDEL1 <- NDEL1.out$V23
p$NDRG1 <- NDRG1.out$V23
p$NEO1 <- NEO1.out$V23
p$NFIB <- NFIB.out$V23
p$NR2F2 <- NR2F2.out$V23
p$NR3C1 <- NR3C1.out$V23
p$NT5E <- NT5E.out$V23
p$NXN <- NXN.out$V23
p$OPCML <- OPCML.out$V23
p$PAPPA <- PAPPA.out$V23
p$PCDH9 <- PCDH9.out$V23
p$PDE7B <- PDE7B.out$V23
p$PDZRN3 <- PDZRN3.out$V23
p$PELI2 <- PELI2.out$V23
p$PHACTR1 <- PHACTR1.out$V23
p$PIK3C3 <- PIK3C3.out$V23
p$PKHD1 <- PKHD1.out$V23
p$PLD1 <- PLD1.out$V23
p$PLXDC2 <- PLXDC2.out$V23
p$PRKCE <- PRKCE.out$V23
p$PTPRD <- PTPRD.out$V23
p$PTPRG <- PTPRG.out$V23
p$PTPRM <- PTPRM.out$V23
p$PXDC1 <- PXDC1.out$V23
p$PXDN <- PXDN.out$V23
p$QKI <- QKI.out$V23
p$RAB11FIP1 <- RAB11FIP1.out$V23
p$RAPGEF5 <- RAPGEF5.out$V23
p$RARB <- RARB.out$V23
p$RBMS3 <- RBMS3.out$V23
p$RHOBTB3 <- RHOBTB3.out$V23
p$ROBO1 <- ROBO1.out$V23
p$ROBO2 <- ROBO2.out$V23
p$RPS6KA2 <- RPS6KA2.out$V23
p$RPS6KC1 <- RPS6KC1.out$V23
p$RSU1 <- RSU1.out$V23
p$SAMD5 <- SAMD5.out$V23
p$SAMD9L <- SAMD9L.out$V23
p$SCD5 <- SCD5.out$V23
p$SCN5A <- SCN5A.out$V23
p$SEMA5A <- SEMA5A.out$V23
p$SEMA6A <- SEMA6A.out$V23
p$SESN3 <- SESN3.out$V23
p$SFRP1 <- SFRP1.out$V23
p$SGK1 <- SGK1.out$V23
p$SLC1A4 <- SLC1A4.out$V23
p$SLC40A1 <- SLC40A1.out$V23
p$SLC9A9 <- SLC9A9.out$V23
p$SNCAIP <- SNCAIP.out$V23
p$SND1 <- SND1.out$V23
p$SNTB1 <- SNTB1.out$V23
p$SNTG1 <- SNTG1.out$V23
p$SRGAP1 <- SRGAP1.out$V23
p$ST6GALNAC3 <- ST6GALNAC3.out$V23
p$ST8SIA2 <- ST8SIA2.out$V23
p$STARD13 <- STARD13.out$V23
p$STOX2 <- STOX2.out$V23
p$SULF1 <- SULF1.out$V23
p$SULF2 <- SULF2.out$V23
p$SVIL <- SVIL.out$V23
p$SYNPO2 <- SYNPO2.out$V23
p$TBC1D16 <- TBC1D16.out$V23
p$TGFB2 <- TGFB2.out$V23
p$TGFB3 <- TGFB3.out$V23
p$TGFBR2 <- TGFBR2.out$V23
p$THSD7A <- THSD7A.out$V23
p$TIAM2 <- TIAM2.out$V23
p$TMEM241 <- TMEM241.out$V23
p$TRABD2A <- TRABD2A.out$V23
p$TRAK1 <- TRAK1.out$V23
p$TRPM3 <- TRPM3.out$V23
p$TSKU <- TSKU.out$V23
p$TSPAN5 <- TSPAN5.out$V23
p$TTC29 <- TTC29.out$V23
p$TTLL7 <- TTLL7.out$V23
p$USP46 <- USP46.out$V23
p$VCAN <- VCAN.out$V23
p$VGLL4 <- VGLL4.out$V23
p$WDR1 <- WDR1.out$V23
p$XYLT2 <- XYLT2.out$V23
p$ZBTB20 <- ZBTB20.out$V23

BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_3/BAZ1B.out", 
                  col_names = FALSE)

p <- melt(p)
p <- as.data.frame(p)

pdf("BAZ1B_3_inv.pdf")
ggplot(p, aes(value*29, L1)) +
  theme_minimal() +
  ggtitle("BAZ1B INV", subtitle = "DE bound by enhancer / 2 histones") +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_point(size = 3, alpha = 0.1) +
  labs(x = "Years", y = "Gene") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "red")
dev.off()

rm(list = ls())

degsDir <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_3/degsDir.atl2HPTM.genes.txt.out", 
                                       col_names = FALSE)
degsInv <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_3/degsInv.atl2HPTM.genes.txt.out", 
                                       col_names = FALSE)

p <- NULL
p$Dir <- degsDir$X23
p$Inv <- degsInv$X23
p <- melt(p)

BAZ1B <- read_csv("Timeline_project/1_data/BAZ1B/BAZ1B_3/BAZ1B.out", 
                  col_names = FALSE)

pdf("BAZ1B_3_alt.pdf")
ggplot(p, aes(value*29, group = L1, colour = L1)) +
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE), breaks = seq(0,6218702, by = 250000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_density(stat = "bin", bins = 50) +
  labs(x = "Years", y = "Variant count", color= "List") +
  scale_color_brewer(palette="Paired") +
  theme(legend.position = "top") +
  geom_vline(xintercept = BAZ1B$X23*29, colour = "black", alpha = 0.5)
dev.off()