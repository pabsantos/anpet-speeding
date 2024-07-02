filter_grid_high <- function(grid_sf) {
  grid_high = 
    subset(grid_sf, local_moran == "High-High" | local_moran == "High-Low")
  return(grid_high)
}

join_grid_axis = function(grid_sf, road_axis) {
  if (st_crs(road_axis) != st_crs(grid_sf)) {
    road_axis = st_transform(road_axis, st_crs(grid_sf))
  }
  axis_grid_data = st_join(road_axis, grid_sf)
  return(axis_grid_data)
}

plot_axis_grid_map = function(axis_grid_data) {
  ggplot(axis_grid_data) +
    geom_sf(aes(color = local_moran), lwd = 0.1) +
    scale_color_manual(values = c("red", "red", "grey10")) +
    theme_void(base_size = 8) +
    theme(
      plot.background = element_rect(fill = "white", color = "white"),
      legend.position = "none"
    )
}

plot_axis_speed <- function(axis_grid_data) {
  ggplot(axis_grid_data) +
    geom_sf(aes(color = percentil_speed), lwd = 0.1) +
    scale_color_viridis_c(
      na.value = "grey30",
      option = "A",
      direction = 1,
      begin = 0.45,
      end = 1
    ) +
    theme_void(base_size = 8) +
    labs(color = "V85") +
    theme(
      plot.background = element_rect(fill = "grey10", color = "grey10"),
      legend.position = c(0.90, 0.20),
      legend.title = element_text(size = 8, color = "grey90"),
      legend.text = element_text(size = 6, color = "grey90"),
      legend.key.height = unit(0.4, "cm"),
      legend.key.width = unit(0.4, "cm")
    )
}

calc_axis_len <- function(axis_grid_data, hierarchy) {
  axis_grid_data$dist <- st_length(axis_grid_data$geometry)
  axis_data <- subset(axis_grid_data, !is.na(percentil_speed))
  axis_data$v85_level <- cut(
    axis_data$percentil_speed,
    breaks = seq(40, 130, 10)
  )
  
  axis_data |> 
    st_drop_geometry() |> 
    group_by(v85_level, {{ hierarchy }}) |> 
    summarise(dist = sum(dist, na.rm = T) / 1000) |> 
    ungroup() |> 
    tidyr::pivot_wider(
      names_from = {{ hierarchy }},
      values_from = dist, 
      names_prefix = "hier_"
    )
}



