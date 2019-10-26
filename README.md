# rmetacritic <img src="https://github.com/r-lib/ghactions/blob/master/logo.png?raw=true" width="160px" align="right" />

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
```bash
$ sudo docker pull selenium/standalone-firefox
```

Run:
```bash
$ sudo docker run -d -p 4445:4444 --shm-size 2g selenium/standalone-firefox
```
Now you're ready to use the package.

### Example

```r
best_2018_albums <- rmetacritic::get_best_albums_per_year("2018")
```

## Contributors

[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/0)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/0)[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/1)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/1)[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/2)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/2)[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/3)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/3)[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/4)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/4)[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/5)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/5)[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/6)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/6)[![](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/images/7)](https://sourcerer.io/fame/MatheusHALeal/metalyrics/rmetacritic/links/7)
