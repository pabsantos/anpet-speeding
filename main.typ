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
  title: "VELOCIDADES INSEGURAS EM CURITIBA-PR"
)

= INTRODUÇÃO

Risco de velocidades inseguras em ambientes urbanos

Gestão da velocidade em ambientes urbanos

Estudos Naturalísticos
- Método
- Trabalhos que investigaram velocidade
- Minha dissertação

Objetivos
- Analisar a incidência de velocidades inseguras em Curitiba
- Detectar possíveis padrões geográficos dessa incidência no território da cidade
- Localizar os agrupamentos espaciais
- Analisar posição de radares
  
= METODOLOGIA

Coleta de dados
- Primários: NDSBR
- Secundários: Radares SETRAN Curitiba

Processamento
- Unidade geográfica de análise: grid H3
- Filtro de velocidades > 0
- Indicadores de velocidade: Velocidade de 85º percentil e desvio padrão

Testes de autocorrelação local e agrupamento geográfico
- Moran Local

= RESULTADOS

NDSBR
- Tempo de viagem da amostra (mapa)
- Duração e quantidade de viagens
- Características dos condutores
- Características dos veículos

Velocidades
- 85º percentil (mapa)  
- Desvio padrão (mapa)
- Local Moran (mapa)

= CONCLUSÃO

- Velocidades inseguras != excesso de velocidade
- Centro da cidade
- Problema da insegurança nas travessias urbanas