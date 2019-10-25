source("./R/utils.R")
source("./R/constants.R")
source("./R/selenium_wrapper.R")
library(RSelenium)
library(magrittr)
library(stringr)
library(stringi)


get_artist_albums <- function(artist_name) {
  remDr <- open_remDr()
  scrap <- scrape_artist_albums(remDr, artist_name) %>%
    create_artist_df()
  close_remDr(remDr)
  return(scrap)

}

scrape_artist_albums <- function(remDr, artist_name) {
  remDr$navigate(paste0(WEBSITE_URL, PERSON, format_name(artist_name)))

  element <- remDr$findElement(using = 'class', value = 'credits')
  elemtxt <- element$getElementText()

  result <- strsplit(elemtxt[[1]],"\n")
  return(result)

}

create_artist_df <- function(obj_scrap) {

}
