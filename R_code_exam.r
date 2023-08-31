
setwd("C:/lab/")

library(raster)

s2_21_08_r <- raster("T32TQQ_20230821T100601_B02_10m.jp2")
s2_21_08_g <- raster("T32TQQ_20230821T100601_B03_10m.jp2")
s2_21_08_b <- raster("T32TQQ_20230821T100601_B04_10m.jp2")
s2_21_08_nir <- raster("T32TQQ_20230821T100601_B08_10m.jp2")
