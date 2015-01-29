# Team: Snake Aka Python : Bongani Ngweyama(770708599050), Andronikos Gyrichidis(900718290030)
# Geo-challenge title: Monitoring Drought in Sugar Cane growing areas in Kwazulu Natal province of South Africa using SPI
# January 2015


# select rainfall data for all the stations in KZN based on station.csv 
CalculateSPI <- function(kznrainfall, id) {
  StationID <- subset(kznrainfall, kznrainfall$ID == id)
  StationID[, 1:2] <- list(NULL)
  
  
  # calculate SPI from rainfall data
  filename <- sprintf("Station%i.txt", id)
  write.table(StationID, file = filename, quote = FALSE, row.names = TRUE)
  SPI_Results <- spi(nargs = 3, filename, id = 1997, fd = 2014, output = 1)
  iddf <- data.frame(id)
  SPI_Results <- cbind(iddf, SPI_Results)
  return(SPI_Results)  
}


