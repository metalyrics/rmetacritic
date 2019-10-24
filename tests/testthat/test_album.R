context('album')
library(testthat)

best_albums_2019 <- get_best_albums_per_year("2019")
best_albums_2018 <- get_best_albums_per_year("2018")
best_albums_2000 <- get_best_albums_per_year("2000")

critic_albums_ultraviolence <- get_album_critic_reviews("Ultraviolence", "Lana del Rey")
critic_albums_25 <- get_album_critic_reviews("25", "Adele")

link_album_per_year <- paste0(WEBSITE_URL, ALBUMS_PER_YEAR_URL)
link_album_critic <- paste0(WEBSITE_URL, MUSIC)

ultraviolence <- critic_albums_ultraviolence %>% head(1)
CONSEQUENCE_OF_SOUND_PUBLI <- "Consequence of Sound"
CONSEQUENCE_OF_SOUND_DATE <- as.Date("2014-06-17")
CONSEQUENCE_OF_SOUND_SCORE <- "100"
CONSEQUENCE_OF_SOUND_REVIEW <- "The characters and artifacts that surround these songs feel artificial, like stock props, but the music that Del Rey pulls them through splits them open, shakes them to life."

test_that("Is dataframe", {
  expect_true(is.data.frame(best_albums_2000))
  expect_true(is.data.frame(best_albums_2018))
  expect_true(is.data.frame(best_albums_2019))

  expect_true(is.data.frame(critic_albums_ultraviolence))
  expect_true(is.data.frame(critic_albums_25))
})

test_that("Not empty", {
  expect_true(nrow(best_albums_2000) != 0)
  expect_true(nrow(best_albums_2018) != 0)
  expect_true(nrow(best_albums_2019) != 0)

  expect_true(nrow(critic_albums_ultraviolence) != 0)
  expect_true(nrow(critic_albums_25) != 0)
})

test_that("Dataframe complete", {
  expect_true(nrow(best_albums_2000) == 100)
  expect_true(nrow(best_albums_2018) == 100)
  expect_true(nrow(best_albums_2019) == 100)
})

test_that("Publication album", {
  expect_equal(as.character(ultraviolence$publication), CONSEQUENCE_OF_SOUND_PUBLI)
})

test_that("Date album", {
  expect_equal(ultraviolence$date, CONSEQUENCE_OF_SOUND_DATE)
})

test_that("Score album", {
  expect_equal(as.character(ultraviolence$score), CONSEQUENCE_OF_SOUND_SCORE)
})

test_that("Review album", {
  expect_equal(as.character(ultraviolence$review), CONSEQUENCE_OF_SOUND_REVIEW)
})

