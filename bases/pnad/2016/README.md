Base da PNAD 2016
========

_Organização e importação dos dados da PNAD 2016 para uma base RData usando um sistema Linux_

## Conteúdo

- [Download](#download)
- [Importação](#extracao)

## Download

Baixe os dados: <a href="http://servicodados.ibge.gov.br/Download/Download.ashx?u=ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/2016/Suplementos/Dados/PNADC_022016_educacao_20180518.zip" target="_blank">PNADC_022016_educacao_20180518.zip</a>

## Extração

1. Em um terminal de comandos, execute nosso script para extrair e converter:

## Conversão do arquivo TXT da PNAD 2016 para CSV ####

    unzip PNADC_022016_educacao_20180518.zip -d . 

2. Abra o software R e use o comando abaixo ou de sua preferência

## Conversão

1. Abra o R e execute o script <a href="https://github.com/professorvirtual/educadata/blob/master/bases/pnad/pnad.R" target="_blank">pnad.R</a>

