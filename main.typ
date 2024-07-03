#import "anpet-typst.typ": anpet-typst

#show: anpet-typst.with(
  authors: (
    (
      name: "Pedro Augusto Borges dos Santos",
      affiliation: "Observatório Nacional de Segurança Viária",
      email: "pedro.borges@onsv.org.br",
      address: "Estrada Dr. Altino Bondensan, 500 Eugênio de Melo, São José dos Campos - SP"
    ),
    (
      name: "Jorge Tiago Bastos",
      department: "Departamento de Transportes",
      affiliation: "Universidade Federal do Paraná",
      email: "jtbastos@ufpr.br",
    )
  ),
  title: "VELOCIDADES INSEGURAS EM CURITIBA-PR",
  bibliography: bibliography(
    "refs.bib",
    title: text(10pt, [REFERENCIAS BIBLIOGRÁFICAS]),
    style: "apa"
  )
)

= INTRODUÇÃO

O efeito nocivo de altas velocidades na mobilidade segura em ambientes urbanos já vem sendo extensivamente investigado pela literatura. Em cidades, aonde as vítimas mais vulneráveis (pedestres e ciclistas) à esse fator de risco vem sofrendo mortes e lesões graves em colisões com veículos motorizados, vê-se a importância de se repensar os limites de velocidade e garantir o tráfego dos veículos motorizados a uma velocidade segura @nactoCityLimitsSetting2022. A velocidade é um fator central na ocorrência de óbitos no trânsito, influenciando diretamente na gravidade de um sinistro - considerando a energia de impacto - a na chance de ocorrência - afetando negativamente o tempo de reação e a visão periférica do condutor @grspSpeedManagementRoad2023.

#cite(<santosImpactBuiltEnvironment2022>, form: "prose") investigou a autocorrelação espacial do excesso de velocidade em Curitiba-PR e identificou que esse fator de risco não ocorre com mesma intensidade ao longo território da cidade. Inclusive, observou-se uma diferença significativa no nível de renda da população entre zonas de alto e baixo excesso de velocidade, mostrando que regiões com menores níveis de renda estão mais expostas ao fator de risco do excesso de velocidade. Porém, a análise única do excesso de velocidade impossibilita identificar a ocorrência de velocidades inseguras, ou seja, aquelas que mesmo estando abaixo dos limites de velocidade ainda representam uma situação insegura para o cenário urbano. Assim, o objetivo desse trabalho é analisar a incidência de velocidades inseguras em Curitiba-PR. Em adição, busca-se detectar possíveis padrões geográficos dessa incidência no território da cidade e investigar essas ocorrências em diferentes tipos de vias, com base na detecção de agrupamentos espaciais através de técnicas de autocorrelação local.

= METODOLOGIA

A investigação foi realizada com base na amostra do projeto de pesquisa Estudo Naturalístico de Direção Brasileiro (NDS-BR). O NDS-BR inclui um método de coleta de indicadores do desempenho da segurança viária associados à tarefa real de condução por meio da instrumentação dos veículos dos condutores participantes. Nesse contexto, os dados utilizados para o presente estudo foram aqueles de velocidade instantânea juntamente com suas coordenadas, coletados através de um gps em frequência de 1 Hz @bastosESTUDONATURALISTICODIRECAO2023. #footnote[O código-fonte deste trabalho pode ser acessado no seguinte repositório: https://anonymous.4open.science/r/anpet-speeding-AE8D/]

Buscou-se estabelecer a velocidade de 85º percentil (V85) como um indicador de desempenho para a velocidade insegura. Para realizar esse cálculo, os dados de velocidade instantânea foram associados às unidades geográficas do grid espacial H3. O H3 é um sistema de grid hierárquico, criado pelo Uber, que representa a superfície terrestre em hexágonos, e esses hexágonos possuem diferentes resoluções espaciais, conforme a escala necessária @brodskyH3UberHexagonal2018. O grid para a cidade de Curitiba foi disponibilizado pela biblioteca aopdata para a linguagem de programação R @pereiraTD2800Estimativas2022, em que cada hexágono represente uma área de 0.1 km² (resolução 9). Para o cálculo do V85, considerou-se apenas os pontos com velocidade acima de 0 km/h.

Para a detecção de padrões geográficos na incidência do V85, utilizou-se o método de Moran Local. Esse método é  classificado como um indicador local de associação espacial (LISA), que permite o cálculo de uma estatística de autocorrelação espacial para cada local da amostra. A partir deste método, Clusters estatisticamente significativos podem ser classificados como _High-High_  ou  _Low-Low_ (altos e baixos valores de V85, juntamente com hexágonos vizinhos), ou outliers _High-Low_ e _Low-High_ (altos e baixos valores de V85 cercados por hexágonos vizinhos com valores mais baixos ou mais altos) @anselinLocalIndicatorsSpatial2010a. A aplicação do Moran Local neste trabalho foi baseada em uma matriz de pesos espaciais na configuração _Queen contiguity_ de primeira ordem, com auxílio da biblioteca rgeoda para o R @liRgeodaLibrarySpatial2021a. 

= RESULTADOS

NDSBR
- Tempo de viagem da amostra
- Duração e quantidade de viagens
- Características dos condutores
- Características dos veículos


Velocidades
- 85º percentil (mapa)  
- Desvio padrão (mapa)
- Local Moran (mapa)

#figure(
  image("plot/percentil_map.svg"),
  caption: [Velocidade de 85º percentil]
) <fig-percentil> 

#figure(
  image("plot/local_moran_map.svg"),
  caption: [Resultado do Moran Local]
) <fig-moran> 

= CONCLUSÃO

- Velocidades inseguras != excesso de velocidade
- Centro da cidade
- Problema da insegurança nas travessias urbanas
- Conflito hierarquia viária x velocidade