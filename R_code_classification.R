# Classification of remote sensing data via RStoolbox

#Installing devtools
#install.packages("devtools")

#library(devtools)

#devtools::install_github("bleutner/RStoolbox") #installing a package from Benjamin Bleutner GitHUb
#library(RStoolbox)

library(raster)

setwd("C:/lab/")

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")

# Classifying the solar data

# https://rspatial.org/raster/rs/4-unsupclassification.html

# 1. Get all the single values
singlenr <- getValues(so)
singlenr
#
# set.seed(99)

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values to a raster on the basis of so
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

# set.seed can be used for repeating the experiment in the same manner for N times
# http://rfunction.com/archives/62

####********************************

# day 2 Grand Canyon.
#!! scarica grand canyon earth observatory da virtuale. Salvala in lab


gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

# red = 1
# green = 2
# blue = 3

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# I have a heavy image. Let's crop the image (ritaglio). 
gcc <- crop(gc, drawExtent()) #click on the plot to put the two opposite points of the rectangle

ncell(gcc) #gives the number of cells of my new image
# now I can use the new smaller image for the classification

# change the stretch to histogram stretching
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# classification

# 1. Get values. (tira fuori tutti i valori dai pixel) 
singlenr <- getValues(gcc) # it's a list af all possible values of reflectance (?) 
singlenr

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3) # extracts a centroid for each class and measures the mean distances from it. With "centers" you define the classes. 
kcluster

# 3. Set values
gcclass <- setValues(gcc[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(gcclass, col=cl)

# class 1 = magmatic rocks (not real: it's an example) 
# class 2 = sandstone
# class 3 = conglomerates

frequencies <- freq(gcclass) # how many pixels for each class
tot <- ncell(gcclass) 
percentages = frequencies * 100 /  tot

# Exercise: classify the map with 4 classes
