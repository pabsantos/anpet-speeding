plot_dist_map <- function(grid_cwb, breaks_vector, hex_border_color) {
  time_map <- ggplot() +
    geom_sf(
      data = grid_cwb,
      aes(fill = travel_time_minutes),
      lwd = 0.01,
      color = hex_border_color
    ) +
    theme_void(base_size = 8) +
    scale_fill_fermenter(
      palette = "YlGnBu",
      breaks = breaks_vector,
      direction = -1,
      na.value = "grey80"
    ) +
    labs(fill = NULL, title = "Tempo de viagem (minutos)") +
    theme(
      legend.position = "top",
      legend.justification = 0.5,
      legend.key.size = unit(0.5, "cm"),
      legend.key.width = unit(0.8, "cm"),
      legend.margin = margin(5),
      plot.title = element_text(hjust = 0.5)
    )
  
  grid_cwb$group_travel <- findInterval(
    grid_cwb$travel_time_minutes, 
    breaks_vector
  )
  
  time_sum_groups <- 
    tapply(grid_cwb$travel_time_minutes, grid_cwb$group_travel, sum)
  
  df_time_groups <- 
    data.frame(group = names(time_sum_groups), time = time_sum_groups)
  
  df_time_groups$perc_time <- df_time_groups$time / sum(df_time_groups$time)
  
  time_hist <- ggplot(
    df_time_groups,
    aes(y = perc_time, x = rev(group), fill = group)
  ) +
    geom_col() +
    coord_flip() +
    scale_fill_brewer(palette = "YlGnBu", direction = -1) +
    theme_void(base_size = 6) +
    theme(
      legend.position = "none",
      plot.title = element_text(hjust = 0.15)
    ) +
    geom_text(
      aes(y = perc_time, label = scales::percent(perc_time, accuracy = 1)),
      nudge_y = 0.04,
      size = 2
    ) +
    labs(title = "Percentual do tempo")
  
  time_full_plot <- time_map + inset_element(
    time_hist,
    left = 0.9,
    bottom = 0.05,
    right = 1.5,
    top = 0.45
  )
  return(time_full_plot)
}

plot_percentil_map <- function(grid_cwb, breaks_vector, hex_border_color) {
  speed_map <- ggplot(grid_cwb) +
    geom_sf(aes(fill = percentil_speed), color = hex_border_color, lwd = 0.01) +
    theme_void(base_size = 8) +
    scale_fill_viridis_b(
      breaks = breaks_vector,
      na.value = "grey80",
      option = "A"
    ) +
    labs(fill = NULL, title = "Velocidade de 85º percentil") +
    theme(
      legend.position = "top",
      legend.justification = 0.5,
      legend.key.size = unit(0.5, "cm"),
      legend.key.width = unit(0.8, "cm"),
      legend.margin = margin(5),
      plot.title = element_text(hjust = 0.5)
    )
  
  grid_cwb$group_speed <- findInterval(
    grid_cwb$percentil_speed, 
    breaks_vector
  )
  
  speed_sum_groups <- 
    tapply(grid_cwb$travel_time_minutes, grid_cwb$group_speed, sum)
  
  speed_count_groups <- table(grid_cwb$group_speed)
  
  df_speed_hist <- data.frame(
    speed_group = names(speed_sum_groups),
    time_sum = speed_sum_groups,
    hex_count = as.vector(speed_count_groups)
  )
  
  df_speed_hist$perc_time <- 
    df_speed_hist$time_sum / sum(df_speed_hist$time_sum)
  
  speed_hist <- ggplot(df_speed_hist, aes(y = perc_time, x = speed_group)) +
    geom_col(aes(fill = speed_group)) +
    coord_flip() +
    scale_fill_viridis_d(
      option = "A",
      direction = 1
    ) +
    theme_void(base_size = 6) +
    theme(
      legend.position = "none",
      plot.title = element_text(hjust = 0.10, size = 6)
    ) +
    geom_text(
      aes(y = perc_time, label = scales::percent(perc_time, accuracy = 0.1)),
      nudge_y = 0.04,
      size = 1.5
    ) +
    labs(title = "Percentual do tempo")
  
  speed_full_plot <- speed_map + inset_element(
    speed_hist,
    left = 0.9,
    bottom = 0.05,
    right = 1.7,
    top = 0.45
  )
  return(speed_full_plot)
}

