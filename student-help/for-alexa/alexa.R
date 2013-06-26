setwd("~/Desktop/for-alexa")

library(XML)
library(RJSONIO)

getAttribute <- function(str, json) {
  return (sapply(json, function(x) { x[[str]] }))
}

zipsraw <- read.delim("data/nyzips.txt")
zip5s <- sprintf("%05d", zipsraw$raw)
base <- "http://www.fight4rx.org/map/getpharms3.php?address="

data <- NULL
for (i in 1:length(zip5s)) {

  print(paste(i, length(zip5s), sep="/" ) )
  zip <- zip5s[i]
  url <- paste(base, zip, sep="")

  ftry <- try(fromJSON(readLines(url)), silent=T)

  if("try-error" %in% class(ftry))  {
    df <- data.frame(zip=zip, name=NA, addr=NA, lat=NA, lng=NA, city=NA)
  } else {
    print("all good")
  first <- ftry[[1]]
  zips <-   getAttribute("id", first)
  names <-  getAttribute("name", first)
  addresses <-  getAttribute("address", first)
  lats <-  getAttribute("lat", first)
  lngs <-  getAttribute("lng", first)
  cities <- getAttribute("city", first)
  # make a df
  df <- data.frame(zip=zips, name=names, addr=addresses, lat=lats, lng=lngs, city=cities)
  }

    # make the data

  #join to the main table
  data <- rbind(data, df)

}





