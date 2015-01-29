# Team: Snake Aka Python : Bongani Ngweyama(770708599050), Andronikos Gyrichidis(900718290030)
# Geo-challenge title: Monitoring Drought in Sugar Cane growing areas in Kwazulu Natal province of South Africa using SPI
# January 2015


CreateMonthlySpi <- function(StationsList, month) {
  monthONtable <- month+2
  janSpiFirstStation <- data.frame(StationsList[1])
  entry <- janSpiFirstStation[, c(1,2,monthONtable)]
  valuename <- sprintf("X%i", month)
  MonthlySpi <- cast(entry, id~dates, value = valuename)
  for (i in 2:12) {
    janSpi <- data.frame(StationsList[i])
    entry2 <- janSpi[, c(1,2,monthONtable)]
    valuename <- sprintf("X%i", month)
    secondcast <- cast(entry2, id~dates, value = valuename)
    MonthlySpi <- merge(MonthlySpi, secondcast, all.x = T, all.y = T)
  }
  return(MonthlySpi)
}
