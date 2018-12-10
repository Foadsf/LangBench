#!/usr/bin/env python

#-------------
# Load modules
#-------------
import os
import sys
import time
import glob

# Start time
#-----------
start = time.clock()

begYear = 1990
endYear = 2009


numDays = 0

# Loop over the years
#--------------------
for year in range(begYear, endYear+1):
    print "Processing files for ", year
    dirY = '/discover/nobackup/jkouatch/GEOSctmProduction/AOArun_new/holding/TR/'+ str(year)

    # Loop over the months
    #---------------------
    #for month in range(1,13):
    for month in range(1,13):
        dirM = dirY+str(month).zfill(2)+'/'
        listFiles = glob.glob(dirM+"AOArun.TR."+str(year)+str(month).zfill(2)+"*_1200z.nc4")

        numDays += len(listFiles)

finish = time.clock()

print
print 'Number of files: ', numDays
print
print 'Elapsed Time for the time series calculations: ', finish - start,'s'
print
