# Setup ----

library(arrow)
library(sf)
library(aopdata)
library(spdep)
library(rgeoda)
library(ggplot2)
library(onsvplot)
library(patchwork)
library(gghighlight)

set.seed(123)

source("R/01-data-import.R")
source("R/02-sample-preprocess.R")
source("R/03-create-grid-sample.R")
source("R/04-local-moran.R")
source("R/05-ecdf-plot.R")
source("R/06-plot-maps.R")
source("R/99-export.R")

# Importando os dados ----

ndsbr_sample <- read_ndsbr()
grid_cwb <- read_h3()
radar_sf <- read_radar()
arruamento_sf <- read_arruamento()

# Pré-processamento da amostra ----

speed_sample <- select_cols(ndsbr_sample)
filtered_speed_sample <- filter_sample(speed_sample, speed_threshold = 0)
speed_points <- transform_sf(filtered_speed_sample)

# Criação da amostra de indicadores a partir do grid H3 ----

speed_points_grid <- grid_speed_join(speed_points, grid_cwb)
grid_cwb <- calc_time_traveled(speed_points_grid, grid_cwb)
grid_cwb <- calc_speed_indicators(speed_points_grid, grid_cwb)

# Cálculo do Moran Local ----

ind_grid <- subset(grid_cwb, !is.na(sd_speed) & !is.na(percentil_speed))
lmoran_results <- calc_lisa(ind_grid)
ind_grid_moran <- extract_lmoran(lmoran_results, ind_grid)

# Cálculo / plot da curva S de velocidades ----

ecdf_grid_plot <- plot_ecdf_grid(ind_grid_moran)
ecdf_points_plot <- plot_ecdf_point(speed_points)

# Mapas ----

border_color <- "grey70"

dist_map <- plot_dist_map(
  grid_cwb, 
  breaks_vector = seq(0, 120, 20), 
  border_color
)
percentil_map <- plot_percentil_map(
  grid_cwb,
  breaks_vector = seq(30, 80, 10),
  border_color
)
sd_map <- plot_sd_map(grid_cwb, breaks_vector = seq(10, 25, 5), border_color)
local_moran_map <- plot_local_moran_map(ind_grid_moran, grid_cwb, border_color)

lisa_grouped <- group_moran_results(ind_grid_moran)
lisa_grouped_map <- plot_moran_group_map(lisa_grouped)

# Exporta os resultados ----

ecdf_names <- c("plot/ecdf_grid_plot.svg", "plot/ecdf_points_plot.svg")
maps_names <- paste0(
  "plot/",
  c(
    "dist_map",
    "percentil_map",
    "sd_map",
    "local_moran_map",
    "lisa_grouped_map"
  ),
  ".svg"
)

maps_list <- list(
  dist_map,
  percentil_map,
  sd_map,
  local_moran_map,
  lisa_grouped_map
)

export_plot(ecdf_names, list(ecdf_grid_plot, ecdf_points_plot), height = 3.5)
export_plot(maps_names, maps_list, height = 4)

data_export <- list(grid_cwb, ind_grid_moran, lisa_grouped)
data_path <- paste0(
  "data/",
  c("grid_cwb", "ind_grid_moran", "lisa_grouped"),
  ".gpkg"
)

purrr::map2(data_export, data_path, st_write, append = FALSE)
