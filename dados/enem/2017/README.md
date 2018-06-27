Resultados do ENEM por Escola 2017
========

_Orientações para a produção dos dados do ENEM por Escola 2017 por meio do Software R_

## Conteúdo

- [Introdução](#introdução)
- [Base](#base)
- [Dados](#dados)
- [Produção](#produção)

## Introdução

O INEP durante alguns anos produziu e disponibilizou os resultados das escolas no ENEM, cuja última referência metodológica está presente nos seguintes documentos:
- <a href="http://download.inep.gov.br//educacao_basica/enem/enem_por_escola/2015/Planilhas_Enem_2015_download.xlsx">Portaria nº 501, de 27 de setembro de 2016 </a>
- <a href="http://download.inep.gov.br/educacao_basica/enem/nota_tecnica/2015/nota_explicativa_enem2015_por_escola.pdf">Nota Explicativa - ENEM por Escola 2015</a>

## Base

Nessa produção usamos os dados da Pnad Contínua 2017, em formato RData, criado segundo orientações presentes em nosso outro documento <a href="https://github.com/professorvirtual/educadata/tree/master/bases/pnad/2017">Base do Suplemento de Educação da PNAD Contínua 2017 (IBGE)</a>. Caso não queira produzí-la, você pode baixar a base através do link abaixo:
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

        Rscript Pnad_2017_educacao.R

