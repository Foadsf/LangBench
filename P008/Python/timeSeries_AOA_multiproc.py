#!/usr/bin/env python

#-------------
# Load modules
#-------------
import os
import sys
import time
import datetime as dt
from netCDF4 import Dataset
import numpy as np
import glob
import vertLevels_GEOS5 as pressLevels # local module
import multiprocessing

def get_levels(fileName):
    print fileName
    nf = Dataset(fileName, mode='r')
    levs = nf.variables['lev'][::-1]
    nlevs = np.size(levs)
    levs = pressLevels.calcPressureLevels(nlevs)
    nf.close()
    return levs


def getData_from_file(fileName):
    vName = 'aoa'
    ref_lat = -86.0

    coef = 365.5

    nf = Dataset(fileName, mode='r')

    lats = nf.variables['lat'][:]

    lat_index = (np.abs(lats - ref_lat)).argmin()

    # Read the daily average age of air
    #----------------------------------
    var = nf.variables[vName][0,::-1,lat_index,:] / coef

    # Determine the zonal mean
    #-------------------------
    dataVal = np.mean(var,axis=1)

    # Close file
    #-----------
    nf.close()

    return dataVal

numTreads = int(sys.argv[1])

print "-------------------------------"
print "Parallel Time Series Processing", numTreads 
print "-------------------------------"

# Start time
#-----------
#start = time.time()
begTime = dt.datetime.now()

begYear = 1990
endYear = 2009

numDays = 0

#numTreads = 16

myList = []

refDIR = '/discover/nobackup/jkouatch/GEOS_CTM/ProductionRuns/runAOA/outFiles/TR/'
# Loop over the years
#--------------------
for year in range(begYear, endYear+1):
    #print "Processing files for ", year
    dirname = 'Y'+str(year)
    dirY = os.path.join(refDIR,dirname)

    listFiles = glob.glob(dirY+"/runAOA.TR."+str(year)+"*_1200z.nc4")

    numDays += len(listFiles)

    myPool = multiprocessing.Pool(numTreads)
    myArray = myPool.map(getData_from_file, listFiles)
    
    myPool.close()
    myPool.terminate()

    myList.extend(myArray)

#levs = get_levels(listFiles[0])
#
#first = True
#for data in myList:
#    if (first):
#       first = False
#       dataVal = data
#    else:
#       dataVal = np.column_stack((dataVal,data))

# End time
#-----------
#finish = time.time()
endTime = dt.datetime.now()
diffTime = endTime - begTime

print
#print 'Elapsed Time for the time series calculations: ', finish - start,'s'
print 'Elapsed Time for the time series calculations: ', diffTime.total_seconds(),'s'
print

if (numDays == 7305):
    print 'Succesfully processed ', numDays,' files.'
else:
    print 'Only processed',numDays, ' files. Verify that all is well!'

