# Analyze TCC long term trend
# Author: Yawen Zhang
# Date: Nov.4, 2016

library(plyr)

# Remove all objects 
rm(list = ls())
# Set working directory
WD <- '/Users/yawen/Desktop/Cloud - missing data effect/China_outputs'
setwd(WD)

# Read surface TCC data
TCC_sur = list.files(WD)
SYNOP_TCC = matrix(nrow = 35, ncol = 2)
SYNOP_TCC[, 2] = 0
SYNOP_TCC[, 1] = seq(1980, 2014, by = 1)

# length(TCC_sur)
# Export data

for (i in 1:length(TCC_sur)){
  # read table
  TCC_each = read.fwf(TCC_sur[i], widths = c(5, 5, 3, 3, 3, 6, 7, 6, 4, 2, 6, 2, 6, 2), col.names = c("ID", "YEAR", "MONTH", "DAY", "HOUR", "LAT", "LON", "HEIGHT", "TCC", "TCC_CHECK", "VIS", "VIS_CHECK", "LOW_HEIGHT", "LOW_HEIGHT_CHECK"))

  # select data for analysis
  TCC_each$LAT = TCC_each$LAT / 100
  TCC_each$LON = TCC_each$LON / 100
  TCC_each$HEIGHT = TCC_each$HEIGHT / 10
  
  # select TCC_check == 8
  SYNOP_TCC_MISSING_DATA = subset(TCC_each, TCC_each$TCC_CHECK == 8)
  
  # add missing nrow to SYNOP_TCC
  n = which(SYNOP_TCC[, 1] == substr(TCC_sur[i], 5, 8))
  SYNOP_TCC[n, 2] = SYNOP_TCC[n, 2] + nrow(SYNOP_TCC_MISSING_DATA)

  print(TCC_sur[i])
}

write.table(SYNOP_TCC, "SYNOP_TCC_MISSING_DATA_SUMMARIZE_YEAR.txt")

