plot_ecdf_grid <- function(ind_grid) {
  ggplot(ind_grid, aes(x = percentil_speed)) +
    stat_ecdf(color = onsv_palette$blue) +
    theme_minimal() +
    scale_x_continuous(breaks = seq(0, 130, 10), minor_breaks = NULL) +
    scale_y_continuous(
      labels = scales::percent,
      breaks = seq(0, 1, 0.1),
      minor_breaks = NULL
    ) +
    labs(
      x = "Velocidade de 85º percentil (km/h)",
      y = NULL
    )
}

plot_ecdf_point <- function(speed_points) {
  ggplot(speed_points, aes(x = spd_kmh)) +
    stat_ecdf(color = onsv_palette$blue) +
    theme_minimal() +
    scale_x_continuous(breaks = seq(0, 160, 10), minor_breaks = NULL) +
    scale_y_continuous(
      labels = scales::percent,
      breaks = seq(0, 1, 0.1),
      minor_breaks = NULL
    ) +
    labs(
      x = "Velocidade Instantânea (km/h)",
      y = NULL
    )
}
