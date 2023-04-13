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
