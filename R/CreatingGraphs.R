# Team: Snake Aka Python : Bongani Ngweyama(770708599050), Andronikos Gyrichidis(900718290030)
# Geo-challenge title: Monitoring Drought in Sugar Cane growing areas in Kwazulu Natal province of South Africa using SPI
# January 2015

CreatingGraphs <- function(JanSpi, m) {
  Year <- seq(1997, 2014)
  z <- 1
  SPI <- JanSpi[z, 6:23 ]
  colors <- c("red", "blue", "green", "yellow", 'black', 'pink', "orange", "grey", "purple", "magenta", "cyan", "gold")
  for (i in 1:11) {
    if (i == 1) {
      plot(Year, SPI, pch = z, type="o",col=colors[z], ylim = c(-2, 5))
    }
    z <- z + 1
    SPI <- JanSpi[z, 6:23]
    lines(Year, SPI, pch = z, type = "o", col=colors[z])
    abline(h = 0)  
  }
  axis(1, at=1:18, lab=Year)
  title(main=sprintf("Yearly SPI for %s", m), col.main="gold", font.main=4)
  legend("topleft", names(JanSpi[1:12,1]), cex=0.5, col = colors, pch=1:12, legend = JanSpi$Name, text.width = 3)
  
}



