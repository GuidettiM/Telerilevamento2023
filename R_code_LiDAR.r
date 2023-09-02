# 3D in R
setwd("C:/lab/dati")

library(ggplot2)
library(viridis)
library(raster)
library(patchwork)

# DSM
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif") # create the raster file

dsm_2013d <- as.data.frame(dsm_2013, xy=T) # transform the raster file in a data frame file

names(dsm_2013d) <- c("x", "y", "z") # change the z variable name
head(dsm_2013d) # now the z name is way simpler!

ggplot()+
geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=z))+ # find the fill name in head(dsm_2013d)
scale_fill_viridis()+
ggtitle("dsm_2013")


#DTM
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")

dtm_2013d <- as.data.frame(dtm_2013, xy=T)

names(dtm_2013d) <- c("x", "y", "z") # change the z variable name
head(dtm_2013d) # now the z name is way simpler

ggplot()+
geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=z))+ # find the fill name in head(dtm_2013d)
scale_fill_viridis(option="magma")+
ggtitle("dtm_2013")

chm2013 <- dsm_2013 - dtm_2013

chm2013d <- as.data.frame(chm2013, xy=T)

ggplot()+
geom_raster(chm2013d, mapping=aes(x=x, y=y, fill=layer))+ # find the fill name in head(dtm_2013d)
scale_fill_viridis()+
ggtitle("chm2013")

# you can import the 2004 dataset and calculate the difference between chm of 2004 and the one of the 2013

# plot all of the three variables
p1 <- ggplot()+
geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=z))+ # find the fill name in head(dsm_2013d)
scale_fill_viridis()+
ggtitle("dsm_2013")

p2 <- ggplot()+
geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=z))+ # find the fill name in head(dtm_2013d)
scale_fill_viridis(option="magma")+
ggtitle("dtm_2013")

p3 <- ggplot()+
geom_raster(chm2013d, mapping=aes(x=x, y=y, fill=layer))+ # find the fill name in head(dtm_2013d)
scale_fill_viridis()+
ggtitle("chm2013")

p1 + p2 + p3
