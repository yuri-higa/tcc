#### Code for extracting the ecoregions of Dinerstein et al 2017 ####

setwd( "/home/yuri/Documentos/IC Evolução/Ecorregiões")

list.files()

## load packages we will need
install.packages("pacote")
library(dismo)
library(maptools)
library (sp)
library (rgdal)
library (raster)
library (maps)
library(dplyr)
library(scrubr)
library(speciesgeocodeR)
library(CoordinateCleaner)


## load ecoregions shape file download available at https://ecoregions2017.appspot.com/
## these shapefiles must be in the same directory of the analysis 
ecoregions<-readOGR(dsn="Ecoregions",layer="Ecoregions2017")

setwd("/home/yuri/Documentos/IC Evolução/Ecorregiões/América do Sul/Biomas")

## Coordinates input
## File manipulation
dupp <- read.table("Forests.csv", header = T, sep = ",", dec = ".")
cols <- c(1,2,6,7)
dupp <-dupp[,-cols]

col_order<- c("decimalLatitude", "decimalLongitude", "species")
dupp <- dupp[, col_order]
dupp["X"]<-c("")

###Tirar variaveis "NA"(missing values)

#Descrição da tabela
glimpse(dupp)

#Quantas variaveis diferentes tem
dupp %>% distinct(identifier)

#Para cada item, testa se "decimalLatitude" não é "NA"
!is.na(dupp$decimalLatitude)

#Contando variaveis "NA"
dupp %>% summarise(count = sum(is.na(decimalLatitude)))

#apagando as linhas com "NA"
row_to_keep = c(!is.na(dupp$decimalLatitude))
dupp = dupp[row_to_keep,]
write.table(dupp, "Forests2.csv", sep = ",")

##identify ecoregions ("ECO_NAME") or biomes("BIOME_NAME")
sp.class <- SpGeoCod(dupp, ecoregions, areanames = "ECO_NAME", occ.thresh = 10)

##save ecoregions in the work directory
#summary statistics as text file
WriteOut(sp.class, type = "stats")


## add ecoregions information in the gbif table

table <- read.table("gbif_amazonia_filter", header = T, sep = ";", dec = ".")
cols <- c(2,4:50)
table <-table[,-cols]


##select lines with the desired ecoregions

DataFrame <- read.table("sample_classification_to_polygon.txt", header = T, sep = "\t", dec = ",")

data <- cbind(table,DataFrame)

count_eco = as.data.frame(table(data$homepolygon))

#select only the biome "Tropical & Subtropical Moist Broadleaf Forest"
AM_AF <- data[data$homepolygon=='Tropical & Subtropical Moist Broadleaf Forests',]

#save table
write.table(AM_AF, "Forests.csv", sep=",")



