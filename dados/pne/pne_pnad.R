## pne_pnad.R - Produz os dados de monitoramento do PNE usando Pnad Contínua
## Escrito por: George Gomes (Fortaleza - Ceará)
## E-mail: georgegomesf@gmail.com
# Impede conversão de número em notação científica ####
options(scipen=999)

# Carrega bibliotecas utilizadas ####
library(data.table)
library(plyr)
library(lubridate)
library(reldist)

# Declara função para cálculo de idade
calcIdade <- function(nascimento, referencia = Sys.Date()) {
  periodo <- as.period(interval(nascimento, referencia),unit = "year")
  periodo$year
}

# Carrega dados ####
load("../pnad/PNADC_022016_educacao_20180518.RData")
load("../pnad/PNADC_022017_educacao.RData")

# Substituição do dataframe carregado para um a ser usado no tratamento e produção de dados ####
pnad <- rbind(
  pnad2016[c("ANO","UF","RM_RIDE","CAPITAL","V1022","V1028","V2008","V20081","V20082","V2009","V2010","V3001","V3002","V3003A","V3004","V3006","V3006A","V3009A","V3010","V3013","V3013A","V3013B","VD3004","VD3005","VDI5002")],
  pnad2017[c("ANO","UF","RM_RIDE","CAPITAL","V1022","V1028","V2008","V20081","V20082","V2009","V2010","V3001","V3002","V3003A","V3004","V3006","V3006A","V3009A","V3010","V3013","V3013A","V3013B","VD3004","VD3005","VDI5002")]
  )

# Cria variável de data de nascimento válida para o ajuste
pnad$idade_valida <- ifelse(pnad$V20081!=99,1,0)

# Cria a variável "idade_cne" com a data de referência de 31 de março em cada ano, apenas para os casos de data de nascimento válida para o ajuste
pnad[pnad$idade_valida==1,"idade_cne"] <- calcIdade(
    paste(pnad[pnad$idade_valida==1,]$V20082, sprintf("%02d",pnad[pnad$idade_valida==1,]$V20081), sprintf("%02d",pnad[pnad$idade_valida==1,]$V2008), sep="-"),
    paste0(pnad[pnad$idade_valida==1,]$ANO,"-03-31")
  )

# Define idade presumida para os casos data de nascimento inválida para o ajuste
pnad$idade_cne <- ifelse(is.na(pnad$idade_cne),pnad$V2009,pnad$idade_cne)

# Conversão da variável de peso da pessoa em tipo numérico ####
pnad$V1028 <- as.numeric(as.character(pnad$V1028))

# Criação de variável para o código da grande região ####
pnad$id_regiao <- substring(pnad$UF,1,1)

# Define variável para a totalização do Brasil ####
pnad$total <- "Brasil"

# Define códigos e descrição das categorias dos principais grupos de idade utilizados
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(0:3),'De 0 a 3',NA)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(4:5),'De 4 a 5',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(6:10),'De 6 a 10',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(11:14),'De 11 a 14',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(15:17),'De 15 a 17',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(18:24),'De 18 a 24',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(25:29),'De 25 a 29',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(30:39),'De 30 a 39',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 %in% c(40:59),'De 40 a 59',pnad$ds_grupo_idade)
pnad$ds_grupo_idade <- ifelse(pnad$V2009 >= 60,'60 ou mais',pnad$ds_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(0:3),1,NA)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(4:5),2,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(6:10),3,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(11:14),4,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(15:17),5,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(18:24),6,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(25:29),7,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(30:39),8,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 %in% c(40:59),9,pnad$cd_grupo_idade)
pnad$cd_grupo_idade <- ifelse(pnad$V2009 >= 60,10,pnad$cd_grupo_idade)

# Produção de dados e indicadores de acordo com as principais categorias ####

# 1. Taxa de atendimento escolar de pessoas de 4 a 5 anos (%) ####

pnad_esc <- subset(pnad,idade_cne %in% c(4:5))
pnad_esc$sg_parte <- ifelse(pnad_esc$V3002==1,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=1,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T))
)

