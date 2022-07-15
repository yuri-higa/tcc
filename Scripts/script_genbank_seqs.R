install.packages("ape")
install.packages("seqinr")
library(ape)
library(seqinr)

setwd("/home/yuri/Documentos/IC Evolução/Ecorregiões/América do Sul/Biomas")
list.files()

data1 <- read.table(file = "MT_Data.csv", header=T, sep = ",", dec = ".")

linhas <- nrow(data1)

data <- data.frame()

for (i in 1:linhas){
  y <- data1[i,4]
  x <- read.GenBank(y)
  write.dna(x, file = file.path(paste0('d.fasta')), format = "fasta", append = FALSE, nbcol = 6, colsep = " ", colw = 10)
  xx <- read.fasta(file = "d.fasta", seqtype = "DNA", as.string=T, forceDNAtolower = F)
  z <- paste(attr(x, "description"), names(x)) 
  data[i,1] <- attr(x, "species")
  data[i,2] <- attr(x, "description")
  write.dna(xx, file = file.path(paste0(y,'.fasta')), format = "fasta", append = FALSE, nbcol = 6, colsep = " ", colw = 10)
}

write.table(data, file = "dados_seq.txt", quote = TRUE, sep = "\t", eol = "\n", na = "NA", dec = ",", row.names = TRUE, qmethod = c("escape", "double"))


