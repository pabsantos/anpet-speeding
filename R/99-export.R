export_plot <- function(names, plots, height) {
  purrr::map2(
    names,
    plots,
    ggsave,
    width = 6,
    height = height,
    dpi = 300,
    device = "svg"
  )
}
