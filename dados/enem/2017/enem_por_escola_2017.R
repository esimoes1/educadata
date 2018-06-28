## Enem_por_escola.R - Produz os resultados do ENEM 2017
## Escrito por: George Gomes (Fortaleza - Ceará)
## E-mail: georgegomesf@gmail.com

# Impede conversão de número em notação científica ####
options(scipen=999)

# Carrega bibliotecas utilizadas ####
library(data.table)
library(plyr)

# Carrega dados ####
load("MICRODADOS_ENEM_2017_escola.RData")

# 1. CÁLCULO DE PARTICIPAÇÃO

# Trata e alinha a base de escolas acrescentando os rótulos das redes e número de matrículas
redes <- data.frame(TP_DEPENDENCIA=c(1,2,3,4),DS_DEPENDENCIA=c("Federal","Estadual","Municipal","Privada"))
escolas2017 <- merge(escolas2017,redes,by="TP_DEPENDENCIA")
escolas2017 <- setNames(
		merge(escolas2017,dcast(turmas2017,CO_ENTIDADE~"NU_MATRICULAS",value.var="NU_MATRICULAS",sum)),
		c("id_escola","cd_dependencia","nm_escola","id_municipio","ds_dependencia","nr_matriculas")
	)

# Trata e alinha a base do ENEM calculando o número de inscritos e de participantes
enem2017[is.na(enem2017$TP_PRESENCA_CN),]$TP_PRESENCA_CN <- 0
enem2017[is.na(enem2017$TP_PRESENCA_LC),]$TP_PRESENCA_LC <- 0
enem2017$ds_participante <- ifelse(enem2017$TP_PRESENCA_CN==1 & enem2017$TP_PRESENCA_CH==1 & enem2017$TP_PRESENCA_LC==1 & enem2017$TP_PRESENCA_MT==1,"participante","nao_participante")
enem_part <- setNames(dcast(enem2017,CO_ESCOLA~ds_participante),c("id_escola","nr_nao_participantes","nr_participantes"))
enem_part$nr_inscritos <- enem_part$nr_participantes+enem_part$nr_nao_participantes

# Alinha base de municípios
regioes <- data.frame(id_regiao=c(1,2,3,4,5),nm_regiao=c("Norte","Nordeste","Sudeste","Sul","Centro-Oeste"))
municipios2017 <- setNames(municipios2017,c("id_uf","nm_uf","sg_uf","id_municipio","nm_municipio"))
municipios2017$id_regiao <- substring(municipios2017$id_uf,1,1)
municipios2017 <- merge(municipios2017,regioes,by="id_regiao")

# Unifica as bases ####
enem_part <- merge(enem_part,escolas2017,by="id_escola")
enem_part <- merge(enem_part,municipios2017,by="id_municipio")

# Cálculoa os percentuais de indscritos e participantes, limitando ambos a 100%
enem_part$pc_inscricao <- enem_part$nr_inscritos/enem_part$nr_matriculas*100
enem_part$pc_participacao <- enem_part$nr_participantes/enem_part$nr_matriculas*100
enem_part$pc_inscricao <- ifelse(enem_part$pc_inscricao>=100,100,enem_part$pc_inscricao)
enem_part$pc_participacao <- ifelse(enem_part$pc_participacao>=100,100,enem_part$pc_participacao)

# Trata e alinha a base do ENEM calculando as médias para as áreas e para redação das escolas que atingiram o número mínimo de participantes (10) e o percentual mínimo de participação (50)
enem_result <- subset(enem2017,enem2017$ds_participante=="participante" & CO_ESCOLA %in% subset(enem_part,nr_participantes>=10)$id_escola & CO_ESCOLA %in% subset(enem_part,pc_participacao>=50)$id_escola)
enem_result[] <- lapply(lapply(enem_result, as.character),as.numeric)
enem_result <- setNames(
	data.frame(dcast(data.table(enem_result),NU_ANO+CO_ESCOLA~"",value.var=c("NU_NOTA_CN","NU_NOTA_CH","NU_NOTA_LC","NU_NOTA_MT","NU_NOTA_COMP1","NU_NOTA_COMP2","NU_NOTA_COMP3","NU_NOTA_COMP4","NU_NOTA_COMP5","NU_NOTA_REDACAO"),mean)),
	c("nr_ano_enem","id_escola","nr_media_cn","nr_media_ch","nr_media_lc","nr_media_mt","nr_media_comp_1","nr_media_comp_2","nr_media_comp_3","nr_media_comp_4","nr_media_comp_5","nr_media_redacao")
)	
enem_result$nr_media_areas <- (enem_result$nr_media_cn+enem_result$nr_media_ch+enem_result$nr_media_lc+enem_result$nr_media_mt)/4
enem_result$nr_media_geral <- (enem_result$nr_media_cn+enem_result$nr_media_ch+enem_result$nr_media_lc+enem_result$nr_media_mt+enem_result$nr_media_redacao)/5

# Unifica participação e médias

enem_escola <- merge(enem_part,enem_result,by="id_escola")

# Ordena variáveis
enem_escola <- enem_escola[c(
	"nr_ano_enem","id_regiao","nm_regiao","id_uf","sg_uf","id_municipio","nm_municipio","cd_dependencia","ds_dependencia","id_escola","nm_escola",
	"nr_matriculas","nr_inscritos","nr_participantes","pc_inscricao","pc_participacao",
	"nr_media_cn","nr_media_ch","nr_media_lc","nr_media_mt","nr_media_comp_1","nr_media_comp_2","nr_media_comp_3","nr_media_comp_4","nr_media_comp_5","nr_media_redacao","nr_media_areas","nr_media_geral"
	)]

# Exporta resultado para CSV
write.csv2(enem_escola,"enem_por_escola_2017.csv",row.names=F,na="")

