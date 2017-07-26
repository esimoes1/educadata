# Dados do Índice de Desenvolvimento da Educação - IDEB
# Fonte: INEP/Ideb
# Elaboração: Educadata - http://educadata.org

# Expande a quantidade máxima de memória dinâmica da máquina virtual Java
options(java.parameters = "-Xmx8000m")

# Carrega bibliotecas
library(xlsx)
library(data.table)
library(plyr)

# Carrega dados do Ideb por escola para os Anos Iniciais renomeando o cabeçalho e retirando as linhas de Fonte e Notas de Rodapé
ideb_ai <- 
subset(
	setNames(
		read.xlsx2("Anos Iniciais/IDEB_2015_ANOS_INICIAIS_ESCOLAS.xlsx",1,startRow=8),
		c("sg_uf","cd_municipio","nm_municipio","cd_escola","nm_escola","nm_rede","apv_ai_2005","apv_ai_a1_2005","apv_ai_a2_2005","apv_ai_a3_2005","apv_ai_a4_2005","apv_ai_a5_2005","ind_rend_ai_2005","apv_ai_2007","apv_ai_a1_2007","apv_ai_a2_2007","apv_ai_a3_2007","apv_ai_a4_2007","apv_ai_a5_2007","ind_rend_ai_2007","apv_ai_2009","apv_ai_a1_2009","apv_ai_a2_2009","apv_ai_a3_2009","apv_ai_a4_2009","apv_ai_a5_2009","ind_rend_ai_2009","apv_ai_2011","apv_ai_a1_2011","apv_ai_a2_2011","apv_ai_a3_2011","apv_ai_a4_2011","apv_ai_a5_2011","ind_rend_ai_2011","apv_ai_2013","apv_ai_a1_2013","apv_ai_a2_2013","apv_ai_a3_2013","apv_ai_a4_2013","apv_ai_a5_2013","ind_rend_ai_2013","apv_ai_2015","apv_ai_a1_2015","apv_ai_a2_2015","apv_ai_a3_2015","apv_ai_a4_2015","apv_ai_a5_2015","ind_rend_ai_2015","profic_a5_mat_2005","profic_a5_lp_2005","np_a5_2005","profic_a5_mat_2007","profic_a5_lp_2007","np_a5_2007","profic_a5_mat_2009","profic_a5_lp_2009","np_a5_2009","profic_a5_mat_2011","profic_a5_lp_2011","np_a5_2011","profic_a5_mat_2013","profic_a5_lp_2013","np_a5_2013","profic_a5_mat_2015","profic_a5_lp_2015","np_a5_2015","ideb_ai_2005","ideb_ai_2007","ideb_ai_2009","ideb_ai_2011","ideb_ai_2013","ideb_ai_2015","proj_ai_2007","proj_ai_2009","proj_ai_2011","proj_ai_2013","proj_ai_2015","proj_ai_2017","proj_ai_2019","proj_ai_2021")
		)
	,!sg_uf %like% "Fonte" & !sg_uf %like% "Notas" & !is.na(sg_uf)
	)

# Substitui traços,ND e vazio por NULO
ideb_ai[ideb_ai=="-"] <- NA
ideb_ai[ideb_ai=="ND"] <- NA
ideb_ai[ideb_ai==""] <- NA

# Retira o asterisco das proficiências que não são da Prova Brasil
ideb_ai_melt <- melt(ideb_ai,id.vars=c("sg_uf","cd_municipio","nm_municipio","cd_escola","nm_escola","nm_rede"))
ideb_ai_melt$value <- gsub('\\*','',ideb_ai_melt$value)
ideb_ai <- dcast(ideb_ai_melt,sg_uf+cd_municipio+nm_municipio+cd_escola+nm_escola+nm_rede~variable)

# Cria arquivo CSV para os Anos Iniciais
write.csv2(ideb_ai,"ideb_escola_ai.csv",row.names=F,na="")

# Carrega dados do Ideb por escola para os Anos Finais renomeando o cabeçalho e retirando as linhas de Fonte e Notas de Rodapé
ideb_af <- 
subset(
	setNames(
		read.xlsx2("Anos Finais/IDEB_2015_ANOS_FINAIS_ESCOLAS.xlsx",1,startRow=8),
		c("sg_uf","cd_municipio","nm_municipio","cd_escola","nm_escola","nm_rede","apv_af_2005","apv_af_6a_2005","apv_af_7a_2005","apv_af_8a_2005","apv_af_9a_2005","ind_rend_af_2005","apv_af_2007","apv_af_6a_2007","apv_af_7a_2007","apv_af_8a_2007","apv_af_9a_2007","ind_rend_af_2007","apv_af_2009","apv_af_6a_2009","apv_af_7a_2009","apv_af_8a_2009","apv_af_9a_2009","ind_rend_af_2009","apv_af_2011","apv_af_6a_2011","apv_af_7a_2011","apv_af_8a_2011","apv_af_9a_2011","ind_rend_af_2011","apv_af_2013","apv_af_6a_2013","apv_af_7a_2013","apv_af_8a_2013","apv_af_9a_2013","ind_rend_af_2013","apv_af_2015","apv_af_6a_2015","apv_af_7a_2015","apv_af_8a_2015","apv_af_9a_2015","ind_rend_af_2015","profic_a9_mat_2005","profic_a9_lp_2005","np_a9_2005","profic_a9_mat_2007","profic_a9_lp_2007","np_a9_2007","profic_a9_mat_2009","profic_a9_lp_2009","np_a9_2009","profic_a9_mat_2011","profic_a9_lp_2011","np_a9_2011","profic_a9_mat_2013","profic_a9_lp_2013","np_a9_2013","profic_a9_mat_2015","profic_a9_lp_2015","np_a9_2015","ideb_af_2005","ideb_af_2007","ideb_af_2009","ideb_af_2011","ideb_af_2013","ideb_af_2015","proj_af_2007","proj_af_2009","proj_af_2011","proj_af_2013","proj_af_2015","proj_af_2017","proj_af_2019","proj_af_2021")
		)
	,!sg_uf %like% "Fonte" & !sg_uf %like% "Notas" & !is.na(sg_uf)
	)

# Substitui traços,ND e vazio por NULO
ideb_af[ideb_af=="-"] <- NA
ideb_af[ideb_af=="ND"] <- NA
ideb_af[ideb_af==""] <- NA

# Retira o asterisco das proficiências que não são da Prova Brasil
ideb_af_melt <- melt(ideb_af,id.vars=c("sg_uf","cd_municipio","nm_municipio","cd_escola","nm_escola","nm_rede"))
ideb_af_melt$value <- gsub('\\*','',ideb_af_melt$value)
ideb_af <- dcast(ideb_af_melt,sg_uf+cd_municipio+nm_municipio+cd_escola+nm_escola+nm_rede~variable)

# Cria arquivo CSV para os Anos Finais
write.csv2(ideb_af,"ideb_escola_af.csv",row.names=F,na="")

# Salva arquivo no formato RData para análise com o R
save.image("ideb.RData")

