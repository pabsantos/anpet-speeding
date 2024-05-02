library(arrow)
library(sf)
library(aopdata)

ndsbr_sample <- arrow::open_dataset("data/ndsbr_sample.parquet")

## Variáveis necessárias para o estudo
selected_cols <- c("driver", "trip", "long", "lat", "date", "time", "spd_kmh")
speed_sample <- as.data.frame(ndsbr_sample[selected_cols], row.names = NULL)

## Filtrando algumas falhas na base (velocidades NA, coordenadas NA)
filtered_speed_sample <- 
  speed_sample[
    !is.na(speed_sample$spd_kmh) & 
      !is.na(speed_sample$long) & !is.na(speed_sample$lat), 
  ]

## Transformando em dados espaciais com o `sf`
speed_points <- sf::st_as_sf(
  filtered_speed_sample,
  coords = c("long", "lat"),
  crs = "4674"
)

## Considerando apenas velocidades acima de 10 km/h
speed_points_filtered <- speed_points[speed_points$spd_kmh > 10, ]

## Importando a base h3 de Curitiba com auxílio do aopdata
grid_cwb <- aopdata::read_grid(city = "cur")

## Unindo os dados do nds-br com o grid
speed_poits_grid <- sf::st_join(
  sf::st_set_crs(speed_points_filtered, 4326),
  grid_cwb
)

## Calculando a velocidade média por grid e agregando os novos dados
## Nota: depois calcular desvio padrao, mediana, 85 quantil,
mean_speed <- tapply(speed_poits_grid$spd_kmh, speed_poits_grid$id_hex, mean)

mean_speed_df <- data.frame(
  id_hex = names(mean_speed),
  mean_speed = mean_speed,
  row.names = NULL
)

grid_cwb_mean_spd <- merge(grid_cwb, mean_speed_df, by = "id_hex", all.x = TRUE)

plot(grid_cwb_mean_spd["mean_speed"])

hist(speed_points_filtered$spd_kmh, breaks = 30)
