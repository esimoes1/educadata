Resultados do ENEM por Escola 2017
========

_Orientações para a produção dos dados do ENEM por Escola 2017 por meio do Software R_

## Conteúdo

- [Introdução](#introdução)
- [Base](#base)
- [Dados](#dados)
- [Produção](#produção)

## Introdução

Desde 2016, o INEP não publica mais os resultados das escolas no ENEM. Com isso, ele também deixou de realizar a verificação de consistência com o Censo Escolar, procedimento que qualificava as informações declaradas no ato da inscrição. Porém, considerando que os dados são de alta relevância para as escolas, para os técnicos educacionais e para os representantes do poder público na área de educação, decidimos disponibilizar a metodologia de produção dos resultados dos alunos concluintes do Ensino Médio, para as dimensões Brasil, unidades federadas, municípios e escolas. Procuramos, naquilo que foi possível, seguir as recomendações metodológicas abaixo, publicadas pelo INEP:

- <a href="http://download.inep.gov.br//educacao_basica/enem/enem_por_escola/2015/Planilhas_Enem_2015_download.xlsx">Portaria nº 501, de 27 de setembro de 2016 </a>
- <a href="http://download.inep.gov.br/educacao_basica/enem/nota_tecnica/2015/nota_explicativa_enem2015_por_escola.pdf">Nota Explicativa - ENEM por Escola 2015</a>

## Base

Nessa produção usamos os microdados do ENEM 2017, em formato RData, criado segundo orientações presentes em nosso outro documento <a href="https://github.com/professorvirtual/educadata/tree/master/bases/enem/2017">Base do ENEM por Escola 2017</a>. Caso não queira produzí-la, você pode baixar a base através dos links abaixo:
- <a href="https://educadata.com.br/download/microdados-do-enem-2017-enem-por-escola-base-em-csv/">MICRODADOS_ENEM_2017_escola.zip</a>
- <a href="https://educadata.com.br/download/microdados-do-enem-2017-enem-por-escola-base-em-rdata/">MICRODADOS_ENEM_2017_escola.RData</a>

## Dados

A produção dos dados deve resultar em um arquivo contendo os percentuais de participação, as médias de proficiência por área, as médias de redação e de suas competências, agregados por Brasil, UF, municípios e escolas, bem como por seu recorte quanto a dependência administrativa. As referências metodológicas dessa produção podem ser encontradas no artigo: <a href="#">Resultados do ENEM 2017</a>.

## Produção

Os passos da produção estão todos inclusos e comentado no script abaixo, feito em linguagem R:
- <a href="#https://github.com/professorvirtual/educadata/blob/master/dados/enem/2017/enem_por escola_2017.R">Enem_por_escola_2017.R</a>

Para executá-lo basta usar o seguinte comando em um terminal linux:

        Rscript Enem_por_escola_2017.R


