#### Code for extracting the ecoregions of Dinerstein et al 2017 ####

setwd( "/Volumes/2º\ HD/Projeto\ PD/Análises\ Projeto_PD/Machine_learning/Extract_ecoregions/")

list.files()

## load packages we will need
library(dismo)
library(maptools)
library (sp)
library (rgdal)
library (raster)
library (maps)
library(dplyr)
library(scrubr)
library(speciesgeocodeR)
#devtools::install_github("ropensci/CoordinateCleaner")
library(CoordinateCleaner)


## load ecoregions shape file download available at https://ecoregions2017.appspot.com/
## these shapefiles must be in the same directory of the analysis 
ecoregions<-readOGR(dsn="Ecoregions",layer="Ecoregions2017")

setwd("/Volumes/2º\ HD/UNIFESP/Projetos/IC_Yuri/Limpeza_GBIF")

## Coordinates input
## File manipulation
dupp <- read.table("Forests_isabel.csv", header = T, sep = ",", dec = ".")
cols <- c(1:2,6)
dupp <-dupp[,-cols]

col_order<- c("decimallatitude", "decimallongitude", "species")
dupp <- dupp[, col_order]
dupp["X"]<-c("")


##identify ecoregions ("ECO_NAME") or biomes("BIOME_NAME")
sp.class <- SpGeoCod(dupp, ecoregions, areanames = "ECO_NAME", occ.thresh = 10)

##save ecoregions in the work directory
#summary statistics as text file
WriteOut(sp.class, type = "stats")


## add ecoregions information in the gbif table

table <- read.table("Forests_isabel.csv", header = T, sep = ",", dec = ".")
cols <- c(2,4:50)
table <-table[,-cols]


##select lines with the desired ecoregions

DataFrame <- read.table("sample_classification_to_polygon.txt", header = T, sep = "\t", dec = ",")

data <- cbind(table,DataFrame)
cols <- c(7:9)
data <-data[,-cols]

count_eco = as.data.frame(table(DataFrame$homepolygon))

count_eco

#save table
write.table(data, "Forests_ecoregions_isabel.csv", sep=",")



