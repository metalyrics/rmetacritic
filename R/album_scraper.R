source("./R/utils.R")
source("./R/constants.R")
source("./R/selenium_wrapper.R")

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
  if (!(by %in% c("metascore", "shared", "discussion"))) {
    warning("Invalid selector, returning by metascore...")
  }
  remote_driver <- .open_remote_driver()
  url <- case_when(by == "metascore" ~ ALBUMS_PER_YEAR_BY_METASCORE_URL,
                   by == "shared" ~ ALBUMS_PER_YEAR_BY_SHARES_URL,
                   by == "discussion" ~ ALBUMS_PER_YEAR_BY_DISCUSSIONS_URL,
                   TRUE ~ ALBUMS_PER_YEAR_BY_METASCORE_URL)
  print("Downloading best albums...")
  scrap <- .scrape_best_albums_per_year(remote_driver, year, url) %>%
    .create_best_albums_df()
  .close_remote_driver(remote_driver)
  return(scrap)
}

#' @title Extract best albums by year
#' @param remote_driver Remote driver
#' @param year Year of albums
#' @param url Page url
#' @return Return list with object of scrapper
.scrape_best_albums_per_year <- function(remote_driver, year, url) {
  remote_driver$navigate(paste0(WEBSITE_URL, url, year))
  Sys.sleep(3)
  element <- remote_driver$findElement(using='class', value='list_products')
  element_text <- element$getElementText()

  result <- strsplit(element_text[[1]],"\n")
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
  remote_driver <- .open_remote_driver()
  print("Downloading album reviews...")
  scrap <- .scrape_album_critic_reviews(remote_driver, name, artist) %>%
    .create_album_reviews_df()
  .close_remote_driver(remote_driver)
  return(scrap)
}

#' @title Extract album reviews
#' @param remote_driver Remote driver
#' @param name Album's name
#' @param name Album's autor
#' @return Return list with object of scrapper
.scrape_album_critic_reviews <- function(remote_driver, name, artist) {
  album_page_url <- paste0(WEBSITE_URL, MUSIC, .format_name_to_url(name), "/", .format_name_to_url(artist))
  remote_driver$navigate(paste0(album_page_url, "/critic-reviews"))
  Sys.sleep(3)
  element <- tryCatch(
    {
      remote_driver$findElement(using='class', value='reviews')
    },
    error = function(e){
      warning("Album not found")
      return()
    }
  )

  element <- remote_driver$findElement(using='class', value='reviews')
  element_text <- element$getElementText()
  ad <- remote_driver$findElement(using='id', value='native_top')
  ad_text <- ad$getElementText()

  ad_list <- strsplit(ad_text[[1]],"\n")[[1]]
  result <- strsplit(element_text[[1]],"\n")[[1]]
  result[which(result %in% c("All this publication's reviews", "Read full review"))] <- NA
  result <- result[-which(is.na(result))]
  if (length(ad_list) > 0) {
    result <- result[-which(result %in% ad_list)]
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


