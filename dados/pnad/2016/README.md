Dados Educacionais do Suplemento de Educação da PNAD Contínua 2016 (IBGE)
========

_Orientações para a produção dos dados educacionais do Suplemento de Educação da PNAD Contínua 2016 (IBGE) por meio do Software R_

## Conteúdo

- [Introdução](#introdução)
- [Base](#base)
- [Dados](#dados)
- [Produção](#produção)

## Introdução

O IBGE produz e publica um conjunto dados educacionais a partir do Suplemento de Educação da PNAD Contínua. Ele pode ser encontrado em dois instrumentos de divulgação do instituto:
- <a href="https://biblioteca.ibge.gov.br/visualizacao/livros/liv101576_informativo.pdf">PNAD Contínua 2016-2017 - Informativo de Educação</a>
- <a href="https://drive.google.com/file/d/1Kc8f5O6_rUT5zlDLSppdyGEKeGxpzApu/view?usp=sharing">Tabela: Suplemento de Educação</a>

Todos os dados aqui produzidos com base em nossas orientações utilizam esses materiais como referência metodológica.

## Base

Nessa produção usamos os dados da Pnad 2016, em formato RData, criado segundo orientações presentes em nosso outro documento <a href="https://github.com/professorvirtual/educadata/tree/master/bases/pnad/2016">Base do Suplemento de Educação da PNAD Contínua 2016 (IBGE)</a>. Caso não queira produzí-la, você pode baixar a base através do link abaixo:
- <a href="https://drive.google.com/file/d/1Roh20NgJ7vWFPNj6qeRW3_ViyyLHHZ_x/view?usp=sharing">pnad2016.RData</a>

## Dados

A produção dos dados deve resultar em um arquivo contendo a maior parte dos dados divulgados pelo IBGE, cujos detalhes podem ser encontrados no artigo: <a href="#">Os dados educacionais da PNAD Contínua publicados pelo IBGE</a>. Os indicadores contemplados serão:
1. População: número de pessoas;
2. Estudantes: número de pessoas que frequentam a escola;
3. Pessoas que não sabem ler e escrever;
4. Taxa de escolarização: percentual de pessoas que frequentam a escola;
5. Taxa ajustada de frequência escolar líquida: percentual de pessoas que frequentam a escola na etapa adequada;
6. Número médio de anos de estudo: valor médio de anos de estudo da população;
7. Taxa de analfabetismo: percentual de pessoas que não sabem ler e escrever.

## Produção

Utilizando o R, especialmente, suas poderosas bibliotecas e funções como "data.table" e "dcast", respectivamente, os passos da produção estão todos inclusos e comentado no script:
- <a href="https://github.com/professorvirtual/educadata/blob/master/dados/pnad/2016/pnad_2016_educacao.R">Pnad_2016_educacao.R</a>

Para executá-lo basta usar o seguinte comando em um terminal linux:

        Rscript Pnad_2016_educacao.R

Caso não queira ou não possa produzí-los, o resultado pode ser conferido no seguinte arquivo CSV:

- <a href="https://drive.google.com/file/d/18BFMNgw-ihH0p8QUKVEIY2Eu3uTJTLUO/view?usp=sharing">PNAD Contínua - Suplemento de Educação 2016</a>
