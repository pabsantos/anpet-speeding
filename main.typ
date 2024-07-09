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
      address: " Avenida Coronel Francisco Heráclito dos Santos, 100 Campus III, Bloco V, Curitiba - PR"
    )
  ),
  title: "VELOCIDADES INSEGURAS EM CURITIBA-PR",
  bibliography: bibliography(
    "refs.bib",
    title: text(10pt, [REFERENCIAS BIBLIOGRÁFICAS]),
    style: "apa"
  ),
  agradecimentos: "Os autores agradecem ao Conselho Nacional de Desenvolvimento Científico e Tecnológico (CNPq), à Universidade Federal do Paraná e ao Observatório Nacional de Segurança Viária.",

  resumo: "O trabalho tem como objetivo analisar a incidência de velocidades inseguras em Curitiba, Paraná, investigando a existência de um padrão espacial deste fenômeno e sua incidência conforme diferentes hierarquias das vias. Com dados naturalísticos de velocidade instantânea e as coordenadas geográficas, foram calculadas velocidades de 85º percentil (V85), utilizada como indicador de velocidade insegura. Como unidade espacial de base para o cálculo, utilizou-se os hexágonos do grid H3. O Moran Local foi utilizado para identificar padrões geográficos da velocidade. A análise revela que áreas centrais de Curitiba apresentam menores valores de V85, enquanto regiões periféricas e próximas de rodovias mostram maiores valores, explicitando a problemática das travessias urbanas. A investigação destaca que vias locais e coletoras apresentam V85 incompatíveis com suas funções e características.",

  abstract: "The objective of this study is to analyze the incidence of unsafe speeds in Curitiba, Brazil, investigating the existence of a spatial pattern of this phenomenon and its occurrence according to different road hierarchies. Using naturalistic data of instantaneous speed and geographic coordinates, 85th percentile speeds (V85) were calculated, used as an indicator of unsafe speed. Hexagons from the H3 grid were used as the spatial unit for the calculation. Local Moran was used to identify geographic patterns of speed. The analysis reveals that central areas of Curitiba have lower V85 values, while peripheral areas and regions near highways show higher values, highlighting the issue of urban crossings. The investigation emphasizes that local and collector roads have V85 values incompatible with their functions and characteristics."
)

// Variáveis ------------------

// Drivers 

#let trips_total = "1.443"
#let dist_total = "10.065,95"
#let horas_total = "505,05"

#let dist_filtrado = "9.941,53"
#let horas_filtrado = "436,06"

#let days_driver_max = "17"
#let days_driver_min = "2"

#let drivers_mulher = "20"
#let drivers_idade_min = "20"
#let drivers_idade_max = "62"
#let app_drivers = "4"
#let drivers_license_max = "40"
#let drivers_license_min = "4"

// Grid H3

#let total_grid = "4.466"
#let sample_grid = "2.472"

#let grid_20 = "88%"
#let grid_20_60 = "9%"
#let grid_60 = "3%"

// Velocidades e Local Moran

#let hex_high_high = "243"
#let hex_low_low = "255"
#let hex_high_low = "36"
#let hex_low_high = "37"

// Eixos

// ----------------------------

= INTRODUÇÃO

O efeito negativo de altas velocidades na mobilidade segura em ambientes urbanos já vem sendo extensivamente investigado pela literatura, tendo em vista que a velocidade influencia no risco e na severidade de sinistros. Em cidades, aonde os usuários mais vulneráveis (pedestres e ciclistas) a esse fator de risco vem sendo mortos ou feridos em impactos com veículos motorizados, vê-se a importância de se repensar os limites de velocidade e garantir o tráfego dos veículos motorizados a uma velocidade segura @nactoCityLimitsSetting2022. A velocidade é um fator central na ocorrência de óbitos no trânsito, influenciando diretamente na gravidade de um sinistro - considerando a energia de impacto - a na chance de ocorrência - afetando negativamente o tempo de reação e a visão periférica do condutor @grspSpeedManagementRoad2023.

#cite(<santosImpactBuiltEnvironment2022>, form: "prose") investigou a autocorrelação espacial do excesso de velocidade em Curitiba-PR e identificou que esse fator de risco não ocorre com mesma intensidade ao longo território da cidade. Inclusive, observou-se uma diferença significativa no nível de renda da população entre zonas de alto e baixo excesso de velocidade, mostrando que regiões com menores níveis de renda estão mais expostas ao fator de risco do excesso de velocidade. Porém, a análise única do excesso de velocidade impossibilita identificar a ocorrência de velocidades inseguras, ou seja, aquelas que mesmo estando abaixo dos limites de velocidade ainda representam uma situação insegura para o cenário urbano. Assim, o objetivo desse trabalho é analisar a incidência de velocidades inseguras em Curitiba-PR. Em adição, busca-se detectar possíveis padrões geográficos dessa incidência no território da cidade e investigar essas ocorrências em diferentes tipos de vias, com base na detecção de agrupamentos espaciais através de técnicas de autocorrelação local.

= METODOLOGIA

