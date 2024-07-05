
calc_nds_time = function(ndsbr_data) {
  return(nrow(ndsbr_data) / 3600)
}

calc_nds_dist = function(ndsbr_data) {
  if (!inherits(ndsbr_data, "sf")) {
    ndsbr_data = transform_sf(na.omit(ndsbr_data))
  } 
  dist = ndsbr_data |> 
    st_transform(crs = 31982) |> 
    mutate(
      lead = geometry[row_number() + 1],
      time_lead = as.numeric(lead(time) - time),
      dist = if_else(
        time_lead == 1 & lead(trip) == trip,
        st_distance(geometry, lead, by_element = T) |> units::drop_units(),
        0
      )
    ) |> 
    pull(dist) |> 
    sum(na.rm = TRUE) / 1000
  
  return(dist)
}

# calc_nds_trips = function(ndsbr_data) {
#   trip_table = speed_sample |> 
#     summarise(.by = driver, n = n_distinct(id)) |> 
#     arrange(driver)
#   return(trip_table)
# }

calc_nds_days = function(ndsbr_data) {
  days_table = ndsbr_data |> 
    group_by(driver) |> 
    summarise(n = n_distinct(date))
  return(days_table)
}

extract_driver_data = function(drivers) {
  drivers$sex <- as.factor(drivers$sex)
  drivers$age <- as.numeric(drivers$age)
  drivers$vehicle_age <- as.numeric(drivers$vehicle_age)
  drivers$vehicle_hp <- as.numeric(drivers$vehicle_hp)
  drivers$vehicle_transmission <- as.factor(drivers$vehicle_transmission)
  summary(drivers)
}

