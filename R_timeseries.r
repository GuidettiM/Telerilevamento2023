# R code for importing and analysing several images

library(raster)

setwd("C:/lab/greenland")

# Import layers
lst_2000 <- raster("lst_2000.tif")

# Exercise: import all the data from "greenland" folder
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

#you also import the with this function: you apply the "raster" function on a list.
rlist <- list.files(pattern="lst") #creates a list of the files inside the folder. The pattern is something that's common on all data
import <- lapply(rlist, raster)
