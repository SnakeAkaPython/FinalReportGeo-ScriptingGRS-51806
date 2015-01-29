# Team: Snake Aka Python : Bongani Ngweyama(770708599050), Andronikos Gyrichidis(900718290030)
# Geo-challenge title: Monitoring Drought in Sugar Cane growing areas in Kwazulu Natal province of South Africa using SPI
# January 2015


# Load Libraries
library(reshape)
library(rgdal)
library(sp)
library(spatstat)
library(spi)
library(gstat)
library(raster)
library(ggplot2)
library(animation)


# calling the functions
source('R/selecting.R')
source("R/CalculateSPI.R")
source('R/CreateMonthlySpi.R')
source('R/CreatingRasterBrick.R')
source('R/CreatingGraphs.R')
source('R/CreatingGif.R')
source('R/CreatingGifMonthly.R')

# Reading data from csv files
Rainfall <- read.csv("data/STATIONS_All Stations (1).csv", header = TRUE)
Stations <- read.csv("data/station.csv", header = TRUE)


# reshape the rainfall data
newrainfal <- cast(Rainfall, ID+NAME+MONTH~YEAR, value = 'RAIN')


# get administative boundries for South Africa and KZN
SouthAfricaAdm <- raster::getData("GADM", country = "ZAF", level = 2)
KznAdm <- SouthAfricaAdm[SouthAfricaAdm$NAME_1 == "KwaZulu-Natal",]


# create spatial points from station coordinates
Station_Points <- cbind(Stations$Longitude, Stations$Latitude)
prj_string_WGS <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
mypoints <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = Stations, match.ID = T)
plot(SouthAfricaAdm[SouthAfricaAdm$NAME_1 == "KwaZulu-Natal",], main = "Stations")
plot(mypoints, add = T, xlab = "Longitude", ylab = "Latitude", col=sample(rainbow(12)))
grid()
box()


# selection of the rainfall data in KZN province and removing the no data years
kznrainfall <- selecting(newrainfal, Stations)


# SPI calculation 
Pongola <- CalculateSPI(kznrainfall, 6)
Mkuze <- CalculateSPI(kznrainfall, 154)
Eshowe <- CalculateSPI(kznrainfall, 142)
Eston <- CalculateSPI(kznrainfall, 458)
Glenside <-CalculateSPI(kznrainfall, 8)
Hibberdene <-CalculateSPI(kznrainfall, 106)
Kearsney <-CalculateSPI(kznrainfall, 129)
Melmoth <-CalculateSPI(kznrainfall, 12)
MtEdgecombe <-CalculateSPI(kznrainfall, 461)
Paddock <-CalculateSPI(kznrainfall, 48)
StLucia <-CalculateSPI(kznrainfall, 452)
Wartburg <-CalculateSPI(kznrainfall, 455)


#### graph representation by changing the file = "Station6.txt"
####spi(7,"Pongola.txt",1997,2014,"S P I - Pongola",1,"years","months")


# Create a monthly Spi table for each month
StationsList <- list(Pongola, Mkuze, Eshowe, Eston, Glenside, Hibberdene, Kearsney, Melmoth, MtEdgecombe, Paddock, StLucia, Wartburg)

Jan <- CreateMonthlySpi(StationsList, 1)
Feb <- CreateMonthlySpi(StationsList, 2)
Mar <- CreateMonthlySpi(StationsList, 3)
Apr <- CreateMonthlySpi(StationsList, 4)
May <- CreateMonthlySpi(StationsList, 5)
Jun <- CreateMonthlySpi(StationsList, 6)
Jul <- CreateMonthlySpi(StationsList, 7)
Aug <- CreateMonthlySpi(StationsList, 8)
Sep <- CreateMonthlySpi(StationsList, 9)
Oct <- CreateMonthlySpi(StationsList, 10)
Nov <- CreateMonthlySpi(StationsList, 11)
Dec <- CreateMonthlySpi(StationsList, 12)


# merge stations with monthly SPI data
JanSpi <- merge(Stations, Jan, by.x = "ID", by.y = "id")
FebSpi <- merge(Stations, Feb, by.x = "ID", by.y = "id")
MarSpi <- merge(Stations, Mar, by.x = "ID", by.y = "id")
AprSpi <- merge(Stations, Apr, by.x = "ID", by.y = "id")
MaySpi <- merge(Stations, May, by.x = "ID", by.y = "id")
JunSpi <- merge(Stations, Jun, by.x = "ID", by.y = "id")
JulSpi <- merge(Stations, Jul, by.x = "ID", by.y = "id")
AugSpi <- merge(Stations, Aug, by.x = "ID", by.y = "id")
SepSpi <- merge(Stations, Sep, by.x = "ID", by.y = "id")
OctSpi <- merge(Stations, Oct, by.x = "ID", by.y = "id")
NovSpi <- merge(Stations, Nov, by.x = "ID", by.y = "id")
DecSpi <- merge(Stations, Dec, by.x = "ID", by.y = "id")


