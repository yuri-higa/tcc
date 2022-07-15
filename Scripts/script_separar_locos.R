setwd("/home/yuri/Documentos/IC Evolução/Ecorregiões/América do Sul/Biomas/Amazônia/Amazon 5spc GenBank")
list.files()

dados <- read.table("dados_seq.txt", header = T, sep = "\t", dec = ".")

seq_HA <-dados[grep("psbA-trnH", dados$V2),]

write.table(seq_HA,"seqs_psbA-trnH.txt")