plot_sd_map <- function(grid_cwb, breaks_vector, hex_border_color) {
  speed_map <- ggplot(grid_cwb) +
    geom_sf(aes(fill = sd_speed), color = hex_border_color, lwd = 0.01) +
    theme_void(base_size = 8) +
    scale_fill_viridis_b(
      breaks = breaks_vector,
      na.value = "grey80",
      option = "A"
    ) +
    labs(fill = NULL, title = "Desvio padrão (km/h)") +
    theme(
      legend.position = "top",
      legend.justification = 0.5,
      legend.key.size = unit(0.5, "cm"),
      legend.key.width = unit(0.8, "cm"),
      legend.margin = margin(5),
      plot.title = element_text(hjust = 0.5)
    )
  
  grid_cwb$group_speed <- findInterval(
    grid_cwb$sd_speed, 
    breaks_vector
  )
  
  speed_sum_groups <- 
    tapply(grid_cwb$travel_time_minutes, grid_cwb$group_speed, sum)
  
  speed_count_groups <- table(grid_cwb$group_speed)
  
  df_speed_hist <- data.frame(
    speed_group = names(speed_sum_groups),
    time_sum = speed_sum_groups,
    hex_count = as.vector(speed_count_groups)
  )
  
  df_speed_hist$perc_time <- 
    df_speed_hist$time_sum / sum(df_speed_hist$time_sum)
  
  speed_hist <- ggplot(df_speed_hist, aes(y = perc_time, x = speed_group)) +
    geom_col(aes(fill = speed_group)) +
    coord_flip() +
    scale_fill_viridis_d(
      option = "A",
      direction = 1
    ) +
    theme_void(base_size = 6) +
    theme(
      legend.position = "none",
      plot.title = element_text(hjust = 0.10, size = 6)
    ) +
    geom_text(
      aes(y = perc_time, label = scales::percent(perc_time, accuracy = 0.1)),
      nudge_y = 0.04,
      size = 1.5
    ) +
    labs(title = "Percentual do tempo")
  
  speed_full_plot <- speed_map + inset_element(
    speed_hist,
    left = 0.9,
    bottom = 0.05,
    right = 1.7,
    top = 0.45
  )
  return(speed_full_plot)
}

plot_local_moran_map <- function(ind_grid_moran, grid_cwb, border_color) {
  ggplot(ind_grid_moran) +
    geom_sf(data = grid_cwb, color = border_color, fill = "grey70") +
    geom_sf(aes(fill = local_moran), color = "grey50", lwd = 0.05) +
    scale_fill_manual(values = lisa_colors(lmoran_results)) +
    theme_void(base_size = 8) +
    labs(fill = "Local Moran") +
    theme(legend.position = c(1.05, 0.22))
}

group_moran_results <- function(ind_grid_moran) {
  lisa_grouped <- ind_grid_moran |> 
    dplyr::group_by(local_moran) |>
    dplyr::summarise() |> 
    dplyr::filter(local_moran != "Not significant") |> 
    dplyr::mutate(lisa_ord_group = dplyr::case_match(
      local_moran,
      c("High-High", "High-Low") ~ "High-High + High-Low",
      c("Low-Low", "Low-High") ~ "Low-Low + Low-High",
    ))
  return(lisa_grouped)
}

plot_moran_group_map <- function(lisa_grouped) {
  lmoran_group_map <- ggplot() +
    geom_sf(
      data = lisa_grouped,
      aes(fill = lisa_ord_group),
      color = NA,
      alpha = 0.8
    ) +
    theme_void() +
    scale_fill_manual(values = lisa_colors(lmoran_results)[2:3]) +
    theme(legend.position = "none") +
    gghighlight(unhighlighted_params = list(fill = "grey50")) +
    facet_wrap(~lisa_ord_group) +
    geom_sf(
      data = arruamento_sf,
      fill = NA,
      lwd = 0.05,
      color = "grey50",
      alpha = 0.1
    )
  return(lmoran_group_map)
}
