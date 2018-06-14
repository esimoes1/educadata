Bases da PNAD
========

_Organização e importação dos dados da PNAD para uma base RData usando um sistema Linux_

## Conteúdo

- [Download](#download)
- [Importação](#extracao)

## Download

Baixe os dados de cada ano individualmente: <a href="ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/2016/Suplementos/Dados/PNADC_022016_educacao_20180518.zip" target="_blank">ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/2016/Suplementos/Dados/</a>

## Extração

1. Em um terminal de comandos, descompacte o arquivo baixado e gere o arquivo CSV nosso Shell Script: <a href="https://github.com/professorvirtual/educadata/blob/master/bases/pnad/2016/converte_txt_csv.sh" target="_blank">converte_txt_csv.sh</a>

## Conversão

1. Abra o R e execute o script <a href="https://github.com/professorvirtual/educadata/blob/master/bases/pnad/pnad.R" target="_blank">pnad.R</a>

