library(arrow)
library(sf)

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
speed_points <- st_as_sf(
  filtered_speed_sample,
  coords = c("long", "lat"),
  crs = "4674"
)