library(raster)
library(ggplot2)
library(viridis)
library(patchwork)
setwd("C:/lab/")

sen <- brick("sentinel.png")

plotRGB(sen, 1, 2, 3, stretch="lin")

nir <- sen[[1]]

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) #band, size of the matrix (one pixel on 9 pixels of the matrix, 3 * 3 matrix). fun applies the function standard deviation

plot(sd3)

#plotting with ggplot2
sd3d <- as.data.frame(sd3, xy=TRUE) #you transform a matrix in a tabel

ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis()
# with Viridis packages you can plot with colours visible for everyone

ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="magma") #use the viridis option "magma"

#now add title
ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="magma") + #use the viridis option "magma"
ggtitle("Standard deviation via magma colour scale")

#

#viridis
p1 <- ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="viridis")

#inferno
p2 <- ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="inferno") # #use the viridis option "inferno"

p1+p2
