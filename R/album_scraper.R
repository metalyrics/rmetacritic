source("./R/utils.R")
source("./R/constants.R")
source("./R/selenium_wrapper.R")
library(RSelenium)
library(magrittr)
library(stringr)
library(stringi)
library(lubridate)
library(dplyr)

#' @title Get best metacritic albums
#' @param year Year of albums
#' @param by Selector
#' @return Dataframe containing the best 100 albums of the year
#' @rdname get_best_albums_per_year
#' @examples
#' best_2018_albums <- get_best_albums_per_year("2018")
#' best_2018_albums <- get_best_albums_per_year("2018", by = "shared")
#' @export
get_best_albums_per_year <- function(year,
                                     by = "metascore" #metascore, shared or discussed
                                     ) {
  remDr <- .open_remDr()
  url <- ALBUMS_PER_YEAR_BY_METASCORE_URL
  if (by == "shared") {
    url <- ALBUMS_PER_YEAR_BY_SHARES_URL
  } else if (by == "discussion"){
    url <- ALBUMS_PER_YEAR_BY_DISCUSSIONS_URL
  }
  scrap <- scrape_best_albums_per_year(remDr, year, url) %>%
    create_best_albums_df()
  .close_remDr(remDr)
  return(scrap)

}

#' @title Extract best albums by year
#' @param remDr Remote driver
#' @param year Year of albums
#' @return Return list with object of scrapper
.scrape_best_albums_per_year <- function(remDr, year, url) {
  remDr$navigate(paste0(WEBSITE_URL, url, year))

  element <- remDr$findElement(using = 'class', value = 'list_products')
  elemtxt <- element$getElementText()

  result <- strsplit(elemtxt[[1]],"\n")
  return(result)
}

#' @title Create dataframe with top 100 best albums
#' @param obj_scrap Object scrapper
#' @return Dataframe with best albums
.create_best_albums_df <- function(obj_scrap) {
  matrix <- matrix(matrix(unlist(obj_scrap), ncol=5, byrow=T))

  name <- matrix[1:100]
  metascore <- matrix[101:200]
  artist_name <- matrix[201:300]
  user_score <- matrix[301:400]
  release_date <- matrix[401:500]

  best_albums <- data.frame(name, metascore, artist_name, user_score, release_date) %>%
    mutate(release_date = mdy(release_date))
  return(best_albums)
}

#' @title Get album critic reviews
#' @param name Album's name
#' @param artist Album's autor
#' @return Dataframe containing all album's critic reviews
#' @rdname get_album_critic_reviews
#' @examples
#' album_critics <- get_album_critic_reviews("Melodrama", "Lorde")
#' @export
get_album_critic_reviews <- function(name, artist) {
  remDr <- .open_remDr()
  scrap <- scrape_album_critic_reviews(remDr, name, artist) %>%
    create_album_reviews_df()
  .close_remDr(remDr)
  return(scrap)

}

#' @title Extract album reviews
#' @param remDr Remote driver
#' @param name Album's name
#' @param name Album's autor
#' @return Return list with object of scrapper
.scrape_album_critic_reviews <- function(remDr, name, artist) {

  album_page_url <- paste0(WEBSITE_URL, MUSIC, .format_name(name), "/", .format_name(artist))
  remDr$navigate(paste0(album_page_url, "/critic-reviews"))

  element <- tryCatch(
    {
      remDr$findElement(using = 'class', value = 'reviews')
    },
    error = function(e){
      warning("Albúm não encontrado")
      return()
    }
  )

  element <- remDr$findElement(using = 'class', value = 'reviews')
  elemtxt <- element$getElementText()
  ad <- remDr$findElement(using = 'id', value = 'native_top')
  adTxt <- ad$getElementText()

  adList <- strsplit(adTxt[[1]],"\n")[[1]]
  result <- strsplit(elemtxt[[1]],"\n")[[1]]
  result[which(result %in% c("All this publication's reviews", "Read full review"))] <- NA
  result <- result[-which(is.na(result))]
  if (length(adList) > 0) {
    result <- result[-which(result %in% adList)]
  }
  return(result)
}

#' @title Create dataframe with all the album's critic reviews
#' @param obj_scrap Object scrapper
#' @return Dataframe with reviews
.create_album_reviews_df <- function(obj_scrap) {
  matrix <- matrix(matrix(unlist(obj_scrap), ncol=4, byrow=T))
  n_reviews <- length(obj_scrap)/4

  publication <- matrix[1:n_reviews]
  date <- matrix[(n_reviews+1):(n_reviews*2)]
  score <- matrix[(n_reviews*2+1):(n_reviews*3)]
  review <- matrix[(n_reviews*3+1):(n_reviews*4)]

  reviews <- data.frame(publication, date, score, review) %>%
    mutate(date = mdy(date))
  return(reviews)
}


