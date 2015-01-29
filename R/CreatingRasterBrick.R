# Team: Snake Aka Python : Bongani Ngweyama(770708599050), Andronikos Gyrichidis(900718290030)
# Geo-challenge title: Monitoring Drought in Sugar Cane growing areas in Kwazulu Natal province of South Africa using SPI
# January 2015


CreatingRasterBrick <- function(MonthSpi, mypoints) {
  # Define the grid extent:  
  x.range <- as.numeric(c(30.2667, 32.2833))  # min/max longitude of the interpolation area
  y.range <- as.numeric(c(-30.75, -25.55))  # min/max latitude of the interpolation area
  
  
  #Create a data frame from all combinations of the supplied vectors or factors. Set spatial coordinates to create a Spatial object. Assign gridded structure:
  grd <- expand.grid(x = seq(from = x.range[1], to = x.range[2], by = 0.1), y = seq(from = y.range[1], to = y.range[2], by = 0.1))  # expand points to grid
  coordinates(grd) <- ~ x + y
  crs(grd) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
  gridded(grd) <- TRUE
  
  Years <- 1997
  SpiYearBrick <- brick()
  for (z in 1:18) {
    col <- z + 5
    idw <- idw(formula = MonthSpi[,col] ~ 1, locations = mypoints, newdata = grd)  # apply idw model for the data
    gridded(idw) <- TRUE
    YearLayer <- raster(idw)
    SpiYearBrick <- addLayer(SpiYearBrick, YearLayer)
    names(SpiYearBrick[[z]]) <- sprintf("%i", Years)
    Years <- Years + 1
  }
  return(SpiYearBrick)
}

