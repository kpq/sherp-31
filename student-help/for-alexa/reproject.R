setwd("~/Desktop/for-alexa")


library(rgdal)
library(maptools)

shapes <- readShapePoly("shapes/County.shp")
data <- read.csv("scraped-zips.csv")

################
# clean it up
################

data <- data[,2:ncol(data)]
d2 <- data[!duplicated(data),]
d2 <- d2[!is.na(d2$lat),]


# a clean data frame called d2
maptest <- d2


coordinates(maptest) <- c("lng", "lat")
proj4string(maptest) <- CRS("+proj=longlat")


ogrInfo(dsn = "shapes", "County")

proj4string(shapes) <- "+proj=utm +zone=18 +datum=NAD83 +units=m +no_defs "

new_shapes <- spTransform(shapes, CRS("+proj=longlat"))




moo <- readShapeSpatial("shapes/County.shp")