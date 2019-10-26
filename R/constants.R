#' @importFrom magrittr %>%
#' @importFrom stringr str_replace_all
#' @importFrom stringi stri_trans_general
#' @importFrom lubridate mdy
#' @import dplyr
#' @import RSelenium

PORT <- 4445L
WEBSITE_URL <- "https://www.metacritic.com/"
ALBUMS_PER_YEAR_BY_METASCORE_URL <- "browse/albums/score/metascore/year/filtered?sort=desc&year_selected="
ALBUMS_PER_YEAR_BY_SHARES_URL <- "browse/albums/score/metascore/shared/filtered?sort=desc&year_selected="
ALBUMS_PER_YEAR_BY_DISCUSSIONS_URL <- "browse/albums/score/metascore/discussed/filtered?sort=desc&year_selected="
MUSIC <- "music/"
PERSON <- "person/"