O conceito de velocidade insegura adotada neste trabalho baseou-se nas considerações de #cite(<nactoCityLimitsSetting2022>, form: "prose"), que recomenda limites de velocidade entre 15 km/h e 40 km/h em ambientes urbanos. Limites de 50 km/h e 60 km/h podem ser recomendados em situações específicas - em vias que atendam condições de mobilidade segura para os usuários mais vulneráveis. Assim, para essa pesquisa, velocidades inseguras são aquelas acima de 40 km/h, independente dos limites estabelecidos na cidade de Curitiba. 

A investigação foi realizada com base na amostra do projeto de pesquisa Estudo Naturalístico de Direção Brasileiro (NDS-BR). O NDS-BR inclui um método de coleta de indicadores do desempenho da segurança viária associados à tarefa real de condução por meio da instrumentação dos veículos dos condutores participantes. Nesse contexto, os dados utilizados para o presente estudo foram aqueles de velocidade instantânea juntamente com suas coordenadas, coletados através de um receptor _GPS_ em frequência de 1 Hz @bastosESTUDONATURALISTICODIRECAO2023.

Buscou-se estabelecer a velocidade de 85º percentil (V85) como um indicador de desempenho para a velocidade insegura. Para realizar esse cálculo, os dados de velocidade instantânea foram associados às unidades geográficas do grid espacial H3. O H3 é um sistema de grid hierárquico, criado pela empresa Uber, que representa a superfície terrestre em hexágonos, e esses hexágonos possuem diferentes resoluções espaciais, conforme a escala necessária @brodskyH3UberHexagonal2018. O grid para a cidade de Curitiba foi disponibilizado pela biblioteca `aopdata` para a linguagem de programação R @pereiraTD2800Estimativas2022, em que cada hexágono representa uma área de 0,1 km² (resolução 9). Para o cálculo do V85, considerou-se apenas os pontos com velocidade acima de 0 km/h. A junção espacial dos dados do NDS-BR com os hexágonos do H3 foi elaborada com auxílio da biblioteca `sf` no R @pebesmaSimpleFeaturesStandardized2018.

Para a detecção de padrões geográficos na incidência do V85, utilizou-se o método de Moran Local. Esse método é  classificado como um indicador local de associação espacial (LISA), que permite o cálculo de uma estatística de autocorrelação espacial para cada local da amostra. A partir deste método, _clusters_ estatisticamente significativos podem ser classificados como _High-High_  ou  _Low-Low_ (altos e baixos valores de V85, juntamente com hexágonos vizinhos), ou _outliers_ _High-Low_ e _Low-High_ (altos e baixos valores de V85 cercados por hexágonos vizinhos com valores mais baixos ou mais altos) @anselinLocalIndicatorsSpatial2010a. A aplicação do Moran Local neste trabalho foi baseada em uma matriz de pesos espaciais na configuração _Queen contiguity_ de primeira ordem, com auxílio da biblioteca `rgeoda` para o R @liRgeodaLibrarySpatial2021a.

A identificação da velocidade insegura de acordo com a hierarquia das vias foi realizada com base nos dados geográficos de eixos de vias disponibilizados pelo Instituto de Pesquisa e Planejamento Urbano de Curitiba @eixo_rua_sirgas.

= RESULTADOS

No total, a amostra do NDS-BR utilizada nesse trabalho apresentou uma quantidade de 40 condutores, que realizaram #trips_total viagens entre 2019 e 2023. Isso totalizou uma quantidade de #horas_total horas de condução e uma distância de #dist_total quilômetros percorridos. Filtrando os pontos com velocidade acima de 0 km/h, essa amostra foi reduzida para #horas_filtrado horas de condução e uma distância de #dist_filtrado quilômetros percorridos. Em relação aos condutores, houve uma distribuição exata entre participantes do sexo masculino e feminino, com idades variando entre #drivers_idade_min e #drivers_idade_max anos. Quatro condutores exerciam atividade remunerada em seus veículos. O tempo de habilitação dos participantes variou entre #drivers_license_min e #drivers_license_max anos.

O território de Curitiba é representado no grid H3 com base em #total_grid hexágonos da resolução 9 (0.1 km²). Porém, a amostra do NDS-BR não foi suficiente para cobrir todo o território da cidade. Assim, utilizou-se uma amostra de #sample_grid hexágonos com dados do NDS-BR. Em relação a distribuição da amostra, #grid_20 dos hexágonos apresentaram um tempo de viagem de até 20 minutos, #grid_20_60 um tempo de viagem entre 20 e 60 minutos e #grid_60 um tempo de viagem superior a 60 minutos.

A @fig-v85-moran apresenta os resultados do V85 e os resultados do Moran Local com base no indicador. Observa-se menores valores de V85 na região central da cidade (Clusters _Low-Low_) e maiores valores de V85 nas regiões mais afastadas, coincidindo com a localização do contorno rodoviário da BR-277 que passa pelo território de Curitiba (Clusters _High-High_). Outros outliers espaciais, principalmente os _High-Low_, podem ser observados de forma mais espalhada no território. Grande parte dos hexágonos apresentou um V85 entre 30 e 40 km/h ou entre 40 e 50 km/h. No total, #hex_high_high hexágonos foram classificados como _High-High_ e #hex_low_low hexágonos foram classificados como _Low-Low_. Considerando os outliers, #hex_high_low hexágonos foram classificados como _High-Low_ e #hex_low_high hexágonos foram classificados como _Low-High_.

