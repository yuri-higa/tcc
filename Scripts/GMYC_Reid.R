setwd("/home/yuri/Documentos/IC Evolução/Rubiaceae/logcombiner")
list.files()
library(bGMYC)
library(ape)
library(dplyr)

trees <- read.nexus(file="plicatiformis_combiner.trees")
trees <- sample(trees,size=100)

result.single <- bgmyc.singlephy(trees[[1]], mcmc=50000, burnin=40000, thinning=100, t1=1, t2=7, start=c(1,1,4))
plot(result.single)

result.multi <- bgmyc.multiphylo(trees, mcmc=50000, burnin=40000, thinning=100, t1=1, t2=7, start=c(1,1,4))
plot(result.multi)

result.spec <- bgmyc.spec(result.multi)

result.probmat <- spec.probmat(result.multi)
plot(result.probmat, trees[[1]])

bgmycrates <- checkrates(result.multi)
plot(bgmycrates)

clusters<-bgmyc.point(result.probmat,0.05)

write.table(result.probmat, file = "result.probmat")
capture.output(clusters, file = "clusters_plicatiformis.txt")

