# This program uses ESA Sentinel 2 data in order to estimate the suspended sediment concentration (SSC) in the Adriatic
# after the 2023 Emilia-Romagna flood.

# Download Sentinel2 images:
# Pre-flood: https://scihub.copernicus.eu/dhus/odata/v1/Products('b0fa8f44-24a7-4522-8483-c3bfd6392495')/$value
# Post-flood: https://scihub.copernicus.eu/dhus/odata/v1/Products('323f8414-ed0f-455b-9e19-4bed1c118778')/$value

# Install and load the needed packages
#install.packages("raster")
#install.packages("ggplot")
#install.packages("viridis")
library(raster)
library(ggplot2)
library(viridis)

# Set working directory to the pre-flood files 
setwd("C:/lab/R10m_23_04") # this works for Windows

# Image before the Emilia-Romagna 2023 flood
rlist_pre <- list.files(pattern="B0") # creates a list of all the elements that have "B0" in common

rimp_pre <- lapply(rlist_pre, raster) # applies a function (raster) to the list previously created

s2_23_04 <- stack(rimp_pre) # stacks all files of the list together
# in this way I obtain an object containing a raster file for each band.

# The following are the bands as acquired by Sentinel 2:
# B02 = b (492.7 nm)
# B03 = g (559.8 nm)
# B04 = r (664.6 nm)
# B08 = NIR (832.8 nm)

# True color image (pre-flood)
cl <- colorRampPalette(c("red", "orange", "yellow")) (100) # creates a color palette for the plot

plotRGB(s2_23_04, r=3, g=2, b=1, stretch="lin") # plotRGB plots all the layers together.
# assign to every color its respective band in order to plot a true color image.

# Switch the red band to NIR in order to make near-infrared band visible in the plot 
plotRGB(s2_23_04, r=4, g=2, b=1, stretch="lin", col=cl)

#----------------------------------------------------------------------------------------------------------------------

# Set the working directory to post-flood files 
setwd("C:/lab/R10m_23_05")

# Image after the Emilia-Romagna 2023 flood
rlist_post <- list.files(pattern="B0") # same passages as in lines 20-24, but with post-flood image
rimp_post <- lapply(rlist_post, raster)
s2_23_05 <- stack(rimp_post) # this file contains all the bands (b, g, r, NIR)

# True color image (post-flood)
plotRGB(s2_23_05, r=3, g=2, b=1, stretch="lin")

# NIR, G, B image
plotRGB(s2_23_05, r=4, g=2, b=1, stretch="lin", col=cl)

# Plot the 2 true color images (pre and post-flood) next to each other
par(mfrow=c(1,2)) # puts the images in 1 line and 2 columns
plotRGB(s2_23_04, r=3, g=2, b=1, stretch="lin", axes=TRUE, main="23/04/2023")
plotRGB(s2_23_05, r=3, g=2, b=1, stretch="lin", axes=TRUE, main="23/05/2023")
dev.off() # closes the plot

#---------------------------------------------------------------------------------------------------------------------

# Estimate the pre-flood SSC (Sutari et al., 2020)
SSC.pre = 30.03*((s2_23_04[[3]] / s2_23_04[[2]])^(3.3187)) # the result is in mg/L

#SSC.pre = 0.4932*exp(4.2145*(s2_23_04[[3]] / s2_23_04[[2]])) # (Zhan et al., 2019)

plot(SSC.pre) # simple plot of SSC.pre

# Estimate the post-flood SSC (Sutari et al., 2020)
SSC = 30.03*((s2_23_05[[3]] / s2_23_05[[2]])^(3.3187)) # the result is in mg/L

#SSC = 0.4932*exp(4.2145*(s2_23_05[[3]] / s2_23_05[[2]])) # (Zhan et al., 2019)

plot(SSC) # simple plot of SSC

# Plot post-flood total SSC map with ggplot2
SSCd <- as.data.frame(SSC, xy=TRUE) # transforms a matrix in a table

head(SSCd) # prints only the first elements of the list.
# There are 3 columns: x coordinate, y coordinate and "layer": the latter represents the SSC previously estimated

ggplot() +
geom_raster(SSCd, mapping=aes(x=x, y=y, fill=layer)) + # you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="cividis") # sets the color scale
# With Viridis packages you can plot with colours visible for everyone


