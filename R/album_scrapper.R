source("./R/constants.R")
library(RSelenium)
library(readr)
library(magrittr)

#' @title Get best metacritic albums
#' @param year Year of albums
#' @return Dataframe containing the best 100 albums of the year
#' @rdname get_best_albums_per_year
#' @export
get_best_albums_per_year <- function(year) {
  remDr <- .open_remDr()
  scrap <- scrape_best_albums_per_year(remDr, year) %>%
    create_best_albums_df()
  .close_remDr(remDr)
  return(scrap)

}

#' @title Extract best albums by year
#' @param remDr Remote driver
#' @param year Year of albums
#' @return Return list with object of scrapper
scrape_best_albums_per_year <- function(remDr, year) {
  remDr$navigate(paste0(WEBSITE_URL, ALBUMS_PER_YEAR_URL, year))

  element <- remDr$findElement(using = 'class', value = 'list_products')
  elemtxt <- element$getElementText()

  result <- strsplit(elemtxt[[1]],"\n")
  return(result)
}

#' @title Create dataframe with top 100 best albums
#' @param obj_scrap Object scrapper
#' @return Dataframe with best albums
create_best_albums_df <- function(obj_scrap) {
  matrix <- matrix(matrix(unlist(obj_scrap), ncol=5, byrow=T))

  name <- matrix[1:100]
  metascore <- matrix[101:200]
  artist_name <- matrix[201:300]
  user_score <- matrix[301:400]
  release_date <- matrix[401:500]

  best_albums <- data.frame(name, metascore, artist_name, user_score, release_date)
  return(best_albums)
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


