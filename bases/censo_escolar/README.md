Bases do Censo Escolar
========

_Importação e organizaço dos microdados do Censo Escolar 2007-2016 em um banco PostgreSql

## Conteúdo

- [Download](#download)
- [Recursos](#recursos)
- [Técnicas](#tecnicas)
- [Importação](#importacao)

## Download

Os microdados do Censo Escolar estão disponíveis no site do INEP, e podem ser baixadas de acordo com o ano que você desejar: <a href="http://portal.inep.gov.br/microdados" target="_blank">http://portal.inep.gov.br/microdados</a>

## Recursos

Utilizaremos em nossas tarefas as seguintes ferramentas:

1. Linux
2. PostgreSql
3. Pentaho Data-Integration (PDI)

## Técnicas

1. Converso de arquivos RAR para Gzip
2. Criação de base, schema e tabela no Psotgres
3. Carga de dados através do PDI

## Importação

1. Descompacte todos os arquivos convertendo-os para o formato GZip* usando o seguinte script:
<a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/converte_rar_para_gzip.sh" target="_blank">converte_rar_para_gzip.sh</a>

* Como a soma de todos os microdados ocupariam mais 100 GB totalmente descompactados isso irá poupar espaço no disco pois permitirá que você mantenha os arquivos para realizaço de cargas parciais. Após a conversão os arquivos ocuparão em torno de 13GB, mas seu formato Gzip permitirá realizar cargas via PDI a qualquer momento.
