## pnad_2017_educacao.R - Produz os dados educacionais do IBGE usando a Pnad Contínua 2017
## Escrito por: George Gomes (Fortaleza - Ceará)
## E-mail: georgegomesf@gmail.com

# Impede conversão de número em notação científica ####
options(scipen=999)

# Carrega bibliotecas utilizadas ####
library(data.table)
library(plyr)

# Carrega dados ####
load("pnad2017.RData")

# Substitui do dataframe carregado para um a ser usado no tratamento e produção de dados ####
pnad <- pnad2017

# Converte a variável de peso da pessoa em tipo numérico ####
pnad$V1028 <- as.numeric(as.character(pnad$V1028))

# Cria variável para o código da grande região ####
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

# Produzi dados e indicadores de acordo com as principais categorias ####

# 1. População ####

pnad_pes <- rbind.fill(
  data.frame(cd_indicador=1,cd_tipo_categoria=99,dcast(pnad,CAPITAL~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=99,dcast(pnad,RM_RIDE~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=99,dcast(pnad,UF~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=99,dcast(pnad,id_regiao~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=99,dcast(pnad,total~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T))
)

# 1.1 População - Grupos de Idade ####

pnad_pes <- rbind.fill(
  data.frame(cd_indicador=1,cd_tipo_categoria=1,dcast(pnad,CAPITAL+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=1,dcast(pnad,RM_RIDE+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=1,dcast(pnad,UF+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=1,dcast(pnad,id_regiao+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=1,cd_tipo_categoria=1,dcast(pnad,total+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  pnad_pes
)

# 2. Estudantes ####

pnad_estuda <- subset(pnad,V3002==1)

pnad_pes <- rbind.fill(
  data.frame(cd_indicador=2,cd_tipo_categoria=99,dcast(pnad_estuda,CAPITAL~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=99,dcast(pnad_estuda,RM_RIDE~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=99,dcast(pnad_estuda,UF~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=99,dcast(pnad_estuda,id_regiao~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=99,dcast(pnad_estuda,total~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  pnad_pes
)

# 2.1 Estudantes - Grupos de Idade ####

pnad_pes <- rbind.fill(
  data.frame(cd_indicador=2,cd_tipo_categoria=1,dcast(pnad_estuda,CAPITAL+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=1,dcast(pnad_estuda,RM_RIDE+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=1,dcast(pnad_estuda,UF+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=1,dcast(pnad_estuda,id_regiao+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=1,dcast(pnad_estuda,total+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  pnad_pes
)

# 2.2 Estudantes - Redes de Ensino ####

pnad_pes <- rbind.fill(
  data.frame(cd_indicador=2,cd_tipo_categoria=2,dcast(pnad_estuda,CAPITAL+V3002A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=2,dcast(pnad_estuda,RM_RIDE+V3002A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=2,dcast(pnad_estuda,UF+V3002A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=2,dcast(pnad_estuda,id_regiao+V3002A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=2,dcast(pnad_estuda,total+V3002A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  pnad_pes
)

# 2.3 Estudantes - Curso que Frequenta ####

pnad_pes <- rbind.fill(
  data.frame(cd_indicador=2,cd_tipo_categoria=3,dcast(pnad_estuda,CAPITAL+V3003A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=3,dcast(pnad_estuda,RM_RIDE+V3003A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=3,dcast(pnad_estuda,UF+V3003A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=3,dcast(pnad_estuda,id_regiao+V3003A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=2,cd_tipo_categoria=3,dcast(pnad_estuda,total+V3003A~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  pnad_pes
)

# 3. Pessoas que não sabem ler e escrever ####

pnad_analfab <- subset(pnad,V3001==2 & pnad$V2009>=15)

pnad_pes <- rbind.fill(
  data.frame(cd_indicador=3,cd_tipo_categoria=1,dcast(pnad_analfab,CAPITAL+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,cd_tipo_categoria=1,dcast(pnad_analfab,RM_RIDE+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,cd_tipo_categoria=1,dcast(pnad_analfab,UF+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,cd_tipo_categoria=1,dcast(pnad_analfab,id_regiao+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=3,cd_tipo_categoria=1,dcast(pnad_analfab,total+cd_grupo_idade+ds_grupo_idade~"nr_pessoas",value.var=c("V1028"),sum,na.rm=T)),
  pnad_pes
)

# 4. Taxa de escolarização (%) ####

pnad_esc <- subset(pnad,V2009 <= 17)

pnad_esc$ds_grupo_idade <- ifelse(pnad_esc$V2009 %in% c(6:14),'De 6 a 14',pnad_esc$ds_grupo_idade)
pnad_esc$cd_grupo_idade <- ifelse(pnad_esc$V2009 %in% c(6:14),3,pnad_esc$cd_grupo_idade)

pnad_esc$sg_parte <- ifelse(pnad_esc$V2009 %in% c(0:5) & pnad_esc$V3002==1,"nr_numerador","nr_parte")
pnad_esc$sg_parte <- ifelse(pnad_esc$V2009 %in% c(6:14) & pnad_esc$V3002==1,"nr_numerador",pnad_esc$sg_parte)
pnad_esc$sg_parte <- ifelse(pnad_esc$V2009 %in% c(15:17) & pnad_esc$V3002==1,"nr_numerador",pnad_esc$sg_parte)

pnad_ind <- rbind.fill(
  data.frame(cd_indicador=4,cd_tipo_categoria=1,dcast(pnad_esc,CAPITAL+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,cd_tipo_categoria=1,dcast(pnad_esc,RM_RIDE+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,cd_tipo_categoria=1,dcast(pnad_esc,UF+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,cd_tipo_categoria=1,dcast(pnad_esc,id_regiao+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=4,cd_tipo_categoria=1,dcast(pnad_esc,total+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T))  
)

# 5. Taxa ajustada de frequência escolar líquida (%) ####

pnad_esc <- subset(pnad,V2009 %in% c(6:14))

# Recorte etário de 6 a 10 anos
pnad_esc$sg_parte <- ifelse(
    pnad_esc$V2009 %in% c(6:10) &
    (
      pnad_esc$V3003A==4
      |
        (pnad_esc$V3009A==7 & (
             (pnad_esc$V3013A==1 & pnad_esc$V3013B==1)
             |
             pnad_esc$V3013A==2
             | 
             (pnad_esc$V3010==1 & pnad_esc$V3013 %in% c(5:8))
             | 
             (pnad_esc$V3010==2 & pnad_esc$V3013 %in% c(6:9))
           )
        )
    ),"nr_numerador","nr_parte")

# Recorte etário de 11 a 14 anos
pnad_esc$sg_parte <- ifelse(
  pnad_esc$V2009 %in% c(11:14) &
  (
    (pnad_esc$V3003A==4 &
       (
         (pnad_esc$V3004==1 & pnad_esc$V3006 %in% c(5:8))
         | 
           (pnad_esc$V3004==2 & pnad_esc$V3006 %in% c(6:9))
         | 
         (pnad_esc$V3006==13 & pnad_esc$V3006A==2)
       )
    )
    |
    pnad_esc$VD3004==3
  ),"nr_numerador",pnad_esc$sg_parte)
pnad_esc[is.na(pnad_esc$sg_parte),]$sg_parte <- "nr_parte"

pnad_ind <- rbind.fill(
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,CAPITAL+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,RM_RIDE+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,UF+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,id_regiao+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,total+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pnad_ind
)

pnad_esc <- subset(pnad,V2009 %in% c(6:24))

# Recorte etário de 6 a 14 anos
pnad_esc$ds_grupo_idade <- ifelse(pnad_esc$V2009 %in% c(6:14),'De 6 a 14',pnad_esc$ds_grupo_idade)
pnad_esc$cd_grupo_idade <- ifelse(pnad_esc$V2009 %in% c(6:14),3,pnad_esc$cd_grupo_idade)
pnad_esc$sg_parte <- ifelse(pnad_esc$V2009 %in% c(6:14) & (pnad_esc$V3003A==4 | pnad_esc$VD3004==3),"nr_numerador","nr_parte")

# Recorte etário de 15 a 17 anos
pnad_esc$sg_parte <- ifelse(pnad_esc$V2009 %in% c(15:17) & (pnad_esc$V3003A==6 | pnad_esc$VD3004==5),"nr_numerador",pnad_esc$sg_parte)

# Recorte etário de 18 a 24 anos
pnad_esc$sg_parte <- ifelse(pnad_esc$V2009 %in% c(18:24) & (pnad_esc$V3003A==8 | pnad_esc$VD3004==7),"nr_numerador",pnad_esc$sg_parte)
pnad_esc[is.na(pnad_esc$sg_parte),]$sg_parte <- "nr_parte"

pnad_ind <- rbind.fill(
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,CAPITAL+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,RM_RIDE+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,UF+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,id_regiao+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=5,cd_tipo_categoria=1,dcast(pnad_esc,total+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pnad_ind
)

# 6. Taxa de analfabetismo (%) ####

pnad_analfab <- subset(pnad,V2009 >=15)
pnad_analfab$ds_grupo_idade <- "15 ou mais"

# Recorte etário para todas as pessoas a partir de 15 anos
pnad_analfab$cd_grupo_idade <- 0
pnad_analfab$sg_parte <- ifelse(pnad_analfab$V3001==2,"nr_numerador","nr_parte")

pnad_ind <- rbind.fill(
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,CAPITAL+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,RM_RIDE+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,UF+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,id_regiao+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,total+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pnad_ind
)

pnad_ind$nr_denominador <- pnad_ind$nr_numerador+pnad_ind$nr_parte
pnad_ind$vl_indicador <- pnad_ind$nr_numerador/pnad_ind$nr_denominador*100

pnad_analfab <- subset(pnad,V2009 >=15)

# Diversos recortes etários para as pessoas a partir de 15 anos
pnad_analfab$sg_parte <- ifelse(pnad_analfab$V3001==2,"nr_numerador","nr_parte")

pnad_ind <- rbind.fill(
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,CAPITAL+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,RM_RIDE+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,UF+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,id_regiao+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  data.frame(cd_indicador=7,cd_tipo_categoria=1,dcast(pnad_analfab,total+cd_grupo_idade+ds_grupo_idade~sg_parte,value.var=c("V1028"),sum,na.rm=T)),
  pnad_ind
)

pnad_ind$nr_denominador <- pnad_ind$nr_numerador+pnad_ind$nr_parte
pnad_ind$vl_indicador <- pnad_ind$nr_numerador/pnad_ind$nr_denominador*100

# 7. Número médio de anos de estudo ####

pnad_med <- subset(pnad,V2009>=15)
pnad_med$ds_grupo_idade <- "15 ou mais"
pnad_med$cd_grupo_idade <- 0
pnad_med$nr_denominador <- pnad_med$V1028
pnad_med$nr_numerador <- as.numeric(as.character(pnad_med$VD3005))

pnad_ind <- rbind.fill(
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(CAPITAL,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(RM_RIDE,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(UF,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(id_regiao,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(total,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  pnad_ind
)

pnad_med <- subset(pnad,V2009>=15)
pnad_med$nr_denominador <- pnad_med$V1028
pnad_med$nr_numerador <- as.numeric(as.character(pnad_med$VD3005))

pnad_ind <- rbind.fill(
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(CAPITAL,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(RM_RIDE,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(UF,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(id_regiao,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  data.frame(cd_indicador=6,cd_tipo_categoria=1,ddply(pnad_med, .(total,cd_grupo_idade,ds_grupo_idade), function(x) data.frame(vl_indicador=weighted.mean(x$nr_numerador, x$nr_denominador,na.rm=T)))),
  pnad_ind
)

# Unifica dados populacionais e indicadores ####
pnad_result <- rbind.fill(
	pnad_pes,	
	pnad_ind
	)

# Unifica dados aboslutos e relativos na mesma variável (vl_indicador) ####
pnad_result$vl_indicador <- ifelse(!is.na(pnad_result$vl_indicador),pnad_result$vl_indicador,pnad_result$nr_pessoas)

# Define códigos de unidade únicos
pnad_result$id_unidade <- ifelse(!is.na(pnad_result$CAPITAL),paste0(pnad_result$CAPITAL,'00'),NA)
pnad_result$id_unidade <- ifelse(!is.na(pnad_result$RM_RIDE),paste0(pnad_result$RM_RIDE,'0'),pnad_result$id_unidade)
pnad_result$id_unidade <- ifelse(!is.na(pnad_result$UF),pnad_result$UF,pnad_result$id_unidade)
pnad_result$id_unidade <- ifelse(!is.na(pnad_result$id_regiao),pnad_result$id_regiao,pnad_result$id_unidade)
pnad_result$id_unidade <- ifelse(!is.na(pnad_result$total),0,pnad_result$id_unidade)
pnad_result$id_unidade <- as.numeric(pnad_result$id_unidade)

# Define códigos de categorias ####
pnad_result$cd_categoria <- 99
pnad_result$cd_categoria <- ifelse(!is.na(pnad_result$cd_grupo_idade),pnad_result$cd_grupo_idade,pnad_result$cd_categoria)
pnad_result$cd_categoria <- ifelse(!is.na(pnad_result$V3002A),pnad_result$V3002A,pnad_result$cd_categoria)
pnad_result$cd_categoria <- ifelse(!is.na(pnad_result$V3003A),pnad_result$V3003A,pnad_result$cd_categoria)

# Cria dataframe com nomes das unidades ####
unidades <- data.frame(
	id_unidade=c(0,1,2,3,4,5,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,31,32,33,35,41,42,43,50,51,52,53,130,150,160,210,220,230,240,250,260,270,280,290,310,320,330,350,410,420,430,510,520,1100,1200,1300,1400,1500,1600,1700,2100,2200,2300,2400,2500,2600,2700,2800,2900,3100,3200,3300,3500,4100,4200,4300,5000,5100,5200,5300),
	nm_unidade=c("Brasil","Norte","Nordeste","Sudeste","Sul","Centro-Oeste","Rondônia","Acre","Amazonas","Roraima","Pará","Amapá","Tocantins","Maranhão","Piauí","Ceará","Rio Grande do Norte","Paraíba","Pernambuco","Alagoas","Sergipe","Bahia","Minas Gerais","Espírito Santo","Rio de Janeiro","São Paulo","Paraná","Santa Catarina","Rio Grande do Sul","Mato Grosso do Sul","Mato Grosso","Goiás","Distrito Federal","Manaus - RM","Belém - RM","Macapá - RM","São Luís - RM","Teresina - RM","Fortaleza - RM","Natal - RM","João Pessoa - RM","Recife - RM","Maceió - RM","Aracaju - RM","Salvador - RM","Belo Horizonte - RM","Vitória - RM","Rio de Janeiro - RM","São Paulo - RM","Curitiba - RM","Florianópolis - RM","Porto Alegre - RM","Cuiabá - RM","Goiânia - RM","Porto Velho","Rio Branco","Manaus","Boa Vista","Belém","Macapá","Palmas","São Luís","Teresina","Fortaleza","Natal","João Pessoa","Recife","Maceió","Aracaju","Salvador","Belo Horizonte","Vitória","Rio de Janeiro","São Paulo","Curitiba","Florianópolis","Porto Alegre","Campo Grande","Cuiabá","Goiânia","Brasília")
)

# Cria dataframe com descrição das categorias e seus tipos ####
categorias <- data.frame(
	cd_tipo_categoria=c(1,1,1,1,1,1,1,1,1,1,2,2,3,3,3,3,3,3,3,3,3,3,3,99),
	cd_categoria=c(1,2,3,4,5,6,7,8,9,10,1,2,1,2,3,4,5,6,7,8,9,10,11,99),
	ds_tipo_categoria=c("Grupos de idade","Grupos de idade","Grupos de idade","Grupos de idade","Grupos de idade","Grupos de idade","Grupos de idade","Grupos de idade","Grupos de idade","Grupos de idade","Rede de ensino","Rede de ensino","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Curso que frequenta","Total"),
	ds_categoria=c("De 0 a 3","De 4 a 5","De 6 a 10","De 11 a 14","De 15 a 17","De 18 a 24","De 25 a 29","De 30 a 39","De 40 a 59","60 ou mais","Privada","Pública","Creche (disponível apenas no questionário anual de educação)","Pré-escola","Alfabetização de jovens e adultos","Regular do ensino fundamental","Educação de jovens e adultos (EJA) ou supletivo do ensino fundamental","Regular do ensino médio","Educação de jovens e adultos (EJA) ou supletivo do ensino médio","Superior - graduação","Especialização de nível superior","Mestrado","Doutorado","Total")
	)

# Cria dataframe com descrição dos indicadores ####
indicadores <- data.frame(
  cd_indicador=c(1,2,3,4,5,6,7),
  ds_indicador=c(
  "População",
  "Estudantes",
  "Pessoas que não sabem ler e escrever",
  "Taxa de escolarização (%)",
  "Taxa ajustada de frequência escolar líquida (%)",
  "Número médio de anos de estudo",
  "Taxa de analfabetismo (%)"
  )
)

# Unifica dados com seus nomes e descrições ####
pnad_result <- merge(pnad_result,unidades,by="id_unidade")
pnad_result <- merge(pnad_result,categorias,by=c("cd_tipo_categoria","cd_categoria"))
pnad_result <- merge(pnad_result,indicadores,by="cd_indicador")
pnad_result <- pnad_result[c("id_unidade","nm_unidade","cd_indicador","ds_indicador","cd_tipo_categoria","ds_tipo_categoria","cd_categoria","ds_categoria","vl_indicador")]
pnad_result <- pnad_result[order(c(pnad_result$id_unidade,pnad_result$cd_indicador,pnad_result$cd_tipo_categoria,pnad_result$cd_categoria)),]

# Ordena dados
pnad_result <- pnad_result[order(pnad_result$id_unidade,pnad_result$cd_indicador,pnad_result$cd_tipo_categoria,pnad_result$cd_categoria),]

# Seleciona apenas dados com código de unidade válidos (exclui dados de "não capitais" e de "não regiões metropolitanas") ####
pnad_result <- subset(pnad_result,!is.na(id_unidade))

# Exporta resultado para CSV
write.csv2(pnad_result,"pnad_2017_educacao.csv",row.names=F,na="")
