library(animation)

#Set delay between frames when replaying
ani.options(interval=.05)

# Set up a vector of colors for use below 
col.range <- heat.colors(15)

# Begin animation loop
# Note the brackets within the parentheses
year <- seq(1997, 2014)
saveGIF((
  for (i in 1:18) {
    plot(Januarymask[[i]], main = sprintf("%i", year[i]))
  }
  ), movie.name = "Januarymask.gif")



saveGIF(for (i in 1:18) {plot(Januarymask[[i]])}, movie.name = "January.gif", img.name = "", convert = "convert", 
        cmd.fun = system, clean = TRUE)
## set some options first
oopt = ani.options(interval = 1, nmax = 50)
## use a loop to create images one by one
for (i in 1:ani.options("nmax")) {
  plot(Januarymask[[i]])
  ani.pause() ## pause for a while ('interval')
}
## restore the options
ani.options(oopt)

saveGIF({
  ani.options(nmax = 50)
  brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
}, interval = 0.05, movie.name = "bm_demo.gif", ani.width = 600, ani.height = 600, convert = "convert")


Year <- seq(1997, 2014)
#z <- 1
#SPI <- JanSpi[z, 6:23 ]
#colors <- c("red", "blue", "green", "yellow", 'black', 'pink', "orange", "grey", "purple", "magenta", "cyan", "gold")
saveGIF((for (i in 1:12) {
  SPI <- JanSpi[i, 6:23]
  plot(Year, SPI, pch = i, type="o",col="red", ylim = c(-2, 5), main = sprintf("%s", JanSpi[i, 2]))
  abline(h = 0)  
}), movie.name = "January.gif")





axis(1, at=1:18, lab=Year)
title(main=sprintf("Yearly SPI for %s", m), col.main="gold", font.main=4)
legend("topleft", names(JanSpi[1:12,1]), cex=0.5, col = colors, pch=1:12, legend = JanSpi$Name, text.width = 1)


