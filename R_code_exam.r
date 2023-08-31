
setwd("C:/lab/R10m_21_08")
# Load the needed packages
library(raster)

# Import needed data from "R10m_21_08" folder 
#s2_21_08_r <- raster("T32TQQ_20230821T100601_B02_10m.jp2")
#s2_21_08_g <- raster("T32TQQ_20230821T100601_B03_10m.jp2")
#s2_21_08_b <- raster("T32TQQ_20230821T100601_B04_10m.jp2")
#s2_21_08_nir <- raster("T32TQQ_20230821T100601_B08_10m.jp2")


rlist <- list.files(pattern="B0") #creates a list of all elements that have "B0" in common

rimp <- lapply(rlist, raster) #applies a function (raster) to the list previously created

s2_21_08 <- stack(rimp) #stacks all files of the list together
