CreatingGifMonthly <- function(monthlyMask, outputname, boundries) {
  year <- seq(1997, 2014)
  saveGIF((
    for (i in 1:18) {
      plot(monthlyMask[[i]], main = sprintf("%s-%i", outputname,year[i]))
      plot(boundries, add = T)
      }
    ), movie.name = sprintf("%sYearlySpi.gif", outputname))
}


