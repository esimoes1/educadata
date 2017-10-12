Bases do Censo Escolar
========

_Extração dos microdados do Censo Escolar 2007-2016 para um banco PostgreSql_

## Conteúdo

- [Download](#download)
- [Recursos](#recursos)
- [Técnicas](#tecnicas)
- [Importação](#importacao)

## Download

Os microdados do Censo Escolar estão disponíveis no site do INEP, e podem ser baixadas de acordo com o ano que você desejar: <a href="http://portal.inep.gov.br/microdados" target="_blank">http://portal.inep.gov.br/microdados</a>. É possível adquirir todos os microdados através do script para Linux (shell-script): <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/baixa_os_microdados.sh" target="_blank">baixa_os_microdados.sh</a>

## Recursos

Utilizaremos em nossas tarefas as seguintes ferramentas:

1. Linux
2. PostgreSql
3. Pentaho Data-Integration (PDI)
4. Editor de textos

## Técnicas

1. Conversão de arquivos RAR para Gzip
2. Criação de base, schema e tabela no PostgreSql
3. Carga de dados através do PDI

## Importação

1. Descompacte todos os arquivos convertendo-os para o formato GZip* usando o seguinte script em um terminal Linux:
<a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/converte_rar_para_gzip.sh" target="_blank">converte_rar_para_gzip.sh</a>

Como a soma de todos os microdados ocupariam mais de 100 GB totalmente descompactados isso irá poupar espaço no disco pois permitirá que você mantenha os arquivos para realizaço de cargas parciais. Após a conversão os arquivos ocuparão em torno de 13GB, mas seu formato Gzip permitirá realizar cargas via PDI a qualquer momento.

2. Crie o schema "censo_escolar" no PostgreSql com o seguinte script SQL:

    _`create schema "censo_escolar";`_

3. Crie todas as tabelas necessárias usando os script SQL abaixo:

* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_matricula.sql" target="_blank">tb_matricula.sql</a>
* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_turma.sql" target="_blank">tb_turma.sql</a>
* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_docente.sql" target="_blank">tb_docente.sql</a>
* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_escola.sql" target="_blank">tb_escola.sql</a>

4. Abra os arquivos KTR (feitos em XML) em um editor de textos puro, ajustando as definições de paste com o algum comando de localizar e substituir do seu editor. Veja um exemplo de linha a serem substituída:

        <filename>/caminho_da_pasta/2016/DADOS/MATRICULA_NORDESTE.CSV.gz</filename>

5. Abra os arquivos KTR via PDI e, antes de executar as cargas na base, atualize as configuraçes de conexo com o banco de dados clicando na conexão "nome_da_conexão" no painel esquerdo, definindo as opções necessárias de seu banco e compartilhando (share) caso ela ainda não esteja.

* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_matricula.ktr" target="_blank">tb_matricula.ktr</a>
* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_turma.ktr" target="_blank">tb_turma.ktr</a>
* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_docente.ktr" target="_blank">tb_docente.ktr</a>
* <a href="https://github.com/professorvirtual/educadata/blob/master/bases/censo_escolar/tb_escola.ktr" target="_blank">tb_escola.ktr</a>
