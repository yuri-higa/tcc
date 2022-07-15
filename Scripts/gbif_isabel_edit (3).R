#carregar pacotes que serão usados
library(dismo)
library(maptools)
library (sp)
library (rgdal)
library (raster)
library (maps)
library(dplyr)
library(rgbif)
library(scrubr)
library(speciesgeocodeR)
library(CoordinateCleaner)
library(geobr)
library(ggplot2)
library(sf)
library(dplyr)
library(spocc)

# Plotando mapa para inserir os pontod do gbif
data(wrld_simpl)
plot(wrld_simpl, xlim=c(-90,-10), ylim=c(-50, 15), axes=TRUE, col='light yellow')


#Informar a pasta de trabalho
setwd("/Volumes/2º\ HD/UNIFESP/Projetos/IC_Yuri/")

#Onde estou?
getwd()

#Quais arquivos tem na pasta
list.files()


# Retiradas de coordenadas impossiveis (no mar, por exemplo), incompletas (alguma com zero), ou nao provaveis

data_cleaned <- read.delim(file = "./gbif_data_isabel_021020.csv", header = TRUE, sep = ";", dec = ".")

GENUSCOPY <- dframe(data_cleaned) %>% coord_impossible()
GENUSCOPY <- dframe(GENUSCOPY) %>% coord_incomplete()
GENUSCOPY <- dframe(GENUSCOPY) %>% coord_unlikely()

# Colocando dados em ordem alfabetica por especie
GENUSCOPY <- GENUSCOPY[order(GENUSCOPY$species, decreasing=(FALSE)), ]

# Checagem dos dados filtrados
points(GENUSCOPY$decimalLongitude, GENUSCOPY$decimalLatitude, col='red', pch=20, cex=0.9)

# Salvando tabelas
write.table(GENUSCOPY, file = "nome_do_arquivo.csv",
            quote = TRUE, sep = ";", eol = "\n",
            na = "NA", dec = ".", row.names = TRUE,
            qmethod = c("escape", "double"))

# Tabela com os nomes corretos foram carregados

GENUS_FILTER <- read.delim(file = "./teste", header = TRUE, sep = ";", dec = ".")

plot(wrld_simpl, xlim=c(-90,-10), ylim=c(-50, 15), axes=TRUE, col='light yellow')

points(GENUS_FILTER$Longitude, GENUS_FILTER$Latitude, col='red', pch=20, cex=0.9)

# Limpeza automatica utilizando coordinatecleaner - limpeza de pontos de museu e capitais

flags <- clean_coordinates(GENUS_FILTER, lon = "decimalLongitude", lat = "decimalLatitude", countries = "locality", species = "species")

GENUS_FILTER_FIL2 <- GENUS_FILTER[flags$.summary,]

# Salvar tabela com todos os dados filtrados
write.table(GENUS_FILTER_FIL2, file = "./nome_da_tabela",
            quote = TRUE, sep = ";", eol = "\n",
            na = "NA", dec = ".", row.names = TRUE,
            qmethod = c("escape", "double"))

# Salvar tabela apenas com colunas importantes
cols <- c(2,11:50)
GENUS_FILTER_FIL3 <-GENUS_FILTER_FIL2[,-cols]

write.table(GENUS_FILTER_FIL3, file = "./nome_da_tabela2",
            quote = TRUE, sep = ";", eol = "\n",
            na = "NA", dec = ".", row.names = TRUE,
            qmethod = c("escape", "double"))


# Contar número de ocorrências das espécies e familias
count_species = as.data.frame(table(GENUS_FILTER_FIL3$species))
count_family = as.data.frame(table(GENUS_FILTER_FIL3$family))


