select_cols <- function(ndsbr_data) {
  cols <- c("driver", "trip", "id", "long", "lat", "date", "time", "spd_kmh")
  speed_sample <- as.data.frame(ndsbr_sample[cols], row.names = NULL)
  return(speed_sample)
}

filter_sample <- function(speed_sample, speed_threshold) {
  ndsbr_data <- subset(
    speed_sample,
    !is.na(speed_sample$spd_kmh) & !is.na(speed_sample$long) & 
      !is.na(speed_sample$lat) & speed_sample$spd_kmh > speed_threshold
  )
  return(ndsbr_data)
}

transform_sf <- function(ndsbr_data) {
  ndsbr_sf <- sf::st_as_sf(
    ndsbr_data,
    coords = c("long", "lat"),
    crs = 4674
  )
  return(ndsbr_sf)
}
