#install_packages
#if (!requireNamespace("BiocManager", quietly=TRUE))
install.packages("BiocManager")
BiocManager::install("msa")
install.packages("adegenet", dep=TRUE)
install.packages("adegenet")


library(msa)
library(ape)
library(adegenet)

setwd("/home/yuri/Documentos/IC Evolução/Ecorregiões/América do Sul/Biomas/Amazônia/test/Jacaranda copaia/HA")
list.files()

mySeqs <- readAAStringSet("out2.fasta")

myAlignment <- msa(mySeqs, "ClustalW")
print(myAlignment, show="complete")

alignment2Fasta <- function(alignment, filename) {
  sink(filename)
  
  n <- length(rownames(alignment))
  for(i in seq(1, n)) {
    cat(paste0('>', rownames(alignment)[i]))
    cat('\n')
    the.sequence <- toString(unmasked(alignment)[[i]])
    cat(the.sequence)
    cat('\n')  
  }
  
  sink(NULL)
}

alignment2Fasta(myAlignment, 'out.fasta')


seg <- fasta2DNAbin("./out.fasta")

y <- seg.sites(seg)
y
length(y)

