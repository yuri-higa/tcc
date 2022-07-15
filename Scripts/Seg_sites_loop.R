#install_packages
#if (!requireNamespace("BiocManager", quietly=TRUE))
#  install.packages("BiocManager")
#BiocManager::install("msa")

library(msa)
library(ape)
library(adegenet)

setwd("/home/yuri/Documentos/IC Evolução/Ecorregiões/América do Sul/Biomas/Amazônia/test")
list.files()

dir1 <- list.dirs(full.names= T)

dir2 <- list.files(path=dir1, pattern ="*fasta", full.names= T, include.dirs = T)

segregate <- data.frame()

for (z in 1:length(dir2)){
    mySeqs <- readAAStringSet(dir2[z])

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
      
      alignment2Fasta(myAlignment, file.path(paste0(dir2[z],'_out.fasta')))
      
      
      seg <- fasta2DNAbin(file.path(paste0('./',dir2[z],'_out.fasta')))
      
      y <- seg.sites(seg)
      x <- length(y)
      
      segregate[z,1] <- (dir2[z])
      segregate[z,2] <- (x)
    }

    write.table(segregate, file = "Segregate_sites.txt",
            quote = TRUE, sep = "\t", eol = "\n",
            na = "NA", dec = ".", row.names = TRUE,
            qmethod = c("escape", "double"))
    