library(PipeMaster)

#importar simulações (con, est, exp)
setwd("/home/yuri/Documentos/IC Evolução/Rubiaceae/ABC_result (dados unidos)/P.coriacea")
con <- read.table("coriacea_con_overallstats_mean.txt", header = T)
est <- read.table("coriacea_est_overallstats_mean.txt", header = T)
exp <- read.table("coriacea_exp_overallstats_mean.txt", header = T)

#Criando estatísticas sumárias para os dados observados
setwd("dir.dados.concatenados")
dir()
obs <- observed.sumstat (exp,path.to.fasta="./", overall.SS = T, perpop.SS = T, get.moments = T)
#criar para os 3 modelos, acima temos para o modelo de expansão

#importar dados observados (obs)
setwd("/home/yuri/Documentos/IC Evolução/Rubiaceae/ABC_result (dados unidos)/P.coriacea/l1")
obs <- read.table("obs_l1_coriacea.txt", header = T)

#unindo as simulações
sim <- rbind(con, est, exp)

#separando por modelos (con, est, exp)
models <- c(rep("con", nrow(con)),
            rep("est", nrow(est)),
            rep("exp", nrow(exp)))


#aplicando o método de rejeição
REJ <- postpr(obs, models, sim, tol=0.001, method="rejection")
REJ1 <- summary(REJ)

#aplicando método de validação cruzada

CV <- cv4postpr(sumstat = sim, index = models, method = "rejection", tol=0.001, nval = 100)

summary(CV)
plot(CV)
