# OBRIGATORIO: 
    # no df spc: colunas: "species" e "Freq" 
    # no df tab: colunas: "species"
    # PRESTAR ATENÇÃO NOS NOMES DAS COLUNAS (ex : species, var1...)
# MANTER NOMES
retorna_new_tab_especies_mais_5 <- function(spc,tab){
  #dataFrame que sera retornado, com header da tab original
  ret <- tab[-0,]
  # para cada linha i do df spc
  for(i in 1:nrow(spc)){
    row_spc <- spc[i,]
    #verifica se a frequencia desta especie é maior q 4
    if(row_spc$Freq>4){
      # conta qnts vezes essa especie buscada foi encontrada 
      count <- 0
      # para cada linha j do df tab
      for(j in 1:nrow(tab)){
        row_tab <- tab[j,]
        #verifica se a especie buscada foi encontrada
        # compara o level de cada factor row (row_tab and row_spc)
        if(as.integer(row_spc$species)==as.integer(row_tab$species)){
          # add linha encontrada ao df de retorno (a ultima posicao)
          ret[nrow(ret)+1,] = row_tab
          # conta mais 1 (para o contador desta especie encontrada)
          count <- count + 1
          # verifica se o numero de vezes q essa especie buscada foi encontrada 
          # é igual a freq desta especie.
          if(count == row_spc$Freq){
            # pulamos para a prox especie a ser buscada (achou, parou)
            break;
          }
        }
      }
    }
  }
  return(ret)
}



setwd("/home/yuri/Documentos/IC Evolução/Ecorregiões/América do Sul/Biomas")
# para utilizar strings ao inves de Factors
#esp_count <- read.table("MT_species.csv", header = T, sep = ",", dec = ".",stringsAsFactors = F)
esp_count <- read.table("Amazon_species.csv", header = T, sep = ",", dec = ".")
comp <- read.table("Amazon_Data.csv", header = T, sep = ",", dec = ".")
new_tab <- retorna_new_tab_especies_mais_5(esp_count,comp)
#save table
write.table(new_tab, "amazon_spc_plus_5.csv", sep=",")

#contando especies
amz <- read.table("amazon_spc_plus_5.csv", sep = ",")
count_eco = data.frame(table(amz$species))