#figure(
  image("plot/plot-v85-moran.png"),
  caption: [Velocidade de 85º percentil e Moran Local]
) <fig-v85-moran>

Com a velocidade insegura mapeada em Curitiba e seu padrão espacial identificado com o Moran Local, foi possível identificar a incidência das velocidades inseguras conforme a hierarquia das vias englobadas pelos hexágonos identificados como _High-High_ e _High-Low_. A @tbl-dist apresenta os resultados da extensão de via por V85 e hierarquia, definida pelo Código de Trânsito Brasileiro (CTB), dentro dos clusters _High-High_ e _High-Low_. 

#figure(
  table(
    columns: 5,
    align: (left, right, right, right, right),
    table.header([V85], [Trânsito rápido], [Arterial], [Coletora], [Local]),
    [40 - 50 km/h], [-], [1,07 km], [3,98 km], [27,21 km],
    [50 - 60 km/h], [5,00 km], [3,01 km], [17,95 km], [76,28 km],
    [60 - 70 km/h], [23,57 km], [3,79 km], [12,28 km], [52,78 km],
    [70 - 80 km/h], [113,48 km], [3,34 km], [5,59 km], [122,96 km],
    [80 - 90 km/h], [54,78 km], [-], [1,87 km], [59,78 km],
    [90 - 100 km/h], [30,69 km], [-], [-], [36,03 km],
    [100 - 110 km/h], [3,82 km], [-], [-], [4,84 km],
    [110 - 120 km/h], [1,38 km], [-], [-], [2,00 km],
    table.hline()
  ),
  caption: [Extensão de via por V85 e hierarquia, dentro dos hexágonos _High-High_ e _High-Low_]
) <tbl-dist> 

O primeiro fator que fica mais explícito é a ocorrência de V85 em todas as faixas entre 40 e 120 km/h nas vias locais, com maior quantidade na faixa entre 70 e 80 km/h, mostrando velocidades inseguras e totalmente incompartíveis com as funções dessa hierarquia viária. No caso das coletoras, a incidência de V85 ficou entre 40 e 90 km/h, com a maior parte entre 50 e 60 km/h. As vias arteriais apresentaram a menor extensão dentro dos hexágonos _High-High_ e _ High-Low_, com V85 variando entre 40 e 80 km/h. As vias de trânsito rápido apresentaram V85 na faixa de 40 a 120 km/h, com a maioria da extensão entre 70 e 80 km/h.

= CONCLUSÃO

Com o uso dos dados de velocidade instantânea do NDS-BR e do grid H3, foi possível mapear e calcular a autocorrelação local das velocidades inseguras em Curitiba, utilizando o V85 calculado como indicador. Esse processo possibilitou identificar os locais mais inseguros, estabelecidos pelos hexágonos classificados como _High-High_ e _High-Low_.

A parte central da cidade apresentou a maior quantidade de clusters _Low-Low_, representando as regiões com velocidades mais seguras. Os hexágonos identificados como _High-High_ estão em sua grande maioria localizados nos contornos rodoviários de Curitiba e outros locais de rodovias que passam pelo território da cidade. Isso mostra um dos problemas das travessias urbanas - vias com veículos transitando em altas velocidades dentro do território urbano. Vias locais também foram englobadas em clusters _High-High_ e outliers _High-Low_, mostrando uma insegurança nessas vias, cujo objetivo é ter uma função mais de acesso com trânsito mais acalmado, mas que vem apresentando velocidades incompartíveis com as suas características, conforme visto na @tbl-dist.

De todas as hierarquias analisadas nas zonas com velocidades mais inseguras, as vias arteriais tiveram a menor extensão englobada nessas áreas. Esse fator se assemelha com o comportamento identificado por #cite(<santosImpactBuiltEnvironment2022>, form: "prose"), em que zonas de tráfego com uma maior densidade de vias arteriais apresentaram uma correlação negativa com a incidência do excesso de velocidade. Os resultados desse trabalho podem ser mais um indicador do desempenho positivo da segurança nas vias arteriais de Curitiba.

Por fim, o presente trabalho buscou analisar a velocidade como um fator de risco sem se basear apenas no excesso de velocidade, mas sim no conceito de velocidades inseguras. Quando os limites de velocidade estabelecidos pelo poder público não atendem a mobilidade segura nas cidades, o diagnóstico com base no excesso de velocidade pode não demonstrar um cenário mais completo. Para futuras pesquisas, deve-se aprimorar o processo de análise dos eixos das vias. O uso de polígonos para mapear o V85 trouxe uma certa imprecisão para os resultados calculados considerando a hierarquia das vias.
