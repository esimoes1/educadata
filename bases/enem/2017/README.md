Base do ENEM por Escola 2017
========

_Importação e organização dos dados do ENEM por Escola 2017 para uma base RData usando um sistema Linux_

## Conteúdo

- [Downloads](#download)
- [Extração](#extração)
- [Armazenamento](#armazenamento)
- [Produção](#produção)

## Downloads

1. Baixe os microdados do ENEM direto do site do INEP: 

- <a href="http://download.inep.gov.br/microdados/microdados_enem2017.zip" target="_blank">microdados_enem2017.zip</a>

2. Para obter os dados das escolas em 2017, baixe também os microdados do Censo Escolar:

- <a href="http://download.inep.gov.br/microdados/micro_censo_escolar_2017.zip" target="_blank">micro_censo_escolar_2017.zip</a>

3. Por fim, adquira a base de nomes e siglas de UF e municípios brasileiros:
- <a href="https://educadata.com.br/download/uf-e-municipios-brasileiros-ibge-2016/" target="_blank">UF_e_Municipios_Brasileiros_IBGE.csv</a>

## Extração

1. Em um terminal de comandos, execute nosso script para separar apenas os dados dos alunos de alunos concluintes do Ensino Médio:

        unzip microdados_enem2017.zip -d .
        
        awk -F';' '{if ($1=="NU_INSCRICAO" || ($21 != "" && $16==2 && $19==1)) print}' DADOS/MICRODADOS_ENEM_2017.csv | cut -d';' -f2,21,83-86,91-94,104-110  > MICRODADOS_ENEM_2017_escola.csv

2. Do mesmo modo, extraia os dados das escolas no Censo Escolar:

        unzip -p micro_censo_escolar_2017.zip Microdados_Censo_Escolar_2017/DADOS/ESCOLAS.zip > ESCOLAS.zip
        unzip ESCOLAS.zip -d .
        awk -F'|' '{if ($1=="NU_ANO_CENSO" || $149==1 || $150==1 || $151==1) print}' ESCOLAS.CSV | cut -d'|' -f2,3,11,12,14 --output-delimiter=';' > ESCOLAS_enem.csv

## Armazenamento

1. Abra o R no mesmo diretório do arquivo CSV e execute o script abaixo:

        enem2017 <- read.csv2("MICRODADOS_ENEM_2017_escola.csv",fileEncoding="Latin1")
        escolas2017 <- read.csv2("ESCOLAS_enem.csv",fileEncoding="Latin1")
        municipios2017 <- read.csv2("UF_e_Municipios_Brasileiros_IBGE.csv")
        save.image("MICRODADOS_ENEM_2017_escola.RData")

## Produção

Você também pode aprender como produzir o resultado das escolas brasileiras no ENEM 2017 através de nosso tutorial: <a href="#">ENEM por Escola 2017</a>
