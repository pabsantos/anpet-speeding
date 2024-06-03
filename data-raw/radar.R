library(jsonlite)
library(sf)

radar_path <- "data-raw/radar.json"
radar <- jsonlite::fromJSON(radar_path)
radar_df <- radar$localArray

radar_df <- subset(radar_df, select = -icones)

radar_df$controles <- sapply(radar_df$controles, paste, collapse = ",")
radar_df$ctrl_vel <- ifelse(
  grepl("Velocidade controlada", radar_df$controles), 1, 0
)
radar_df$parada_faixa <- ifelse(
  grepl("Parada na faixa", radar_df$controles), 1, 0
)  
radar_df$avanco_sinal <- ifelse(
  grepl("Avanço de sinal", radar_df$controles), 1, 0
)
radar_df$conv_obrigatoria <- ifelse(
  grepl("Conversão obrigatória", radar_df$controles), 1, 0
)
radar_df$faixa_exclusiva <- ifelse(
  grepl("Faixa Exclusiva", radar_df$controles), 1, 0
)
radar_df$conv_proibida <- ifelse(
  grepl("Conversão proibida", radar_df$controles), 1, 0
)
radar_df$peso_bruto_total <- ifelse(
  grepl("Peso Bruto Total", radar_df$controles), 1, 0
)
radar_df$retorno_proibido <- ifelse(
  grepl("Retorno proibido", radar_df$controles), 1, 0
)

radar_sf <- 
  sf::st_as_sf(radar_df, coords = c("longitude", "latitude"), crs = 4674)

radar_sf_path <- "data/radar.geojson"
sf::write_sf(radar_sf, radar_sf_path)
