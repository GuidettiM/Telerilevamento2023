# Calculate spectral indices

library(raster)

setwd("C:/lab/")

# Exercise: import defor1_.png (LandSat image)
l1992 <- brick("defor1_.png")

# Exercise: plot the image via plotRG
plotRGB(l1992, r=1, g=2, b=3, stretch="lin") #vegetation is red => is NIR. 

# NIR = 1
# RED = 2
# GREEN = 3

# Exercise: calculate DVI for the 1992 image (DVI=NIR-RED for each pixel)
dvi1992 <- l1992[[1]] - l1992[[2]] # you can also use the "=": in this case is a calculation
cl <- colorRampPalette(c('darkblue','yellow','red','black')) (100)
plot(dvi1992, col=cl) # red parts are the ones with greater DVI

# Load ad plot the image from 2006
l2006 <- brick("defor2_.png")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

# Exercise: plot the image from 1992 otop of that of 2006
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")
dev.off()

# Exercise: calculate the DVI for the image from  2006 (use the same color palette from the 1992 one).
dvi2006 <- l2006[[1]] - l2006[[2]]
plot(dvi2006, col=cl)

# Multitemporal analysis
difdvi <- dvi1992 - dvi2006 #difference between the two images' dvi
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

# NDVI 1992
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
plot(ndvi1992, col=cl)

# NDVI 2006
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])
plot(ndvi2006, col=cl)

# Differenza tra i ndvi
difndvi <- ndvi1992 - ndvi2006
plot(difndvi, col=cld)
