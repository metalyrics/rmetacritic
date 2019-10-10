source("./R/constants.R")
library(RSelenium)
library(readr)

#' @title Extract best albums by year
#' @param remDr Remote driver
#' @param year Year of albums
#' @return Return list with object of scrapper
scrap_album <- function(remDr, year) {
  remDr$navigate(paste0(URL_ALBUMS, year))

  element <- remDr$findElement(using = 'class', value = 'list_products')
  elemtxt <- element$getElementText()

  result <- strsplit(elemtxt[[1]],"\n")
  return(result)
}

#' @title Create dataframe with top 100 best albums
#' @param obj_scrap Object scrapper
#' @return Dataframe with best albums
create_best_albums <- function(obj_scrap) {
  matrix <- matrix(matrix(unlist(obj_scrap), ncol=5, byrow=T))

  name <- matrix[1:100]
  metascore <- matrix[101:200]
  artist_name <- matrix[201:300]
  user_score <- matrix[301:400]
  release_date <- matrix[401:500]

  best_albums <- data.frame(name, metascore, artist_name, user_score, release_date)
  return(best_albums)
}

#' @title Execute scrapper by year
#' @param year Year of albums
run_scrap <- function(year) {
  remDr <- .open_remDr()
  scrap <- scrap_album(remDr, year)
  df_best_albums <- create_best_albums(scrap)
  .create_table_best_albuns(df_best_albums)
  .close_remDr(remDr)

}

#' @title Create table with the best albums
#' @param df_best_albums Dataframe
.create_table_best_albuns <- function(df_best_albums) {
  write_csv(df_best_albums, "data/best_albums_2.csv")
}

#' @title Open to connect to remote server
#' @return remDr Object remote driver
.open_remDr <- function() {
  remDr <- remoteDriver(port = PORT)
  remDr$open()
  return(remDr)
}

#' @title Close to connect remote server
#' @param remDr Object remote driver
.close_remDr <- function(remDr) {
  remDr$close()
}


