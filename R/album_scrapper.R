library(RSelenium)

remDr <- remoteDriver(port = 4445L)
remDr$open()

remDr$navigate("https://www.metacritic.com/browse/albums/score/metascore/year/filtered?sort=desc&year_selected=2019")

element <- remDr$findElement(using = 'class', value = 'list_products')

elemtxt <- element$getElementText()

result <- strsplit(elemtxt[[1]],"\n")

matrix <- matrix(matrix(unlist(result), ncol=5, byrow=T))

name <- matrix[1:100]
metascore <- matrix[101:200]
artist_name <- matrix[201:300]
user_score <- matrix[301:400]
release_date <- matrix[401:500]

best_albums <- data.frame(name, metascore, artist_name, user_score, release_date)

readr::write_csv(best_albums, "data/best_albums.csv")

remDr$close()
