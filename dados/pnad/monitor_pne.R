# Dados de Monitoramento do PNE 2014-2024

# Carrega dados das PNAD
load("../../bases/pnad/pnads.RData")

# Carrega bibliotecas
library(lubridate)
library(data.table)

# Declara função para cálculo de idade
calcIdade <- function(nascimento, referencia = Sys.Date()) {
  periodo <- as.period(interval(nascimento, referencia),unit = "year")
  periodo$year
}

# Empilha os anos e filtra as variáveis usadas no monitoramento do PNE
pnad <- rbind(
  pnad11[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad12[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad13[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad14[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad15[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")]
)

# Seleciona pessoas com data de nascimento informada
pnad <- subset(pnad, V3032 %in% c(1:12))

# Vincula variáveis
attach(pnad)

# Cria a variável "idade_cne" com a data de referência de 31 de março de cada ano
pnad$idade_cne <- calcIdade(paste(
  V3033, sprintf("%02d",V3032), V3031, sep="-"),
  paste(substr(V0101,1,4),"-03-31",sep=""))

# Desvincula variáveis
detach(pnad)

# Seleciona pessoas de 0 a 3 anos e vincula variáveis
attach(subset(pnad,idade_cne %in% c(0:3)))

# Calcula absoluto e percentual anos que frequentam a escola para o Brasil
num=tapply(V4729[V0602==2], V0101[V0602==2], sum)
den=tapply(V4729, V0101, sum)
indic_br_1B = data.frame(indic="1b", unid=0 , ano=row.names(num), num, den, perc = (num/den)*100)

# Calcula absoluto e percentual anos que frequentam a escola para as regiões
num=setNames(melt(tapply(V4729[V0602==2], list(substr(UF[V0602==2],1,1),V0101[V0602==2]), sum)),c("unid","ano","num"))
den=setNames(melt(tapply(V4729, list(substr(UF,1,1),V0101), sum)),c("unid","ano","den"))
indic_rg_1B = data.frame(indic="1b", num[c(-3)], num[3], den[3], perc = (num$num/den$den)*100)

# Calcula absoluto e percentual anos que frequentam a escola para as UFs
num=setNames(melt(tapply(V4729[V0602==2], list(UF[V0602==2],V0101[V0602==2]), sum)),c("unid","ano","num"))
den=setNames(melt(tapply(V4729, list(UF,V0101), sum)),c("unid","ano","den"))
indic_uf_1B = data.frame(indic="1b", num[c(-3)], num[3], den[3], perc = (num$num/den$den)*100)

# Desvincula variáveis
detach(subset(pnad,idade_cne %in% c(0:3)))

# Seleciona pessoas de 4 a 5 anos e vincula variáveis
attach(subset(pnad,idade_cne %in% c(4:5)))

# Calcula absoluto e percentual anos que frequentam a escola para o Brasil
num=tapply(V4729[V0602==2], V0101[V0602==2], sum)
den=tapply(V4729, V0101, sum)
indic_br_1A = data.frame(indic="1a", unid=0 , ano=row.names(num), num, den, perc = (num/den)*100)

# Calcula absoluto e percentual anos que frequentam a escola para o regiões
num=setNames(melt(tapply(V4729[V0602==2], list(substr(UF[V0602==2],1,1),V0101[V0602==2]), sum)),c("unid","ano","num"))
den=setNames(melt(tapply(V4729, list(substr(UF,1,1),V0101), sum)),c("unid","ano","den"))
indic_rg_1A = data.frame(indic="1a", num[c(-3)], num[3], den[3], perc = (num$num/den$den)*100)

# Calcula absoluto e percentual anos que frequentam a escola para as UFs
num=setNames(melt(tapply(V4729[V0602==2], list(UF[V0602==2],V0101[V0602==2]), sum)),c("unid","ano","num"))
den=setNames(melt(tapply(V4729, list(UF,V0101), sum)),c("unid","ano","den"))
indic_uf_1A = data.frame(indic="1a", num[c(-3)], num[3], den[3], perc = (num$num/den$den)*100)

# Desvincula variáveis
detach(subset(pnad,idade_cne %in% c(4:5)))

# Seleciona pessoas de 6 a 14 anos e vincula variáveis
attach(subset(pnad,idade_cne %in% c(6:14)))

# Calcula absoluto e percentual anos que frequentam a escola para o Brasil
num=tapply(V4729[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                 (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                 (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))], 
           V0101[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                 (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                 (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))], sum)
den=tapply(V4729, V0101, sum)
indic_br_2A = data.frame(indic="2a", unid=0 , ano=row.names(num), num, den, perc = (num/den)*100)

# Calcula absoluto e percentual anos que frequentam a escola para as regiões
num=setNames(melt(tapply(V4729[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                               (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                               (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))], 
                         list(substr(UF[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                                        (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                                        (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))],1,1),
                              V0101[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                                    (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                                    (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))]),sum)),c("unid","ano","num"))
den=setNames(melt(tapply(V4729, list(substr(UF,1,1),V0101), sum)),c("unid","ano","den"))
indic_rg_2A = data.frame(indic="2a", num[c(-3)], num[3], den[3], perc = (num$num/den$den)*100)

# Calcula absoluto e percentual anos que frequentam a escola para as UFs
num=setNames(melt(tapply(V4729[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                               (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                               (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))], 
                         list(UF[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                                 (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                                 (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))],
                              V0101[(V0602==2 & V6003 %in% c(1,2,3,5,8,10,11)) | 
                                    (V0602==4 & V0606==2 & V0611==1 & V6007 %in% c(4,6)) |
                                    (V0602==4 & V0606==2 & V6007 %in% c(5,8,9))]
                         ),sum)),c("unid","ano","num"))
den=setNames(melt(tapply(V4729, list(UF,V0101), sum)),c("unid","ano","den"))
indic_uf_2A = data.frame(indic="2a", num[c(-3)], num[3], den[3], perc = (num$num/den$den)*100)

# Desvincula variáveis
detach(subset(pnad,idade_cne %in% c(6:14)))
