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

