
setwd("C:/lab/R10m_23_04")
# Load the needed packages
library(raster)

# Import needed data from "R10m_21_08" folder 
#s2_21_08_r <- raster("T32TQQ_20230821T100601_B02_10m.jp2")
#s2_21_08_g <- raster("T32TQQ_20230821T100601_B03_10m.jp2")
#s2_21_08_b <- raster("T32TQQ_20230821T100601_B04_10m.jp2")
#s2_21_08_nir <- raster("T32TQQ_20230821T100601_B08_10m.jp2")

# Image before the Emilia-Romagna 2023 flood
rlist_pre <- list.files(pattern="B0") #creates a list of all elements that have "B0" in common

rimp_pre <- lapply(rlist_pre, raster) #applies a function (raster) to the list previously created

s2_23_04 <- stack(rimp_pre) #stacks all files of the list together

# B02 = b (492.7 nm)
# B03 = g (559.8 nm)
# B04 = r (664.6 nm)
# B08 = NIR (832.8 nm)

# True color image (pre-flood)
plotRGB(s2_23_04, r=3, g=2, b=1, stretch="lin") 

