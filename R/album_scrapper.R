source("./R/constants.R")
library(RSelenium)
library(readr)

scrap_album <- function(year) {
  remDr <- .open_remDr()
  remDr$navigate(paste0(URL_ALBUMS, year))

  element <- remDr$findElement(using = 'class', value = 'list_products')
  elemtxt <- element$getElementText()

  result <- strsplit(elemtxt[[1]],"\n")
  return(result)
}

create_best_albums <- function(result_scrap) {
  matrix <- matrix(matrix(unlist(result_scrap), ncol=5, byrow=T))

  name <- matrix[1:100]
  metascore <- matrix[101:200]
  artist_name <- matrix[201:300]
  user_score <- matrix[301:400]
  release_date <- matrix[401:500]

  best_albums <- data.frame(name, metascore, artist_name, user_score, release_date)
  return(best_albuns)
}

.open_remDr <- function() {
  remDr <- remoteDriver(port = PORT)
  result <- remDr$open()
  return(remDr)
}

.close_remDr <- function(remDr) {
  remDr$close()
}

create_table_best_albuns <- function(df_best_albums) {
  write_csv(df_best_albums, "data/best_albums.csv")
}

