# rmetacritic

[![Build Status](https://travis-ci.org/metalyrics/rmetacritic.svg?branch=master)](https://travis-ci.org/metalyrics/rmetacritic)


This package includes a series of functions that give R users access to ["Metacritic's"](https://www.metacritic.com) data. These data are obtained by scraping their website.

## Installation

To install the most updated version from GitHub, type:

```
library(devtools)
devtools::install_github("metalyrics/rmetacritic")
```

## Usage

First, you'll need docker on your pc.

Pull the browser's image:
```
docker pull selenium/standalone-firefox
```

Run:
```
sudo docker run -d -p 4445:4444 selenium/standalone-firefox
```
Now you're ready to use the package.

### Example

```r
best_2018_albums <- rmetacritic::get_best_albums_per_year("2018")
```
