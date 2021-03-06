Base do ENEM por Escola 2016
========

_Importação e organização dos dados do ENEM por Escola 2016 para uma base RData usando um sistema Linux_

## Conteúdo

- [Downloads](#download)
- [Extração](#extração)
- [Armazenamento](#armazenamento)
- [Produção](#produção)

## Downloads

1. Baixe os microdados do ENEM direto do site do INEP: 

- <a href="http://download.inep.gov.br/microdados/microdados_enem2016.zip" target="_blank">microdados_enem2016.zip</a>

2. Para obter os dados das escolas em 2016, baixe também os microdados do Censo Escolar:

- <a href="http://download.inep.gov.br/microdados/micro_censo_escolar_2016.zip" target="_blank">micro_censo_escolar_2016.zip</a>

3. Por fim, adquira a base de nomes e siglas de UF e municípios brasileiros:
- <a href="https://educadata.com.br/download/uf-e-municipios-brasileiros-ibge-2016/" target="_blank">UF_e_Municipios_Brasileiros_IBGE.csv</a>

## Extração

1. Em um terminal de comandos, execute nosso script para separar apenas os dados dos alunos de alunos concluintes do Ensino Médio:

        unzip -p microdados_enem2016.zip Microdados_enem_2016/DADOS/microdados_enem_2016.csv > microdados_enem_2016.csv
        awk -F';' '{if ($1=="NU_INSCRICAO" || ($21 != "" && $16==2 && $19==1)) print}' microdados_enem_2016.csv | cut -d';' -f2,21,89-92,97-100,110-116 > microdados_enem_2016_escola.csv


2. Do mesmo modo, extraia os dados das escolas e turmas no Censo Escolar:

        unzip -p micro_censo_escolar_2016.zip micro_censo_escolar_2016/DADOS/ESCOLAS.CSV > ESCOLAS.CSV
        awk -F'|' '{if ($1=="NU_ANO_CENSO" || $149==1 || $150==1 || $151==1) print}' ESCOLAS.CSV | cut -d'|' -f2,3,12,14 --output-delimiter=';' > ESCOLAS_enem.csv

        unzip -p micro_censo_escolar_2016.zip micro_censo_escolar_2016/DADOS/TURMAS.CSV > TURMAS.CSV
        awk -F'|' '{if ($1=="NU_ANO_CENSO" || (($13==27 || $13==28 || $13==32 || $13==33 || $13==37 || $13==38) && $9==0)) print}' TURMAS.CSV | cut -d'|' -f3,13,69 --output-delimiter=';' > TURMAS_enem.csv


## Armazenamento

1. Abra o R no mesmo diretório do arquivo CSV e execute o script abaixo:

        enem2016 <- read.csv2("microdados_enem_2016_escola.csv",fileEncoding="Latin1")
        escolas2016 <- read.csv2("ESCOLAS_enem.csv",fileEncoding="Latin1")
        turmas2016 <- read.csv2("TURMAS_enem.csv",fileEncoding="Latin1")
        municipios <- read.csv2("UF_e_Municipios_Brasileiros_IBGE.csv")
        save.image("microdados_enem_2016_escola.RData")

## Produção

Você também pode aprender como produzir o resultado das escolas brasileiras no ENEM 2016 através de nosso tutorial: <a href="https://github.com/professorvirtual/educadata/tree/master/dados/enem/2016">ENEM por Escola 2016</a>
