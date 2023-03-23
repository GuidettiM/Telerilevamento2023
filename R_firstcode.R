# My first code in GitHub
# Let's install raster packages

#install.packages("raster")

library(raster)

# Importing data (Landsat 2011, Parakana reserve, Brazil, p224r63), setting the working directory
setwd("C:/lab/")

# Import with brick (use "" in order to exit from R).Brick creates a raster object. Assign that to object "l2011". Use the .grd file!   
l2011 <- brick("p224r63_2011_masked.grd")

# Plot the data
plot(l2011)
# Change colours (red, orange and yellow), with 100 shades (the more shades we add, the more detailed the image). Assign to object "cl"
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011, col=cl)

# Plot just one element: just the no. 4 band (near infrared band)
plot(l2011[[4]], col=cl)

# Another way for plotting one element. Here we use the name.
plot(l2011$B4_sre, col=cl)

# We also can assign that to "nir" object. This way the code is more clean.
nir <- l2011[[4]]
plot(nir, col=cl)

# Exercise: using strange colours
c2 <- colorRampPalette(c("cyan", "azure", "darkorchid", "aquamarine")) (100)
plot(l2011, col=c2)
# Exercise: plot only the infrared band
plot(l2011[[4]], col=c2)
# or
nir <- l2011$B4_sre
plot(nir, col=c2)

# Export graphs in R
pdf("myfirstgraph.pdf") #creates a pdf file with our plot
plot(nir, col=c2)
dev.off() #closes the window

#Plotting several graphs all at once: multiframe
par(mfrow=c(2,1))
plot(l2011[[3]], col=c2)
plot(l2011[[4]], col=c2)

# Plotting 4 plots in a 2 * 2 multiframe. Each plot with a different colour palette
par(mfrow=c(2,2))
#blue
clb <- colorRampPalette(c("blue4", "blue2", "light blue")) (100)
plot(l2011[[1]], col=clb)
#green
clg <- colorRampPalette(c("chartreuse4", "chartreuse2", "chartreuse")) (100)
plot(l2011[[2]], col=clg)
#rosso
clbr <- colorRampPalette(c("brown4", "brown2", "brown1")) (100)
plot(l2011[[3]], col=clbr)
#infrarosso
clo <- colorRampPalette(c("darkorchid4", "darkorchid2", "aquamarine")) (100)
plot(l2011[[4]], col=clo)
dev.off() # closes the window.

# Day #3

# Plot of l2011 in the NIR channel (NIR band)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)
# or:
plot(l2011[[4]])

# Landsat ETM+
# b1 = blu (1)
# b2 = verde (2)
# b3 = rosso (3)
# b4 = infrarosso vicino NIR (4)

# plot RGB layers. You can only use 3 layers at the time
# stretch is a way for visualizing better image
plotRGB(l2011, r=3, g=2, b=1, stretch="lin") #plot the image with natural colours
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin") 
plotRGB(l2011, r=4, g=3, b=2, stretch="lin") 


plotRGB(l2011, r=3, g=4, b=2, stretch="hist") 

# Exercise: build a multiframe with visible RGB
par(mfrow=c(2,1)) #(2 rows, 1 column)
plotRGB(l2011, r=3, g=2, b=1, stretch="lin") # (linear stretch) on top of false colours
plotRGB(l2011, r=3, g=4, b=2, stretch="hist") # (histogram stretch)
dev.off()

# Exercise: upload the image from 1988
l1988 <- brick("p224r63_1988_masked.grd")
l1988
#plot l1288 in RGB colours with natural colours
plotRGB(l1988, r=3, g=2, b=1, stretch="lin")
#Plot only red
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")

#Plot the 1988 and the 2011 image
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
dev.off()

#exercise plot NIR band
plot(l2011[[4]])

# Exercise: 2 * 2 frame. NIR band.
par(mfrow=c(2,2)) #(2 rows, 2 column)
plotRGB(l1988, r=4, g=3, b=2, stretch="lin") #1988 linear stretch
plotRGB(l2011, r=4, g=3, b=2, stretch="lin") #2011 linear stretch
plotRGB(l1988, r=4, g=3, b=2, stretch="hist") #1988 hist stretch
plotRGB(l2011, r=4, g=3, b=2, stretch="hist") #2011 hist stretch