#creatting a spatial data frame for each MOnthly SPI
JanSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = JanSpi, match.ID = T)
FebSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = FebSpi, match.ID = T)
MarSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = MarSpi, match.ID = T)
AprSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = AprSpi, match.ID = T)
MaySpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = MaySpi, match.ID = T)
JunSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = JunSpi, match.ID = T)
JulSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = JulSpi, match.ID = T)
AugSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = AugSpi, match.ID = T)
SepSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = SepSpi, match.ID = T)
OctSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = OctSpi, match.ID = T)
NovSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = NovSpi, match.ID = T)
DecSpiSpatial <- SpatialPointsDataFrame(Station_Points, proj4string=prj_string_WGS, data = DecSpi, match.ID = T)



# Rasterize the SPI data, first define the grid extent:
x.range <- as.numeric(c(30.2667, 32.2833))  # min/max longitude of the interpolation area based on mypoints
y.range <- as.numeric(c(-30.75, -25.55))  # min/max latitude of the interpolation area based on mypoints


#Create a data frame from all combinations of the supplied vectors or factors. Set spatial coordinates to create a Spatial object. Assign gridded structure:
grd <- expand.grid(x = seq(from = x.range[1], to = x.range[2], by = 0.1), y = seq(from = y.range[1], to = y.range[2], by = 0.1))  # expand points to grid
coordinates(grd) <- ~ x + y
crs(grd) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
gridded(grd) <- TRUE


# Create the monthly raster brick for all the years(1997-2014)
January <- CreatingRasterBrick(JanSpi, mypoints)
February <- CreatingRasterBrick(FebSpi, mypoints)
March <- CreatingRasterBrick(MarSpi, mypoints)
April <- CreatingRasterBrick(AprSpi, mypoints)
May <- CreatingRasterBrick(MaySpi, mypoints)
June <- CreatingRasterBrick(JunSpi, mypoints)
July <- CreatingRasterBrick(JulSpi, mypoints)
August <- CreatingRasterBrick(AugSpi, mypoints)
September <- CreatingRasterBrick(SepSpi, mypoints)
October <- CreatingRasterBrick(OctSpi, mypoints)
November <- CreatingRasterBrick(NovSpi, mypoints)
December <- CreatingRasterBrick(DecSpi, mypoints)


# mask the raster brick using KZN boundries
Januarymask <- mask(January, KznAdm)
Februarymask <- mask(February, KznAdm)
Marchmask <- mask(March, KznAdm)
Aprilmask <- mask(April, KznAdm)
Maymask <- mask(May, KznAdm)
Junemask <- mask(June, KznAdm)
Julymask <- mask(July, KznAdm)
Augustmask <- mask(August, KznAdm)
Septembermask <- mask(September, KznAdm)
Octobermask <- mask(October, KznAdm)
Novembermask <- mask(November, KznAdm)
Decembermask <- mask(December, KznAdm)

MonthsNames <- list("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
# Animation presenation of the raster brick for every month

CreatingGifMonthly(Januarymask, MonthsNames[1], KznAdm)
CreatingGifMonthly(Februarymask, MonthsNames[2], KznAdm)
CreatingGifMonthly(Marchmask, MonthsNames[3], KznAdm)
CreatingGifMonthly(Aprilmask, MonthsNames[4], KznAdm)
CreatingGifMonthly(Maymask, MonthsNames[5], KznAdm)
CreatingGifMonthly(Junemask, MonthsNames[6], KznAdm)
CreatingGifMonthly(Julymask, MonthsNames[7], KznAdm)
CreatingGifMonthly(Augustmask, MonthsNames[8], KznAdm)
CreatingGifMonthly(Septembermask, MonthsNames[9], KznAdm)
CreatingGifMonthly(Octobermask, MonthsNames[10], KznAdm)
CreatingGifMonthly(Novembermask, MonthsNames[11], KznAdm)
CreatingGifMonthly(Decembermask, MonthsNames[12], KznAdm)
# Plot the SPI trend in graph for each month
par(mfrow = c(3, 1))
# plot the SPI trend for Summer
GraphDec <- CreatingGraphs(DecSpi, "December")
GraphJan <- CreatingGraphs(JanSpi, "January")
GraphFeb <- CreatingGraphs(FebSpi, "February")
# plot the SPI trend for Autumn
GraphMar <- CreatingGraphs(MarSpi, "March")
GraphApr <- CreatingGraphs(AprSpi, "April")
GraphMay <- CreatingGraphs(MaySpi, "May")
# plot the SPI trend for Winter
GraphJun <- CreatingGraphs(JunSpi, "June")
GraphJul <- CreatingGraphs(JulSpi, "July")
GraphAug <- CreatingGraphs(AugSpi, "August")
# plot the SPI trend for Spring
GraphSep <- CreatingGraphs(SepSpi, "September")
GraphOct <- CreatingGraphs(OctSpi, "October")
GraphNov <- CreatingGraphs(NovSpi, "November")
par(mfrow = c(1, 1))


# Ploting a Spi animation of the graph per station
CreatingGif(JanSpi, "January")
CreatingGif(FebSpi, "February")
CreatingGif(MarSpi, "March")
CreatingGif(AprSpi, "April")
CreatingGif(MaySpi, "May")
CreatingGif(JunSpi, "June")
CreatingGif(JulSpi, "July")
CreatingGif(AugSpi, "August")
CreatingGif(SepSpi, "September")
CreatingGif(OctSpi, "October")
CreatingGif(NovSpi, "November")
CreatingGif(DecSpi, "December")

