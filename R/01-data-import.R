read_ndsbr <- function() {
  ndsbr_path <- "data/ndsbr_sample.parquet"
  ndsbr_sample <- arrow::open_dataset(ndsbr_path)
  return(ndsbr_sample)
}

read_h3 <- function() {
  city_cod <- "cur"
  grid_cwb <- aopdata::read_grid(city = city_cod)
  return(grid_cwb)
}

read_radar <- function() {
  radar_sf_path <- "data/radar.geojson"
  radar_sf <- sf::st_read(radar_sf_path)
  return(radar_sf)
}

read_arruamento <- function() {
  arruamento_path <- "data/arruamento.geojson"
  arruamento_sf <- sf::read_sf(arruamento_path)
  return(arruamento_sf)
}
