# My first code in GitHub
# Let's install raster packages

#install.packages("raster")

library(raster)

# Importing data (Landsat 2011, Parakana reserve, Brazil, p224r63), setting the working directory
setwd("C:/lab/")

# Import with brick (use "" in order to exit from R). Assign that to object "l2011"   
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
