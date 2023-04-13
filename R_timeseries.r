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

#**************************************************************************************************************************************************
# NO2 VALUES IN EUROPE BEFORE AND AFTER LOCKDOWN

setwd("C:/lab/en")

#importing a file (EN_001)
en01 <- raster("EN_0001.png")
cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(en01, col=cl)

#import EN_002
en13 <- raster("EN_0013.png")
plot(en13, col=cl)
cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(en01, col=cl)

en13 <- raster("EN_0013.png")
plot(en13, col=cl)

# Import the whole set altogether

# Exercise: import the whole as in the Greenland example
# by the following steps: list.files, lapply, stack
rlist <- list.files(pattern="EN") # pattern is the common name for all the files

# lapply(X,FUN)
rimp <- lapply(rlist, raster) #applies a function on a list (or on a vector)

# stack
EN <- stack(rimp) # stack files together in a list

# plot everything
plot(EN, col=cl)

# check 1: are the images the same?
par(mfrow=c(1,2))
plot(en01, col=cl)
plot(EN[[1]], col=cl)
dev.off()

# check 2
difcheck <- en01 - EN[[1]]  # difference between images. If it's not = 0 there's a problem!
plot(difcheck) # uniform plot: the difference is = 0
dev.off()

# first and last data
par(mfrow=c(1,2))
plot(EN[[1]], col=cl)
plot(EN[[13]], col=cl)
# difference between the first and the last data
difen = EN[[1]] - EN[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(difen, col=cldif) # red = reduction in NO2 concentration. 

# RGB plot. Element 1 is red and so on
plotRGB(EN, r=1, g=7, b=13, stretch="lin") # linear stretch applies a linear function on the original values in order to chenge the range
plotRGB(EN, r=1, g=7, b=13, stretch="hist") # stronger stretch.