# # 0. Taxa de atendimento escolar de pessoas de 4 a 5 anos (%) ####
# 
# pnad_esc <- subset(pnad,idade_cne %in% c(4:17))
# pnad_esc$sg_parte <- ifelse(pnad_esc$V3002==1 | pnad_esc$VD3004>=5,"nr_numerador","nr_parte")
# pne_ind <- rbind.fill(
#   data.frame(cd_indicador=0,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
#   data.frame(cd_indicador=0,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
#   data.frame(cd_indicador=0,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
#   data.frame(cd_indicador=0,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
#   data.frame(cd_indicador=0,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T))
# )

# 2. Taxa de atendimento escolar de pessoas de 0 a 3 anos (%) ####

pnad_esc <- subset(pnad,idade_cne %in% c(0:3))
pnad_esc$sg_parte <- ifelse(pnad_esc$V3002==1,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=2,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 3. Taxa de escolarização líquida ajustada de pessoas de 6 a 14 anos (%) ####

pnad_esc <- subset(pnad,idade_cne %in% c(6:14))
pnad_esc$sg_parte <- ifelse(pnad_esc$V3003A>=4 | pnad_esc$VD3004>=3,"nr_numerador","nr_parte")
pnad_esc[is.na(pnad_esc$sg_parte),]$sg_parte <- "nr_parte"
pne_ind <- rbind.fill(
  data.frame(cd_indicador=3,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 4. Pessoas de 16 anos com pelo menos o ensino fundamental concluído (%) ####

pnad_esc <- subset(pnad,idade_cne==16)
pnad_esc$sg_parte <- ifelse(pnad_esc$VD3004>=3,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=4,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 5. Taxa de atendimento escolar de pessoas de 15 a 17 anos (%) ####

pnad_esc <- subset(pnad,idade_cne %in% c(15:17))
pnad_esc$sg_parte <- ifelse(pnad_esc$V3002==1 | pnad_esc$VD3004>=5,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=5,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 6. Taxa de escolarização líquida ajustada de pessoas de 15 a 17 (%) ####

pnad_esc <- subset(pnad,idade_cne %in% c(15:17))
pnad_esc$sg_parte <- ifelse(pnad_esc$V3003A>=6 | pnad_esc$VD3004>=5,"nr_numerador","nr_parte")
pnad_esc[is.na(pnad_esc$sg_parte),]$sg_parte <- "nr_parte"
pne_ind <- rbind.fill(
  data.frame(cd_indicador=6,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=6,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=6,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=6,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=6,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 7. Pessoas de 19 anos com pelo menos o ensino médio concluído (%) ####

pnad_esc <- subset(pnad,idade_cne==19)
pnad_esc$sg_parte <- ifelse(pnad_esc$VD3004>=5,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=7,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 12. Percentual da População de 18 a 29 anos com menos de 12 anos de escolaridade ####

pnad_esc <- subset(pnad,V2009 %in% c(18:29))
pnad_esc$sg_parte <- ifelse(pnad_esc$VD3005<12,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=12,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=12,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=12,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=12,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=12,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 13. Percentual da População de 18 a 29 anos residente no campo com menos de 12 anos de escolaridade ####

pnad_esc <- subset(pnad,V2009 %in% c(18:29) & V1022==2)
pnad_esc$sg_parte <- ifelse(pnad_esc$VD3005<12,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=13,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=13,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=13,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=13,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=13,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 14. Percentual da População de 18 a 29 anos entre os 25% mais pobres com menos de 12 anos de escolaridade ####

pnad_esc <- subset(pnad,V2009 %in% c(18:29))
q_renda <- wtd.quantile(pnad_esc$VDI5002,q=0.25,na.rm=T,weight = pnad_esc$V1028)
pnad_esc <- subset(pnad_esc,as.numeric(pnad_esc$VDI5002)<=q_renda)
pnad_esc$sg_parte <- ifelse(pnad_esc$VD3005<12,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=14,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=14,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=14,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=14,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=14,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 15. Percentual da População negra entre 18 e 29 anos com menos de 12 anos de escolaridade ####

pnad_esc <- subset(pnad,V2009 %in% c(18:29) & V2010 %in% c(2,4))
pnad_esc$sg_parte <- ifelse(pnad_esc$VD3005<12,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=15,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=15,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=15,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=15,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=15,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 16. Taxa de alfabetização da população de 15 anos ou mais de idade (%) ####

pnad_esc <- subset(pnad,V2009 >= 15)
pnad_esc$sg_parte <- ifelse(pnad_esc$V3001==1,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=16,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=16,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=16,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=16,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=16,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

# 17. Taxa de analfabetismo funcional de pessoas de 15 anos ou mais de idade (%) ####

pnad_esc <- subset(pnad,V2009 >= 15)
pnad_esc$sg_parte <- ifelse(pnad_esc$V3001==2 | as.numeric(pnad_esc$VD3005)<4,"nr_numerador","nr_parte")
pne_ind <- rbind.fill(
  data.frame(cd_indicador=17,dcast(pnad_esc,ANO+CAPITAL~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=17,dcast(pnad_esc,ANO+RM_RIDE~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=17,dcast(pnad_esc,ANO+UF~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=17,dcast(pnad_esc,ANO+id_regiao~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=17,dcast(pnad_esc,ANO+total~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pne_ind
)

pne_ind$nr_denominador <- pne_ind$nr_numerador+pne_ind$nr_parte
pne_ind$vl_indicador <- pne_ind$nr_numerador/pne_ind$nr_denominador*100

# 8. Escolaridade média da população de 18 a 29 anos de idade ####

pnad_med <- subset(pnad,V2009 %in% c(18:29))
pnad_med$nr_denominador <- as.numeric(pnad_med$V1028)
pnad_med$nr_numerador <- as.numeric(pnad_med$VD3002)
pne_ind <- rbind.fill(
  data.frame(cd_indicador=8,ddply(pnad_med, .(ANO,CAPITAL), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=8,ddply(pnad_med, .(ANO,RM_RIDE), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=8,ddply(pnad_med, .(ANO,UF), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=8,ddply(pnad_med, .(ANO,id_regiao), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=8,ddply(pnad_med, .(ANO,total), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  pne_ind
)

# 9. Escolaridade média da população de 18 a 29 anos residente na área rural ####

pnad_med <- subset(pnad,V2009 %in% c(18:29) & V1022==2)
pnad_med$nr_denominador <- as.numeric(pnad_med$V1028)
pnad_med$nr_numerador <- as.numeric(pnad_med$VD3005)
pne_ind <- rbind.fill(
  data.frame(cd_indicador=9,ddply(pnad_med, .(ANO,CAPITAL), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=9,ddply(pnad_med, .(ANO,RM_RIDE), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=9,ddply(pnad_med, .(ANO,UF), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=9,ddply(pnad_med, .(ANO,id_regiao), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=9,ddply(pnad_med, .(ANO,total), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  pne_ind
)

# 10. Escolaridade média da população de 18 a 29 anos pertencente aos 25% mais pobres ####

pnad_med$nr_denominador <- as.numeric(pnad_med$V1028)
pnad_med$nr_numerador <- as.numeric(pnad_med$VD3005)
q_renda <- wtd.quantile(pnad_med$VDI5002,q=0.25,na.rm=T,weight = pnad_med$V1028)
pnad_med <- subset(pnad_med,!is.na(nr_numerador) & V2009 %in% c(18:29) & as.numeric(pnad_med$VDI5002)<=q_renda)
pne_ind <- rbind.fill(
  data.frame(cd_indicador=10,ddply(pnad_med, .(ANO,CAPITAL), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=10,ddply(pnad_med, .(ANO,RM_RIDE), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=10,ddply(pnad_med, .(ANO,UF), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=10,ddply(pnad_med, .(ANO,id_regiao), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=10,ddply(pnad_med, .(ANO,total), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  pne_ind
)

# 11. Razão entre a escolaridade média de negros e não negros na faixa etária de 18 a 29 anos ####

# Negros = pretos e pardos
pnad_med <- subset(pnad,V2009 %in% c(18:29) & V2010 %in% c(2,4))
pnad_med$nr_denominador <- as.numeric(pnad_med$V1028)
pnad_med$nr_numerador <- as.numeric(pnad_med$VD3005)
pnad_med_negros <- rbind.fill(
  data.frame(ddply(pnad_med, .(ANO,CAPITAL), function(x) data.frame(vl_indicador1=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,RM_RIDE), function(x) data.frame(vl_indicador1=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,UF), function(x) data.frame(vl_indicador1=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,id_regiao), function(x) data.frame(vl_indicador1=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,total), function(x) data.frame(vl_indicador1=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T))))  
)

# Não negros = brancos e amarelos
pnad_med <- subset(pnad,V2009 %in% c(18:29) & V2010 %in% c(1,3))
pnad_med$nr_denominador <- as.numeric(pnad_med$V1028)
pnad_med$nr_numerador <- as.numeric(pnad_med$VD3005)
pnad_med_nao_negros <- rbind.fill(
  data.frame(ddply(pnad_med, .(ANO,CAPITAL), function(x) data.frame(vl_indicador2=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,RM_RIDE), function(x) data.frame(vl_indicador2=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,UF), function(x) data.frame(vl_indicador2=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,id_regiao), function(x) data.frame(vl_indicador2=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(ddply(pnad_med, .(ANO,total), function(x) data.frame(vl_indicador2=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T))))  
)

# Cálculo da razão
pnad_med_negros[is.na(pnad_med_negros)] <- "@"
pnad_med_nao_negros[is.na(pnad_med_nao_negros)] <- "@"
pnad_med <- merge(pnad_med_negros,pnad_med_nao_negros,by=c("ANO","CAPITAL","RM_RIDE","UF","id_regiao","total"))
pnad_med$vl_indicador <- (pnad_med$vl_indicador1/pnad_med$vl_indicador2)*100
pnad_med[pnad_med=="@"] <- NA
pne_ind <- rbind.fill(
  data.frame(cd_indicador=11,pnad_med[c("ANO","CAPITAL","RM_RIDE","UF","id_regiao","total","vl_indicador")]),
  pne_ind
)

pne_result <- pne_ind

# Define códigos de unidade únicos
pne_result$id_unidade <- ifelse(!is.na(pne_result$CAPITAL),paste0(pne_result$CAPITAL,'00'),NA)
pne_result$id_unidade <- ifelse(!is.na(pne_result$RM_RIDE),paste0(pne_result$RM_RIDE,'0'),pne_result$id_unidade)
pne_result$id_unidade <- ifelse(!is.na(pne_result$UF),pne_result$UF,pne_result$id_unidade)
pne_result$id_unidade <- ifelse(!is.na(pne_result$id_regiao),pne_result$id_regiao,pne_result$id_unidade)
pne_result$id_unidade <- ifelse(!is.na(pne_result$total),0,pne_result$id_unidade)
pne_result$id_unidade <- as.numeric(pne_result$id_unidade)

# Cria dataframe com nomes das unidades ####
unidades <- data.frame(
  id_unidade=c(0,1,2,3,4,5,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,31,32,33,35,41,42,43,50,51,52,53,130,150,160,210,220,230,240,250,260,270,280,290,310,320,330,350,410,420,430,510,520,1100,1200,1300,1400,1500,1600,1700,2100,2200,2300,2400,2500,2600,2700,2800,2900,3100,3200,3300,3500,4100,4200,4300,5000,5100,5200,5300),
  nm_unidade=c("Brasil","Norte","Nordeste","Sudeste","Sul","Centro-Oeste","Rondônia","Acre","Amazonas","Roraima","Pará","Amapá","Tocantins","Maranhão","Piauí","Ceará","Rio Grande do Norte","Paraíba","Pernambuco","Alagoas","Sergipe","Bahia","Minas Gerais","Espírito Santo","Rio de Janeiro","São Paulo","Paraná","Santa Catarina","Rio Grande do Sul","Mato Grosso do Sul","Mato Grosso","Goiás","Distrito Federal","Manaus - RM","Belém - RM","Macapá - RM","São Luís - RM","Teresina - RM","Fortaleza - RM","Natal - RM","João Pessoa - RM","Recife - RM","Maceió - RM","Aracaju - RM","Salvador - RM","Belo Horizonte - RM","Vitória - RM","Rio de Janeiro - RM","São Paulo - RM","Curitiba - RM","Florianópolis - RM","Porto Alegre - RM","Cuiabá - RM","Goiânia - RM","Porto Velho","Rio Branco","Manaus","Boa Vista","Belém","Macapá","Palmas","São Luís","Teresina","Fortaleza","Natal","João Pessoa","Recife","Maceió","Aracaju","Salvador","Belo Horizonte","Vitória","Rio de Janeiro","São Paulo","Curitiba","Florianópolis","Porto Alegre","Campo Grande","Cuiabá","Goiânia","Brasília")
)

# Cria dataframe com descrição dos indicadores ####
indicadores <- data.frame(
  cd_indicador=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17),
  sg_indicador=toupper(c("1a","1b","2a","2b","3a","3b","3v1","8a","8b","8c","8d","8e","8f","8g","8h","9a","9b")),
  ds_indicador=c(
  "Taxa de atendimento escolar de pessoas de 4 a 5 anos (%)",
  "Taxa de atendimento escolar de pessoas de 0 a 3 anos (%)",
  "Taxa de escolarização líquida ajustada de pessoas de 6 a 14 anos  (%)",
  "Percentual de pessoas de 16 anos com pelo menos o ensino fundamental concluído (%)",  
  "Taxa de atendimento escolar de pessoas de 15 a 17 anos (%)", 
  "Taxa de escolarização líquida ajustada de pessoas de 15 a 17 (%)",  
  "Percentual de pessoas de 19 anos com pelo menos o ensino médio concluído (%)",
  "Escolaridade média da população de 18 a 29 anos de idade",
  "Escolaridade média da população de 18 a 29 anos residente na área rural",
  "Escolaridade média da população de 18 a 29 anos pertencente aos 25% mais pobres",
  "Razão entre a escolaridade média de negros e não negros na faixa etária de 18 a 29 anos",
  "Percentual da População de 18 a 29 anos com menos de 12 anos de escolaridade",
  "Percentual da População de 18 a 29 anos residente no campo com menos de 12 anos de escolaridade",
  "Percentual da População de 18 a 29 anos entre os 25% mais pobres com menos de 12 anos de escolaridade",
  "Percentual da População negra entre 18 e 29 anos com menos de 12 anos de escolaridade",
  "Taxa de alfabetização da população de 15 anos ou mais de idade (%)",
  "Taxa de analfabetismo funcional de pessoas de 15 anos ou mais de idade (%)"
  )
)

# Unifica dados com seus nomes e descrições ####
pne_result <- merge(pne_result,unidades,by="id_unidade")
pne_result <- merge(pne_result,indicadores,by="cd_indicador")
pne_result <- pne_result[order(c(pne_result$id_unidade,pne_result$cd_indicador,pne_result$cd_tipo_categoria,pne_result$cd_categoria)),]
pne_result <- pne_result[c("ANO","id_unidade","nm_unidade","sg_indicador","ds_indicador","nr_denominador","nr_numerador","vl_indicador")]

# Seleciona dados apenas com código de unidade válidos ####
pne_result <- subset(pne_result,!is.na(id_unidade))

pne_result <- dcast(data.table(pne_result),id_unidade+nm_unidade+sg_indicador+ds_indicador~ANO,value.var=c("nr_numerador","nr_denominador","vl_indicador"))

# Exporta resultado para CSV
write.csv2(pne_result,"pne_pnad.csv",row.names=F,na="")
