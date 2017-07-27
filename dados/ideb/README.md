Dados do Índice de Desenvolvimento da Educação Básica - IDEB
========

_Download, extração e organização dos dados em formato CSV_

## Conteúdo

- [Download](#download)
- [Extração e Organização](#extracao)
- [Dados](#dados)

## Download

Todos os arquivos de resultados do IDEB estão disponíveis no site do INEP:
<a href="http://portal.inep.gov.br/web/guest/cenario-educacional" target="_blank">Cenário Educacional</a>

Os arquivos dos resultados por escola podem ser baixados clicando em:

- <a href="http://download.inep.gov.br/educacao_basica/portal_ideb/planilhas_para_download/2015/divulgacao_anos_iniciais_escolas_2015.zip" target="_blank">Anos Iniciais</a>
- <a href="http://download.inep.gov.br/educacao_basica/portal_ideb/planilhas_para_download/2015/divulgacao_anos_finais_escolas_2015.zip" target="_blank">Anos Finais</a>

Você deve baixá-los e descompactá-los em uma mesma pasta.

## Extração e Organização

Realizamos a extração utilizando o software R com o pacote "xlsx", aplicados diretamente nos arquivos em formato XLSX. Baixe e armazene o script <a href="https://github.com/professorvirtual/educadata/blob/master/dados/ideb/ideb.R">ideb.R</a> na mesma pasta dos arquivos "xlsx". Após, é só executar o script "ideb.R" usando o RStudio ou executando o seguinte comando em terminal linux.

Então, execute o o script:

_`Rscript ideb.R`_

Veja também algumas observações importantes:

- Devido ao tamanho dos arquivos ocorre um alto consumo de memória RAM, por isso é bom deixar apenas o R executando no computador;
- Os arquivos possuem formatação visual e, portanto, precisamos retirar as linhas de cabeçalho, linhas com informação e fonte e notas de rodapé (tudo isso via script R mesmo).
- Veja o cabeçalho completo e o significado das variáveis:

Anos Iniciais

- sg_uf = Sigla da Unidade Federada
- cd_municipio = Código do Município
- nm_municipio = Nome do Município
- cd_escola = Código da Escola
- nm_escola = Nome da Escola
- nm_rede = Nome da Rede
- apv_ai_2005 = Média Harmônica das Taxas de Aprovação dos Anos Iniciais em 2005
- apv_ai_a1_2005 = Taxa de Aprovação do 1º ano EF em 2005
- apv_ai_a2_2005 = Taxa de Aprovação do 2º ano EF em 2005
- apv_ai_a3_2005 = Taxa de Aprovação do 3º ano EF em 2005
- apv_ai_a4_2005 = Taxa de Aprovação do 4º ano EF em 2005
- apv_ai_a5_2005 = Taxa de Aprovação do 5º ano EF em 2005
- ind_rend_ai_2005 = Indicador de Rendimento dos Anos Iniciais em 2005
- apv_ai_2007 = Média Harmônica das Taxas de Aprovação dos Anos Iniciais em 2007
- apv_ai_a1_2007 = Taxa de Aprovação do 1º ano EF em 2007
- apv_ai_a2_2007 = Taxa de Aprovação do 2º ano EF em 2007
- apv_ai_a3_2007 = Taxa de Aprovação do 3º ano EF em 2007
- apv_ai_a4_2007 = Taxa de Aprovação do 4º ano EF em 2007
- apv_ai_a5_2007 = Taxa de Aprovação do 5º ano EF em 2007
- ind_rend_ai_2007 = Indicador de Rendimento dos Anos Iniciais em 2007
- apv_ai_2009 = Média Harmônica das Taxas de Aprovação dos Anos Iniciais em 2009
- apv_ai_a1_2009 = Taxa de Aprovação do 1º ano EF em 2009
- apv_ai_a2_2009 = Taxa de Aprovação do 2º ano EF em 2009
- apv_ai_a3_2009 = Taxa de Aprovação do 3º ano EF em 2009
- apv_ai_a4_2009 = Taxa de Aprovação do 4º ano EF em 2009
- apv_ai_a5_2009 = Taxa de Aprovação do 5º ano EF em 2009
- ind_rend_ai_2009 = Indicador de Rendimento dos Anos Iniciais em 2009
- apv_ai_2011 = Média Harmônica das Taxas de Aprovação dos Anos Iniciais em 2011
- apv_ai_a1_2011 = Taxa de Aprovação do 1º ano EF em 2011
- apv_ai_a2_2011 = Taxa de Aprovação do 2º ano EF em 2011
- apv_ai_a3_2011 = Taxa de Aprovação do 3º ano EF em 2011
- apv_ai_a4_2011 = Taxa de Aprovação do 4º ano EF em 2011
- apv_ai_a5_2011 = Taxa de Aprovação do 5º ano EF em 2011
- ind_rend_ai_2011 = Indicador de Rendimento dos Anos Iniciais em 2011
- apv_ai_2013 = Média Harmônica das Taxas de Aprovação dos Anos Iniciais em 2013
- apv_ai_a1_2013 = Taxa de Aprovação do 1º ano EF em 2013
- apv_ai_a2_2013 = Taxa de Aprovação do 2º ano EF em 2013
- apv_ai_a3_2013 = Taxa de Aprovação do 3º ano EF em 2013
- apv_ai_a4_2013 = Taxa de Aprovação do 4º ano EF em 2013
- apv_ai_a5_2013 = Taxa de Aprovação do 5º ano EF em 2013
- ind_rend_ai_2013 = Indicador de Rendimento dos Anos Iniciais em 2013
- apv_ai_2015 = Média Harmônica das Taxas de Aprovação dos Anos Iniciais em 2015
- apv_ai_a1_2015 = Taxa de Aprovação do 1º ano EF em 2015
- apv_ai_a2_2015 = Taxa de Aprovação do 2º ano EF em 2015
- apv_ai_a3_2015 = Taxa de Aprovação do 3º ano EF em 2015
- apv_ai_a4_2015 = Taxa de Aprovação do 4º ano EF em 2015
- apv_ai_a5_2015 = Taxa de Aprovação do 5º ano EF em 2015
- ind_rend_ai_2015 = Indicador de Rendimento em 2015
- profic_a5_mat_2005 = Média de Proficiência do 5º Ano em Matemática em 2005
- profic_a5_lp_2005 = Média de Proficiência do 5º Ano em Língua Portuguesa em 2005
- np_a5_2005 = Indicador de Desempenho (Nota padronizada do 5º Ano) em 2005
- profic_a5_mat_2007 = Média de Proficiência do 5º Ano em Matemática em 2007
- profic_a5_lp_2007 = Média de Proficiência do 5º Ano em Língua Portuguesa em 2007
- np_a5_2007 = Indicador de Desempenho (Nota padronizada do 5º Ano) em 2007
- profic_a5_mat_2009 = Média de Proficiência do 5º Ano em Matemática em 2009
- profic_a5_lp_2009 = Média de Proficiência do 5º Ano em Língua Portuguesa em 2009
- np_a5_2009 = Indicador de Desempenho (Nota padronizada do 5º Ano) em 2009
- profic_a5_mat_2011 = Média de Proficiência do 5º Ano em Matemática em 2011
- profic_a5_lp_2011 = Média de Proficiência do 5º Ano em Língua Portuguesa em 2011
- np_a5_2011 = Indicador de Desempenho (Nota padronizada do 5º Ano) em 2011
- profic_a5_mat_2013 = Média de Proficiência do 5º Ano em Matemática em 2013
- profic_a5_lp_2013 = Média de Proficiência do 5º Ano em Língua Portuguesa em 2013
- np_a5_2013 = Indicador de Desempenho (Nota padronizada do 5º Ano) em 2013
- profic_a5_mat_2015 = Média de Proficiência do 5º Ano em Matemática em 2015
- profic_a5_lp_2015 = Média de Proficiência do 5º Ano em Língua Portuguesa em 2015
- np_a5_2015 = Indicador de Desempenho (Nota padronizada do 5º Ano) em 2015
- ideb_ai_2005 = Resultado Observado do IDEB - Anos Iniciais em 2005
- ideb_ai_2007 = Resultado Observado do IDEB - Anos Iniciais em 2007
- ideb_ai_2009 = Resultado Observado do IDEB - Anos Iniciais em 2009
- ideb_ai_2011 = Resultado Observado do IDEB - Anos Iniciais em 2011
- ideb_ai_2013 = Resultado Observado do IDEB - Anos Iniciais em 2013
- ideb_ai_2015 = Resultado Observado do IDEB - Anos Iniciais em 2015
- proj_ai_2007 = Resultado Projetado do IDEB - Anos Iniciais em 2007
- proj_ai_2009 = Resultado Projetado do IDEB - Anos Iniciais em 2009
- proj_ai_2011 = Resultado Projetado do IDEB - Anos Iniciais em 2011
- proj_ai_2013 = Resultado Projetado do IDEB - Anos Iniciais em 2013
- proj_ai_2015 = Resultado Projetado do IDEB - Anos Iniciais em 2015
- proj_ai_2017 = Resultado Projetado do IDEB - Anos Iniciais em 2017
- proj_ai_2019 = Resultado Projetado do IDEB - Anos Iniciais em 2019
- proj_ai_2021 = Resultado Projetado do IDEB - Anos Iniciais em 2021

Anos Finais

- sg_uf = Sigla da Unidade Federada
- cd_municipio = Código do Município
- nm_municipio = Nome do Município
- cd_escola = Código da Escola
- nm_escola = Nome da Escola
- nm_rede = Nome da Rede
- apv_af_2005 = Média Harmônica das Taxas de Aprovação dos Anos Finais em 2005
- apv_af_a6_2005 = Taxa de Aprovação do 6º ano EF em 2005
- apv_af_a7_2005 = Taxa de Aprovação do 7º ano EF em 2005
- apv_af_a8_2005 = Taxa de Aprovação do 8º ano EF em 2005
- apv_af_a9_2005 = Taxa de Aprovação do 9º ano EF em 2005
- ind_rend_af_2005 = Indicador de Rendimento dos Anos Finais em 2005
- apv_af_2007 = Média Harmônica das Taxas de Aprovação dos Anos Finais em 2007
- apv_af_a6_2007 = Taxa de Aprovação do 6º ano EF em 2007
- apv_af_a7_2007 = Taxa de Aprovação do 7º ano EF em 2007
- apv_af_a8_2007 = Taxa de Aprovação do 8º ano EF em 2007
- apv_af_a9_2007 = Taxa de Aprovação do 9º ano EF em 2007
- ind_rend_af_2007 = Indicador de Rendimento dos Anos Finais em 2007
- apv_af_2009 = Média Harmônica das Taxas de Aprovação dos Anos Finais em 2009
- apv_af_a6_2009 = Taxa de Aprovação do 6º ano EF em 2009
- apv_af_a7_2009 = Taxa de Aprovação do 7º ano EF em 2009
- apv_af_a8_2009 = Taxa de Aprovação do 8º ano EF em 2009
- apv_af_a9_2009 = Taxa de Aprovação do 9º ano EF em 2009
- ind_rend_af_2009 = Indicador de Rendimento dos Anos Finais em 2009
- apv_af_2011 = Média Harmônica das Taxas de Aprovação dos Anos Finais em 2011
- apv_af_a6_2011 = Taxa de Aprovação do 6º ano EF em 2011
- apv_af_a7_2011 = Taxa de Aprovação do 7º ano EF em 2011
- apv_af_a8_2011 = Taxa de Aprovação do 8º ano EF em 2011
- apv_af_a9_2011 = Taxa de Aprovação do 9º ano EF em 2011
- ind_rend_af_2011 = Indicador de Rendimento dos Anos Finais em 2011
- apv_af_2013 = Média Harmônica das Taxas de Aprovação dos Anos Finais em 2013
- apv_af_a6_2013 = Taxa de Aprovação do 6º ano EF em 2013
- apv_af_a7_2013 = Taxa de Aprovação do 7º ano EF em 2013
- apv_af_a8_2013 = Taxa de Aprovação do 8º ano EF em 2013
- apv_af_a9_2013 = Taxa de Aprovação do 9º ano EF em 2013
- ind_rend_af_2013 = Indicador de Rendimento dos Anos Finais em 2013
- apv_af_2015 = Média Harmônica das Taxas de Aprovação dos Anos Finais em 2015
- apv_af_a6_2015 = Taxa de Aprovação do 6º ano EF em 2015
- apv_af_a7_2015 = Taxa de Aprovação do 7º ano EF em 2015
- apv_af_a8_2015 = Taxa de Aprovação do 8º ano EF em 2015
- apv_af_a9_2015 = Taxa de Aprovação do 9º ano EF em 2015
- ind_rend_af_2015 = Indicador de Rendimento em 2015
- profic_a9_mat_2005 = Média de Proficiência do 9º Ano em Matemática em 2005
- profic_a9_lp_2005 = Média de Proficiência do 9º Ano em Língua Portuguesa em 2005
- np_a9_2005 = Indicador de Desempenho (Nota padronizada do 9º Ano) em 2005
- profic_a9_mat_2007 = Média de Proficiência do 9º Ano em Matemática em 2007
- profic_a9_lp_2007 = Média de Proficiência do 9º Ano em Língua Portuguesa em 2007
- np_a9_2007 = Indicador de Desempenho (Nota padronizada do 9º Ano) em 2007
- profic_a9_mat_2009 = Média de Proficiência do 9º Ano em Matemática em 2009
- profic_a9_lp_2009 = Média de Proficiência do 9º Ano em Língua Portuguesa em 2009
- np_a9_2009 = Indicador de Desempenho (Nota padronizada do 9º Ano) em 2009
- profic_a9_mat_2011 = Média de Proficiência do 9º Ano em Matemática em 2011
- profic_a9_lp_2011 = Média de Proficiência do 9º Ano em Língua Portuguesa em 2011
- np_a9_2011 = Indicador de Desempenho (Nota padronizada do 9º Ano) em 2011
- profic_a9_mat_2013 = Média de Proficiência do 9º Ano em Matemática em 2013
- profic_a9_lp_2013 = Média de Proficiência do 9º Ano em Língua Portuguesa em 2013
- np_a9_2013 = Indicador de Desempenho (Nota padronizada do 9º Ano) em 2013
- profic_a9_mat_2015 = Média de Proficiência do 9º Ano em Matemática em 2015
- profic_a9_lp_2015 = Média de Proficiência do 9º Ano em Língua Portuguesa em 2015
- np_a9_2015 = Indicador de Desempenho (Nota padronizada do 9º Ano) em 2015
- ideb_af_2005 = Resultado Observado do IDEB - Anos Finais em 2005
- ideb_af_2007 = Resultado Observado do IDEB - Anos Finais em 2007
- ideb_af_2009 = Resultado Observado do IDEB - Anos Finais em 2009
- ideb_af_2011 = Resultado Observado do IDEB - Anos Finais em 2011
- ideb_af_2013 = Resultado Observado do IDEB - Anos Finais em 2013
- ideb_af_2015 = Resultado Observado do IDEB - Anos Finais em 2015
- proj_af_2007 = Resultado Projetado do IDEB - Anos Finais em 2007
- proj_af_2009 = Resultado Projetado do IDEB - Anos Finais em 2009
- proj_af_2011 = Resultado Projetado do IDEB - Anos Finais em 2011
- proj_af_2013 = Resultado Projetado do IDEB - Anos Finais em 2013
- proj_af_2015 = Resultado Projetado do IDEB - Anos Finais em 2015
- proj_af_2017 = Resultado Projetado do IDEB - Anos Finais em 2017
- proj_af_2019 = Resultado Projetado do IDEB - Anos Finais em 2019
- proj_af_2021 = Resultado Projetado do IDEB - Anos Finais em 2021

## Dados

Os dados estarão nos formatos CSV e RData, sendo este último a forma pela qual os carregamos mais rapidamente usando o software R. 

Caso não possa realizar os procedimentos que orientamos baixe o arquivo com o resultado desse trabalho, disponível em Educadata.org:

- <a href="http://educadata.org/download/ideb-por-escola-em-csv/" target="_blank">Ideb por Escola</a>
