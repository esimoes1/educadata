## Enem_por_escola.R - Produz os resultados do ENEM 2017
## Escrito por: George Gomes (Fortaleza - Ceará)
## E-mail: georgegomesf@gmail.com

# Carrega bibliotecas utilizadas ####
library(data.table)
library(plyr)

# Carrega dados ####
load("MICRODADOS_ENEM_2017_escola.RData")

# Sinaliza informações sobre a particpação dos alunos
enem2017[is.na(enem2017$TP_PRESENCA_CH),]$TP_PRESENCA_CH <- 0
enem2017[is.na(enem2017$TP_PRESENCA_CN),]$TP_PRESENCA_CN <- 0
enem2017$fl_inscrito <- 1
enem2017$fl_ausente_dia1 <- ifelse(enem2017$TP_PRESENCA_CH==0,1,0)
enem2017$fl_ausente_dia2 <- ifelse(enem2017$TP_PRESENCA_CN==0,1,0)
enem2017$fl_participante <- ifelse(enem2017$TP_PRESENCA_CN==1 & enem2017$TP_PRESENCA_CH==1,1,0)
enem2017$fl_anulada <- ifelse(enem2017$fl_participante==0 & (enem2017$TP_PRESENCA_CH==2 | enem2017$TP_PRESENCA_CN==2),1,0)

# Produz os dados de participação usados na qualificação das escolas
enem_part <- enem2017
enem_part <- setNames(
  data.frame(dcast(data.table(enem_part),NU_ANO+CO_ESCOLA~"",value.var=c("fl_inscrito","fl_participante","fl_ausente_dia1","fl_ausente_dia2","fl_anulada"),sum)),
  c("nr_ano_enem","id_escola","nr_inscritos","nr_participantes","nr_ausencias_dia1","nr_ausencias_dia2","nr_anuladas")
)
censo_matriculas <- setNames(dcast(subset(turmas2017,!TP_ETAPA_ENSINO %in% c(29,34)),CO_ENTIDADE~"NU_MATRICULAS",value.var="NU_MATRICULAS",sum),c("id_escola","nr_matriculas"))
enem_part <- merge(x=enem_part,censo_matriculas,by="id_escola",all.x=T)
enem_part$pc_participacao_i <- enem_part$nr_participantes/enem_part$nr_inscritos*100
enem_part$pc_participacao_m <- enem_part$nr_participantes/enem_part$nr_matriculas*100

# Sinaliza as escolas válidas
enem_part$fl_valida <- ifelse(
  enem_part$nr_participantes >= 10
  & (
    (enem_part$pc_participacao_i >= 50 & is.na(enem_part$nr_matriculas)) 
    | (enem_part$pc_participacao_m >= 50 & !is.na(enem_part$nr_matriculas) & enem_part$nr_matriculas>=20)
  )
  ,1,0
)

# Calcula as proficiências para as escolas válidas
enem_result <- subset(enem2017,CO_ESCOLA %in% subset(enem_part,fl_valida==1)$id_escola)
enem_result[] <- lapply(lapply(enem_result, as.character),as.numeric)
enem_result <- setNames(
  data.frame(dcast(data.table(enem_result),NU_ANO+CO_ESCOLA~"",value.var=c("NU_NOTA_CN","NU_NOTA_CH","NU_NOTA_LC","NU_NOTA_MT","NU_NOTA_COMP1","NU_NOTA_COMP2","NU_NOTA_COMP3","NU_NOTA_COMP4","NU_NOTA_COMP5","NU_NOTA_REDACAO"),mean,na.rm=T)),
  c("nr_ano_enem","id_escola","nr_media_cn","nr_media_ch","nr_media_lc","nr_media_mt","nr_media_comp_1","nr_media_comp_2","nr_media_comp_3","nr_media_comp_4","nr_media_comp_5","nr_media_redacao")
)	
enem_result$nr_media_areas <- (enem_result$nr_media_cn+enem_result$nr_media_ch+enem_result$nr_media_lc+enem_result$nr_media_mt)/4
enem_result$nr_media_geral <- (enem_result$nr_media_cn+enem_result$nr_media_ch+enem_result$nr_media_lc+enem_result$nr_media_mt+enem_result$nr_media_redacao)/5

# Alnha e organiza os dados das escolas
redes <- data.frame(TP_DEPENDENCIA=c(1,2,3,4),DS_DEPENDENCIA=c("Federal","Estadual","Municipal","Privada"))
escolas2017 <- merge(escolas2017,redes,by="TP_DEPENDENCIA")
escolas2017 <- setNames(escolas2017,c("cd_dependencia","id_escola","nm_escola","id_municipio","ds_dependencia"))

# Alinha organiza dos dados das Regiões, UF e municípios
regioes <- data.frame(id_regiao=c(1,2,3,4,5),nm_regiao=c("Norte","Nordeste","Sudeste","Sul","Centro-Oeste"))
municipios <- setNames(municipios,c("id_uf","nm_uf","sg_uf","id_municipio","nm_municipio"))
municipios$id_regiao <- substring(municipios$id_uf,1,1)
municipios <- merge(municipios,regioes,by="id_regiao")

# Unifica os dados de participação, médias, escolas e municípios
enem_escola <- merge(x=enem_part,enem_result,by=c("nr_ano_enem","id_escola"),all.x=T)
enem_escola <- merge(enem_escola,escolas2017,by="id_escola")
enem_escola <- merge(enem_escola,municipios,by="id_municipio")

# Seleciona apenas os dados das escolas válidas
enem_escola <- 
  subset(
    enem_escola,
    fl_valida==1,
    select=c(
      "nr_ano_enem","id_regiao","nm_regiao","id_uf","sg_uf","id_municipio","nm_municipio","cd_dependencia","ds_dependencia","id_escola","nm_escola","nr_inscritos","nr_participantes","pc_participacao_i",
      "nr_media_cn","nr_media_ch","nr_media_lc","nr_media_mt","nr_media_areas","nr_media_comp_1","nr_media_comp_2","nr_media_comp_3","nr_media_comp_4","nr_media_comp_5","nr_media_redacao"
    )
  )

# Exporta dados para CSV
write.csv2(enem_escola,"enem_por_escola_2017.csv",row.names=F,na="")
