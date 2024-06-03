calc_lisa <- function(ind_grid) {
  queen_w <- queen_weights(ind_grid)
  lmoran <- local_moran(queen_w, df = ind_grid["percentil_speed"])
  return(lmoran)
}

extract_lmoran <- function(lmoran_results, grid) {
  grid$local_moran <- as.factor(lisa_clusters(lmoran_results, cutoff = 0.05))
  lmoran_labels <- lisa_labels(lmoran_results)
  levels(grid$local_moran) <- lmoran_labels
  return(grid)
}
