#

# Download Sentinel2 images:
# Pre-flood: https://scihub.copernicus.eu/dhus/odata/v1/Products('b0fa8f44-24a7-4522-8483-c3bfd6392495')/$value
# Post-flood: https://scihub.copernicus.eu/dhus/odata/v1/Products('323f8414-ed0f-455b-9e19-4bed1c118778')/$value

# Install and load the needed packages
#install.packages("raster")
library(raster)
library(ggplot2)
library(viridis)

# Set working directory to the pre-flood files
setwd("C:/lab/R10m_23_04")

# Image before the Emilia-Romagna 2023 flood
rlist_pre <- list.files(pattern="B0") #creates a list of all elements that have "B0" in common

rimp_pre <- lapply(rlist_pre, raster) #applies a function (raster) to the list previously created

s2_23_04 <- stack(rimp_pre) #stacks all files of the list together

# B02 = b (492.7 nm)
# B03 = g (559.8 nm)
# B04 = r (664.6 nm)
# B08 = NIR (832.8 nm)

# True color image (pre-flood)
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plotRGB(s2_23_04, r=3, g=2, b=1, stretch="lin") # plotRGB plots all the layers together

plotRGB(s2_23_04, r=4, g=2, b=1, stretch="lin", col=cl)

#-------------------------------------------------------------------------------------------------

# Set the working directory to post-flood files 
setwd("C:/lab/R10m_23_05")

# Image after the Emilia-Romagna 2023 flood
rlist_post <- list.files(pattern="B0") # same passages as in lines 15-19, but with post-flood image
rimp_post <- lapply(rlist_post, raster)
s2_23_05 <- stack(rimp_post)

# True color image
plotRGB(s2_23_05, r=3, g=2, b=1, stretch="lin")

# NIR, G, B image
plotRGB(s2_23_05, r=4, g=2, b=1, stretch="lin", col=cl)

# Plot the 2 true color images next to each other
par(mfrow=c(1,2))
plotRGB(s2_23_04, r=3, g=2, b=1, stretch="lin")
plotRGB(s2_23_05, r=3, g=2, b=1, stretch="lin")
dev.off()

# Estimate the SSC (Zhan et al., 2019)
#SSC <- 0.4932*exp(4.2145*(s2_23_05[[3]] / s2_23_05[[2]]))
#plot(SSC, col=cl)

# Estimate the SSC (Sutari et al., 2020)
SSC = 30.03*(s2_23_05[[3]] / s2_23_05[[2]])^(3.3187) 

#plotting with ggplot2
SSCd <- as.data.frame(SSC, xy=TRUE) #you transform a matrix in a tabel
#names(SSCd) <- c("x", "y", "z") # change the third variable name from "layer" to "SSC (mg/L)" 
head(SSCd)

ggplot() +
geom_raster(SSCd, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="cividis")
# with Viridis packages you can plot with colours visible for everyone

# Let's crop the image using the needed coordinates 
ext <- c(770000, 790000, 4950000, 4970000) # The coordinates are: x min, x max; y min; y max
SSC.crop <- crop(SSC, ext)

SSC.crop.d <- as.data.frame(SSC.crop, xy=TRUE)

ggplot() +
geom_raster(SSC.crop.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")+
ggtitle("SSC (mg/L)")

# Crop number 2
ext2 <- c(770000, 790000, 4940000, 4960000) # The coordinates are: x min, x max; y min; y max
SSC.crop2 <- crop(SSC, ext2)

SSC.crop2.d <- as.data.frame(SSC.crop2, xy=TRUE)

ggplot() +
geom_raster(SSC.crop2.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")

# Crop number 3
ext3 <- c(790000, 810000, 4940000, 4990000) # The coordinates are: x min, x max; y min; y max
SSC.crop3 <- crop(SSC, ext3)

SSC.crop3.d <- as.data.frame(SSC.crop3, xy=TRUE)

ggplot() +
geom_raster(SSC.crop3.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")

# Crop number 4
ext4 <- c(775000, 790000, 4960000, 4974500) # The coordinates are: x min, x max; y min; y max
SSC.crop4 <- crop(SSC, ext4)

SSC.crop4.d <- as.data.frame(SSC.crop4, xy=TRUE)

ggplot() +
geom_raster(SSC.crop4.d, mapping=aes(x=x, y=y, fill=layer)) + #you find "layer" in sd3 info: it's the object you want to paint. 
scale_fill_viridis(option="turbo")
