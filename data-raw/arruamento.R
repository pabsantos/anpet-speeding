zip_url <- "https://ippuc.org.br/geodownloads/SHAPES_SIRGAS/ARRUAMENTO_QUADRAS_SIRGAS.zip"
zip_temp <- tempfile()
download.file(zip_url, zip_temp)
unzip_temp <- tempfile()
unzip(zip_temp, exdir = unzip_temp)
arruamento <- sf::st_read(unzip_temp)
sf::st_write(arruamento, "data/arruamento.geojson")
