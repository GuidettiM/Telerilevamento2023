# R code for downloading and visualising Copernicus data

# install.packages("ncdf4")
library(ncdf4)
library(raster)
library(ggplot2)
library(viridis)

setwd("C:/lab/")

# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# dataset: c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc

# load the dataset and assign that to the variable "sc"
sc <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")
plot(sc)

# a better plot with ggplot

scd <- as.data.frame(sc, xy=T) # transform the raster data in a dataframe (è una tabella)

head(scd) # in order to see only the first lines of scd. You can also see only the names with "names()"

ggplot() + #opens a blank window
geom_raster(scd, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) # geometry. aes stands for aesthetics. Use the x and the y of the plot. Fill then the name you find in the last column of scd 

# let's crop the image

ext <- c(23, 30, 62, 68) # the extention I want, the coordinates are: x min, x max; y min; y max
sc.crop <- crop(sc, ext) # crop the sc image with extension previously defined

#plot the cropped image via ggplot
sc.crop.d <- as.data.frame(sc, xy=T)
ggplot()+
geom_raster(sc.crop.d, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))+
scale_fill_viridis(option="cividis")
