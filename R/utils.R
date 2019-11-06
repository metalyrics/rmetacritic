#' @title Format name to url's pattern
#' @param name Name to format
#' @return Formated name
.format_name_to_url <- function(name) {
  name <- name %>%
    tolower() %>%
    str_replace_all("!", "exclamationmark") %>%
    str_replace_all("-", "hyphen") %>%
    str_replace_all("[:punct:]", "") %>%
    str_replace_all("exclamationmark", "!") %>%
    str_replace_all("hyphen", "-") %>%
    str_replace_all(" ", "-") %>%
    stri_trans_general("Latin-ASCII")
  return(name)
}
