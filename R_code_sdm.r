# R code for species distribution modeling

# install.packages("sdm")
# install.packages("rgdal")

library(sdm)
library(rgdal) # species
library(raster) # predictors

# system.file 
file <- system.file("external/species.shp", package="sdm") # to get the path that leads us to the data
species <- shapefile(file) # "raster" function: read or write a shapefile

plot(species, pch=19) # pch =19 is for the dots instead of crosses.

# let's plot only the presences
presences <- species[species$Occurrence==1,] # I want only the points with occurrance=1

plot(presences, col="blue", pch=19)

# let's do the same but with absences only
absences <- species[species$Occurrence==0,]

plot(absences, col="red", pch=19)

# plot both together
plot(presences, col="blue", pch=19)
points(absences, col="red", pch=19) # points function adds points to a pre-existing plot

# Predictors: ambiental variables
path <- system.file("external", package="sdm") # look at the path
path # .asc = ascii files. There are 4 files: elevation, precipitation, temperature, vegetation(ndvi index)

lst <- list.files(path, pattern='asc$', full.names = T) # create a list of the predictors

preds <- stack(lst)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# Plot the elevation and the presences
plot(preds$elevation, col=cl)
points(presences, pch=19) #this specie loves low altitudes!

# with temperature
plot(preds$temperature, col=cl)
points(presences, pch=19)

# with precipitation
plot(preds$precipitation, col=cl)
points(presences, pch=19) # this amphibian loves hmid areas

# with vegetation
plot(preds$vegetation, col=cl)
points(presences, pch=19)

# Let's do a model with the continuous presence of the specie in space

#model
#set the data for the sdm
#ambiental data= predectors; species data=train data
datasdm <- sdmData(train=species, predictors=preds)

# Now let's create the model
# linear model: x=temperature, y=occurrence. Then with elevation.
# if the variables are all together, it's called 
m1 <- sdm(Occurrence ~ temperature + elevation + precipitation + vegetation, data=datasdm, method="glm") #the ~ stands for =

p1 <- predict(m1, newdata=preds)
plot(p1, col=cl) #prediction map of the specie
points(presences, pch=19)

names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
s1 <- stack(preds, p1)
plot(s1, col=cl)

# that's similar to machine learning

