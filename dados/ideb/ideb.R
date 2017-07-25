# Dados do Índice de Desenvolvimento da Educação - IDEB
# Fonte: INEP/Ideb
# Elaboração: Educadata - http://educadata.org

# Expande a quantidade máxima de memória dinâmica da máquina virtual Java
options(java.parameters = "-Xmx8000m")

# Carrega bibliotecas
library(xlsx)

# Carrega dados do Ideb por escola para os Anos Iniciais renomeando o cabeçalho e retirando as linhas de Fonte e Notas de Rodapé
ideb_ai <- 
subset(
	setNames(
		read.xlsx2("Anos Iniciais/IDEB_2015_ANOS_INICIAIS_ESCOLAS.xlsx",1,startRow=8),
		c("sg_uf","cd_municipio","nm_municipio","cd_escola","nm_escola","nm_rede","ai_2005","ai_1a_2005","ai_2a_2005","ai_3a_2005","ai_4a_2005","ai_5a_2005","ind_rend_2005","ai_2007","ai_1a_2007","ai_2a_2007","ai_3a_2007","ai_4a_2007","ai_5a_2007","ind_rend_2007","ai_2009","ai_1a_2009","ai_2a_2009","ai_3a_2009","ai_4a_2009","ai_5a_2009","ind_rend_2009","ai_2011","ai_1a_2011","ai_2a_2011","ai_3a_2011","ai_4a_2011","ai_5a_2011","ind_rend_2011","ai_2013","ai_1a_2013","ai_2a_2013","ai_3a_2013","ai_4a_2013","ai_5a_2013","ind_rend_2013","ai_2015","ai_1a_2015","ai_2a_2015","ai_3a_2015","ai_4a_2015","ai_5a_2015","ind_rend_2015","mat_2005","lp_2005","np_2005","mat_2007","lp_2007","np_2007","mat_2009","lp_2009","np_2009","mat_2011","lp_2011","np_2011","mat_2013","lp_2013","np_2013","mat_2015","lp_2015","np_2015","ideb_2005","ideb_2007","ideb_2009","ideb_2011","ideb_2013","ideb_2015","proj_2007","proj_2009","proj_2011","proj_2013","proj_2015","proj_2017","proj_2019","proj_2021")
		)
	,!sg_uf %like% "Fonte" & !sg_uf %like% "Notas" & !is.na(sg_uf)
	)

# Substitui traços por NULO
ideb_ai[ideb_ai=="-"] <- NA

# Cria arquivo CSV para os Anos Iniciais
write.csv2(ideb_ai,"ideb_ai.csv",row.names=F,na="")

# Carrega dados do Ideb por escola para os Anos Finais renomeando o cabeçalho e retirando as linhas de Fonte e Notas de Rodapé
ideb_af <- 
subset(
	setNames(
		read.xlsx2("Anos Finais/IDEB_2015_ANOS_FINAIS_ESCOLAS.xlsx",1,startRow=8),
		c("sg_uf","cd_municipio","nm_municipio","cd_escola","nm_escola","nm_rede","af_2005","af_6a_2005","af_7a_2005","af_8a_2005","af_9a_2005","ind_rend_2005","af_2007","af_6a_2007","af_7a_2007","af_8a_2007","af_9a_2007","ind_rend_2007","af_2009","af_6a_2009","af_7a_2009","af_8a_2009","af_9a_2009","ind_rend_2009","af_2011","af_6a_2011","af_7a_2011","af_8a_2011","af_9a_2011","ind_rend_2011","af_2013","af_6a_2013","af_7a_2013","af_8a_2013","af_9a_2013","ind_rend_2013","af_2015","af_6a_2015","af_7a_2015","af_8a_2015","af_9a_2015","ind_rend_2015","mat_2005","lp_2005","np_2005","mat_2007","lp_2007","np_2007","mat_2009","lp_2009","np_2009","mat_2011","lp_2011","np_2011","mat_2013","lp_2013","np_2013","mat_2015","lp_2015","np_2015","ideb_2005","ideb_2007","ideb_2009","ideb_2011","ideb_2013","ideb_2015","proj_2007","proj_2009","proj_2011","proj_2013","proj_2015","proj_2017","proj_2019","proj_2021")
		)
	,!sg_uf %like% "Fonte" & !sg_uf %like% "Notas" & !is.na(sg_uf)
	)

# Substitui traços por NULO
ideb_af[ideb_af=="-"] <- NA

# Cria arquivo CSV para os Anos Finais
write.csv2(ideb_af,"ideb_af.csv",row.names=F,na="")

# Salva arquivo no formato RData para análise com o R
save.image("ideb.RData")
