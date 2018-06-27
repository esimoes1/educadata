Base do ENEM por Escola 2017 (INEP)
========

_Importação e organização dos dados do ENEM por Escola 2017 (INEP) para uma base RData usando um sistema Linux_

## Conteúdo

- [Downloads](#download)
- [Extração](#extração)
- [Armazenamento](#armazenamento)
- [Produção](#produção)

## Downloads

Baixe os microdados do ENEM direto do site do INEP: <a href="http://download.inep.gov.br/microdados/microdados_enem2017.zip" target="_blank">microdados_enem2017.zip</a>.

## Extração

1. Em um terminal de comandos, execute nosso script para separar apenas os dados dos alunos de alunos concluintes do Ensino Médio:

        unzip microdados_enem2017.zip -d .
        
        awk -F';' '{if ($1=="NU_INSCRICAO" || ($21 != "" && $16==2 && $19==1)) print}' /DADOS/MICRODADOS_ENEM_2017.csv > /DADOS/MICRODADOS_ENEM_2017_escola.csv
       
2. Abra o software R e use o comando abaixo ou de sua preferência

## Armazenamento

1. Abra o R no mesmo diretório do arquivo CSV e execute o script abaixo:

        enem2017 <- read.csv("MICRODADOS_ENEM_2017_escola.csv",fileEncoding="Latin-1")
        save.image("MICRODADOS_ENEM_2017_escola.RData")

2. Por envolver muitos dados, e caso seu computador tenha pouca memória RAM, esse processo pode demorar bastante e até mesmo travar sua máquina. Assim, considere usar, como opção, a biblioteca <a href="https://www.rdocumentation.org/packages/data.table/" target="_blank">data.table</a>, que tem um desempenho mais econômico usando a função "fread()":

        install.packages(data.table)
        library(data.table)
        pnad2017 <- data.frame(fread("MICRODADOS_ENEM_2017_escola.csv",encoding="Latin-1"))
        save.image("MICRODADOS_ENEM_2017_escola.RData")

## Produção

Você também pode aprender como produzir o resultado das escolas brasileiras no ENEM 2017 através de nosso tutorial: <a href="#">ENEM por Escola 2017</a>