 
temp = list.files(pattern="*")
for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i], header = FALSE))

p <- NULL
p$Amygdala <- Amygdala$V23*29
p$BA24 <- BA24$V23*29
p$Caudate <- Caudate$V23*29
p$Cerebellar_Hemisphere <- Cerebellar_Hemisphere$V23*29
p$erebellum <- erebellum$V23*29
p$Cortex <- Cortex$V23*29
p$Frontal_Cortex <- Frontal_Cortex$V23*29
p$Hippocampus <- Hippocampus$V23*29
p$Hypothalamus <- Hypothalamus$V23*29
p$Nucleus_accumbens_basal_ganglia <- Nucleus_accumbens_basal_ganglia$V23*29
p$Putamen_basal_ganglia <- Putamen_basal_ganglia$V23*29
p$Spinal_cord_cervical <- Spinal_cord_cervical$V23*29
p$Substantia_nigra <- Substantia_nigra$V23*29
p$Pituitary  <- Pituitary$V23*29

p <- melt(p)
p <- as.data.frame(p)