#--------------------------------------------------------------------------------------------------------------------------------
# Let's crop the image using the needed coordinates (pre-flood)
ext <- c(770000, 790000, 4950000, 4970000) # creates a coordinates vector. The coordinates are: x min, x max; y min; y max.
SSC.pre.crop <- crop(SSC.pre, ext) # crops the image using the coordinates in ext

SSC.pre.crop.d <- as.data.frame(SSC.pre.crop, xy=TRUE) # transforms the matrix in a table

# Let's plot the cropped image using ggplot 
ggplot() +
geom_raster(SSC.pre.crop.d, mapping=aes(x=x, y=y, fill=layer)) + # you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/04/2023") # assigns a title to the plot

# Let's crop the image using the needed coordinates (post-flood)
SSC.crop <- crop(SSC, ext) # crops the image

SSC.crop.d <- as.data.frame(SSC.crop, xy=TRUE) # transforms the matrix in a table

# Let's plot the cropped image using ggplot 
ggplot() +
geom_raster(SSC.crop.d, mapping=aes(x=x, y=y, fill=layer)) + # you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/05/2023") # assigns a title to the plot

#--------------------------------------------------------------------------------------------------------------------------------
# Crop number 2 (pre-flood)
ext2 <- c(770000, 790000, 4940000, 4960000) # The coordinates are: x min, x max; y min; y max
SSC.pre.crop2 <- crop(SSC.pre, ext2) # crops the image

SSC.pre.crop2.d <- as.data.frame(SSC.pre.crop2, xy=TRUE) # transforms the matrix in a table

ggplot() +
geom_raster(SSC.pre.crop2.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/04/2023") # assigns a title to the plot

# Crop number 2 (post-flood)
SSC.crop2 <- crop(SSC, ext2) # crops the image

SSC.crop2.d <- as.data.frame(SSC.crop2, xy=TRUE) # transforms the matrix in a table

ggplot() +
geom_raster(SSC.crop2.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC -23/05/2023") # assigns a title to the plot

#----------------------------------------------------------------------------------------------------------------------------------
# Crop number 3 (pre-flood)
ext3 <- c(790000, 810000, 4940000, 4990000) # The coordinates are: x min, x max; y min; y max
SSC.pre.crop3 <- crop(SSC.pre, ext3)

SSC.pre.crop3.d <- as.data.frame(SSC.pre.crop3, xy=TRUE)

ggplot() +
geom_raster(SSC.pre.crop3.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/04/2023")

# Crop number 3 (post-flood)
SSC.crop3 <- crop(SSC, ext3)

SSC.crop3.d <- as.data.frame(SSC.crop3, xy=TRUE)

ggplot() +
geom_raster(SSC.crop3.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/05/2023")

#-----------------------------------------------------------------------------------------------------------------------------------
# Crop number 4 (pre-flood)
ext4 <- c(775000, 790000, 4960000, 4974500) # The coordinates are: x min, x max; y min; y max
SSC.pre.crop4 <- crop(SSC.pre, ext4)

SSC.pre.crop4.d <- as.data.frame(SSC.pre.crop4, xy=TRUE)

ggplot() +
geom_raster(SSC.pre.crop4.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/04/2023")

# Crop number 4 (post-flood)
SSC.crop4 <- crop(SSC, ext4)

SSC.crop4.d <- as.data.frame(SSC.crop4, xy=TRUE)

ggplot() +
geom_raster(SSC.crop4.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/05/2023")

#--------------------------------------------------------------------------------------------------------------------------------------
ext5 <- c(775000, 790000, 4930000, 4950000) # The coordinates are: x min, x max; y min; y max
SSC.pre.crop5 <- crop(SSC.pre, ext5)

SSC.pre.crop5.d <- as.data.frame(SSC.pre.crop5, xy=TRUE)

ggplot() +
geom_raster(SSC.pre.crop5.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/04/2023")

# Crop number 5 (post-flood)
SSC.crop5 <- crop(SSC, ext5)

SSC.crop5.d <- as.data.frame(SSC.crop5, xy=TRUE)

ggplot() +
geom_raster(SSC.crop5.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC - 23/05/2023")
