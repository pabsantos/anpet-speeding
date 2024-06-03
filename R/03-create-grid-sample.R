grid_speed_join <- function(ndsbr_data, h3_grid) {
  sample_grid <- sf::st_join(
    sf::st_set_crs(ndsbr_data, 4326),
    h3_grid
  )
  return(sample_grid)
}

calc_time_traveled <- function(sample_grid, h3_grid) {
  travel_time_minutes <- table(sample_grid$id_hex) / 60
  travel_df <- as.data.frame(travel_time_minutes)
  names(travel_df) <- c("id_hex", "travel_time_minutes")
  grid <- merge(h3_grid, travel_df, by = "id_hex", all.x = TRUE)
  return(grid)
}

calc_speed_indicators <- function(sample_grid, h3_grid) {
  sd_speed <- tapply(sample_grid$spd_kmh, sample_grid$id_hex, sd)
  percentil_speed <- tapply(
    sample_grid$spd_kmh, 
    sample_grid$id_hex, 
    quantile, 
    p = 0.85
  )
  indicadores_df <- data.frame(
    sd_speed, 
    percentil_speed,
    id_hex = rownames(sd_speed), 
    row.names = NULL
  )
  grid <- merge(h3_grid, indicadores_df, by = "id_hex", all.x = TRUE)
  return(grid)
}
