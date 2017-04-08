# Dados de Monitoramento do PNE 2014-2024

# Carrega dados originais da PNAD
load("../../bases/pnad/pnads.RData")

# Empilha os anos e seleciona apenas as variáveis usadas no monitoramento do PNE
pnads <- rbind(
  pnad11[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad12[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad13[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad14[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad15[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")]
)

# Seleciona apenas os sujeitos que possuem data de nascimento e converte colunas em variáveis isoladas (anexa o dataframe)
attach(subset(pnads, V3032 %in% c(1:12)))

pnad$idade_cne <- calcIdade(paste(
  V3033, sprintf("%02d",V3032), V3031, sep="-"),
  paste(substr(V0101,1,4),"-03-31",sep=""))

# Desfaz o isolamento
detach()



