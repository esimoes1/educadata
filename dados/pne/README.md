Dados de Monitoramento do PNE usando a PNAD Contínua
========

_Orientações para a produção dos dados educacionais do Suplemento de Educação da PNAD Contínua 2017 (IBGE) por meio do Software R_

## Conteúdo

- [Introdução](#introdução)
- [Base](#base)
- [Dados](#dados)
- [Produção](#produção)

## Introdução

Os dados de monitoramento do PNE são, oficialmente, produzidos pelo INEP e, junto com gráficos e análises sobre o tema, estão expressos nos seguinte sdocumentos:
- <a href="http://portal.inep.gov.br/documents/186968/485745/Plano+Nacional+de+Educa%C3%A7%C3%A3o+PNE+2014-2024++Linha+de+Base/c2dd0faa-7227-40ee-a520-12c6fc77700f?version=1.1">Plano Nacional de Educação: Linha de Base;</a>
- <a href="http://download.inep.gov.br/outras_acoes/estudos_pne/2016/relatorio_pne_2014_a_2016.pdf">Relatório do 1º Ciclo de Monitoramento das Metas do PNE;</a>
- <a href="http://portal.inep.gov.br/documents/186968/485745/RELAT%C3%93RIO+DO+2o.+CICLO+DE+MONITORAMENTO+DAS+METAS+DO+PNE+-+2018/9a039877-34a5-4e6a-bcfd-ce93936d7e60?version=1.2&amp;download=true">Relatório do 2º Ciclo de Monitoramento das Metas do PNE.</a>

Todos os dados aqui produzidos utilizam esses materiais como referência metodológica.

## Base

Nessa produção usamos os dados da Pnad 2017, em formato RData, criado segundo orientações presentes em nosso outro documento <a href="https://github.com/professorvirtual/educadata/tree/master/bases/pnad/2017">Base do Suplemento de Educação da PNAD Contínua 2016 (IBGE)</a>. Caso não queira produzí-la, você pode baixar a base através do link abaixo:
- <a href="https://educadata.com.br/download/pnad-continua-2017-educacao-base-completa-em-rdata/">PNADC_022017_educacao.RData</a>

## Dados

A produção dos dados deve resultar em um arquivo contendo a maior parte dos dados divulgados pelo IBGE, cujas referências metodológicas podem ser encontradas no artigo: <a href="https://educadata.com.br/os-dados-educacionais-da-pnad-continua-publicados-pelo-ibge/">Os dados educacionais do IBGE</a>. Os indicadores contemplados serão:
1. População: número de pessoas;
2. Estudantes: número de pessoas que frequentam a escola;
3. Pessoas que não sabem ler e escrever;
4. Taxa de escolarização: percentual de pessoas que frequentam a escola;
5. Taxa ajustada de frequência escolar líquida: percentual de pessoas que frequentam a escola na etapa adequada;
6. Número médio de anos de estudo: valor médio de anos de estudo da população;
7. Taxa de analfabetismo: percentual de pessoas que não sabem ler e escrever.

## Produção

Os passos da produção estão todos inclusos e comentado no script abaixo, feito em linguagem R:
- <a href="https://github.com/professorvirtual/educadata/blob/master/dados/pnad/2017/pnad_2017_educacao.R">Pnad_2017_educacao.R</a>

Para executá-lo basta usar o seguinte comando em um terminal linux:

        Rscript Pnad_2016_educacao.R


