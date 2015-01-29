# Team: Snake Aka Python : Bongani Ngweyama(770708599050), Andronikos Gyrichidis(900718290030)
# Geo-challenge title: Monitoring Drought in Sugar Cane growing areas in Kwazulu Natal province of South Africa using SPI
# January 2015


selecting <- function(newrainfal, Stations) {
  x <- Stations$ID[1]
  newdataframe <- newrainfal[newrainfal$ID == x, ]
  newdataframe[ , 4:43] <- list(NULL)
  #newdataframe$MONTH[1:12] <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")
  for (i in 2:12){
    x <- Stations$ID[i]
    record <- newrainfal[newrainfal$ID == x, ]
    record[ , 4:43] <- list(NULL)
    #record$MONTH[1:12] <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")
    newdataframe <- merge(newdataframe, record, all.x = T, all.y = T)
    
  }
  return(newdataframe)
}
