#' @title Open to connect to remote server
#' @return remote_driver Object remote driver
.open_remote_driver <- function() {
  remote_driver <- RSelenium::remoteDriver(port = PORT)
  remote_driver$open()
  return(remote_driver)
}

#' @title Close to connect remote server
#' @param remote_driver Object remote driver
.close_remote_driver <- function(remote_driver) {
  remote_driver$close()
}
