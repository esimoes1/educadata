Bases da PNAD
========

_Organização e importação dos dados da PNAD para uma estrutura R_

## Conteúdo

- [Download](#download)
- [Importação](#importacao)

## Download

Baixe os dados de cada ano individualmente: ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_anual/microdados/

## Importação

1. Insira os arquivos de PESSOAS em TXT dentro desta pasta.
2. Em computadores Linux, use o terminal para dar permissão de execução ao arquivo <a href="https://github.com/professorvirtual/educadata/blob/master/bases/pnad/pnad.sh">pnad.sh</a> com o seguinte comando:

    `chmod +x pnad.sh`

3. Abra o R e execute o script <a href="https://github.com/professorvirtual/educadata/blob/master/bases/pnad/pnad.R">pnad.R</a>
