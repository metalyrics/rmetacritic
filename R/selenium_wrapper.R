#' @title Open to connect to remote server
#' @return remDr Object remote driver
open_remDr <- function() {
  remDr <- RSelenium::remoteDriver(port = PORT)
  remDr$open()
  return(remDr)
}

#' @title Close to connect remote server
#' @param remDr Object remote driver
close_remDr <- function(remDr) {
  remDr$close()
}
