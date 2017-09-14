# Read CSV into R
MyData <- read.csv(file="data/Wed_Aug__2_15_18_08_2017_GPS_test.csv", header=TRUE, sep=",")

# References:
# http://lists.maptools.org/pipermail/proj/2001-September/000248.html (has typos)
# http://www.remotesensing.org/geotiff/proj_list/swiss_oblique_cylindrical.html
#
# Input coordinates.
#
x <- c(7.173500, 7.172540, 7.171636, 7.180180, 7.178070, 7.177229, 7.175240, 7.181409, 7.179299)
y <- c(45.86880, 45.86887, 45.86924, 45.87158, 45.87014, 45.86923, 45.86808, 45.87177, 45.87020)
#
# Define the coordinate systems.
#
library(rgdal)
d <- data.frame(lon=x, lat=y)
coordinates(d) <- c("lon", "lat")
proj4string(d) <- CRS("+init=epsg:4326") # WGS 84
CRS.new <- CRS("+proj=somerc +lat_0=46.9524056 +lon_0=7.43958333 +ellps=bessel +x_0=2600000 +y_0=1200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +no_defs")
# (@mdsumner points out that
#    CRS.new <- CRS("+init=epsg:2056")
# will work, and indeed it does. See http://spatialreference.org/ref/epsg/2056/proj4/.)
d.ch1903 <- spTransform(d, CRS.new)
#
# Plot the results.
#
par(mfrow=c(1,3))
plot.default(x,y, main="Raw data", cex.axis=.95)
plot(d, axes=TRUE, main="Original lat-lon", cex.axis=.95)
plot(d.ch1903, axes=TRUE, main="Projected", cex.axis=.95)
unclass(d.ch1903)
