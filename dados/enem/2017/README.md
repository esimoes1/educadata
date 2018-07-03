Resultados do ENEM por Escola 2017
========

_Orientações para a produção dos dados do ENEM por Escola 2017 por meio do Software R_

## Conteúdo

- [Introdução](#introdução)
- [Base](#base)
- [Dados](#dados)
- [Produção](#produção)

## Introdução

Desde 2016, o INEP não publica mais os resultados das escolas no ENEM. Com isso, ele também deixou de realizar a verificação de consistência com o Censo Escolar, procedimento que qualificava as informações declaradas no ato da inscrição. Porém, considerando que os dados são de alta relevância para as escolas, para os técnicos educacionais e para os representantes do poder público na área de educação, decidimos disponibilizar a metodologia de produção dos resultados dos alunos concluintes do Ensino Médio regular por escola. Procuramos, naquilo que foi possível, seguir as recomendações metodológicas abaixo, publicadas pelo INEP, com algumas adaptações:

- <a href="http://download.inep.gov.br/educacao_basica/enem/legislacao/2016/portaria_n501_27092016_enem_por_escola_2015.pdf">Portaria nº 501, de 27 de setembro de 2016 </a>
- <a href="http://download.inep.gov.br/educacao_basica/enem/nota_tecnica/2015/nota_explicativa_enem2015_por_escola.pdf">Nota Explicativa - ENEM por Escola 2015</a>

As principais mudanças foram:

- A participação mínima de 50% dos alunos matriculados em turmas conclusivas do ensino médio regular, aplicou-se somente às escolas compostas exclusivamente de turmas seriadas;
- Passou-se a exigir dessas escolas o mínimo de 20 alunos matriculados em turmas conclusivas;
- Escolas com matrículas em turmas não-seriadas do ensino médio regular deviam ter participação mínima de 50% dos alunos inscritos;
- Substitui-se, na divulgação da relação, o percentual de participação de alunos em turmas conclusivas, pelo percentual de participação de alunos inscritos.

## Base

Nessa produção usamos os microdados do ENEM 2017, em formato RData, criado segundo orientações presentes em nosso outro documento <a href="https://github.com/professorvirtual/educadata/tree/master/bases/enem/2017">Base do ENEM por Escola 2017</a>. Caso não queira produzí-la, você pode baixá-la através das opções abaixo:
- <a href="https://educadata.com.br/download/microdados-do-enem-2017-enem-por-escola-base-em-csv/">MICRODADOS_ENEM_2017_escola.zip</a>
- <a href="https://educadata.com.br/download/microdados-do-enem-2017-enem-por-escola-base-em-rdata/">MICRODADOS_ENEM_2017_escola.RData</a>

## Dados

Essa produção deve resultado em um arquivo contendo os seguintes dados agregados por escola:
- número de inscritos
- número de participantes
- percentuais de participação em relação aos inscritos
- médias de proficiência por área
- médias de redação e de suas competências

## Produção

Os passos da produção estão inclusos e comentados no script abaixo, feito em linguagem R:
- <a href="https://github.com/professorvirtual/educadata/blob/master/dados/enem/2017/enem_por_escola_2017.R">enem_por_escola_2017.R</a>

Para executá-lo, basta usar o seguinte comando em um terminal linux:

        Rscript enem_por_escola_2017.R

Caso deseje adquirir os dados faça o download através do link abaixo:

- <a href="http://educadata.org/download/enem-por-escola-2017-educadata/">Enem por Escola 2017 - Educadata</a>

