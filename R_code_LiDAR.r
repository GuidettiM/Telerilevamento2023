# 3D in R
setwd("C:/lab/dati")

library(ggplot2)
library(viridis)
library(raster)

# DSM
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")

dsm_2013d <- as.data.frame(dsm_2013, xy=T)

ggplot()+
geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalElevationModel.0.5m))+
scale_fill_viridis()+
ggtitle("dsm_2013")

#DTM
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")

dtm_2013d <- as.data.frame(dtm_2013, xy=T)

ggplot()+
geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalTerrainModel.0.5m))+
scale_fill_viridis(option="magma")+
ggtitle("dtm_2013")

