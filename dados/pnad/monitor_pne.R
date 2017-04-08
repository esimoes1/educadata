# Dados de Monitoramento do PNE 2014-2024

load("pnads.RData")

library(data.table)
library(bit64)

# Empilha os anos e filtra as variáveis usadas no monitoramento do PNE
pnads <- rbind(
  pnad11[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad12[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad13[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad14[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")],
  pnad15[c("UF","V0101","V8005","V3033","V3032","V3031","V4729","V0602","V0606","V0611","V6007","V6003","V0601","V4803")]
)

#
