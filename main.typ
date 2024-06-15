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

O efeito nocivo de altas velocidades na mobilidade segura em ambientes urbanos já vem sendo extensivamente investigado pela literatura. Em cidades, aonde as vítimas mais vulneráveis (pedestres e ciclistas) à esse fator de risco vem sofrendo mortes e lesões graves em colisões com veículos motorizados, vê-se a importancia de se repensar os limites de velocidade e garantir o tráfego dos veículos motorizados a uma velocidade segura @nactoCityLimitsSetting2022. A velocidade é um fator central na ocorrência de óbitos no trânsito, influenciando diretamente na gravidade de um sinistro - considerando a energia de impacto - a na chance de ocorrência - afetando negativamente o tempo de reação e a visão periférica do condutor @grspSpeedManagementRoad2023.

#cite(<santosImpactBuiltEnvironment2022>, form: "prose") investigou a autocorrelação espacial do excesso de velocidade em Curitiba-PR e identificou que esse fator de risco não ocorre com mesma intensidade ao longo território da cidade. Inclusive, observou-se uma diferença significativa no nível de renda da população entre zonas de alto e baixo excesso de velocidade, mostrando que regiões com menores níveis de renda estão mais expostas ao fator de risco do excesso de velocidade. Porém, a análise única do excesso de velocidade impossibilita identificar a ocorrência de velocidades inseguras, ou seja, aquelas que mesmo estando abaixo dos limites de velocide ainda representam uma situação insegura para o cenário urbano. Assim, o objetivo desse trabalho é analisar a incidência de velocidades inseguras em Curitiba-PR. Em adição, busca-se detectar possíveis padrões geográficos dessa indidência no território da cidade, com base na detecção de agrupamentos espaciais através de técnicas de autocorrelação local.

= METODOLOGIA



Coleta de dados
- Primários: NDSBR

Processamento
- Unidade geográfica de análise: grid H3
- Filtro de velocidades > 0
- Indicadores de velocidade: Velocidade de 85º percentil

Testes de autocorrelação local e agrupamento geográfico
- Moran Local

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