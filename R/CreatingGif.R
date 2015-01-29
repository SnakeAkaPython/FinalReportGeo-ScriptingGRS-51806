CreatingGif <- function(monthSpi, monthName) {
  Year <- seq(1997, 2014)
  saveGIF((for (i in 1:12) {
    SPI <- monthSpi[i, 6:23]
    plot(Year, SPI, pch = i, type="o",col="red", ylim = c(-2, 3), main = sprintf("%s(%s)", monthName, monthSpi[i, 2]))
    abline(h = 0)  
  }), movie.name = sprintf("%s.gif", monthName))
}
