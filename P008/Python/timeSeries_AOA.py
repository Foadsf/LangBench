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
#import matplotlib.pyplot as plt            # pyplot module import
#from matplotlib.ticker import ScalarFormatter, FormatStrFormatter
import vertLevels_GEOS5 as pressLevels # local module

def is_leap_year(year):
    """Determine whether a year is a leap year."""
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)

print "-----------------------------"
print "Serial Time Series Processing"
print "-----------------------------"

# Start time
#-----------
start = time.clock()
begTime = dt.datetime.now()

vName = 'aoa'
begYear = 1990
endYear = 2009

firstFile = 0
ref_lat = -86.0

numDays = 0

coef = 365.5

refDIR = '/discover/nobackup/jkouatch/GEOS_CTM/ProductionRuns/runAOA/outFiles/TR/'

# Loop over the years
#--------------------
for year in range(begYear, endYear+1):
    #print "   Processing files for ", year
    dirname = 'Y'+str(year)
    dirY = os.path.join(refDIR,dirname)

    listFiles = glob.glob(dirY+"/runAOA.TR."+str(year)+"*_1200z.nc4")

    numDays += len(listFiles)
    #print numDays

    # Loop over the daily files
    #--------------------------
    for file in listFiles:
        #numDays += 1
        # Open file
        #----------
        nf = Dataset(file, mode='r')

        # Extract information if it is the first file
        #--------------------------------------------
        if firstFile == 0:
           #firstFile = 1
           lons = nf.variables['lon'][:]
           lats = nf.variables['lat'][:]
           levs = nf.variables['lev'][::-1]
           nlons = np.size(lons)
           nlats = np.size(lats)
           nlevs = np.size(levs)

           levs = pressLevels.calcPressureLevels(nlevs)
           lat_index = (np.abs(lats - ref_lat)).argmin()
           #print "lat_index: ", lat_index

           #dataVal   = np.zeros((nlevs))

        # Read the daily average age of air
        #----------------------------------
        var = nf.variables[vName][0,::-1,lat_index,:] / coef

        # Determine the zonal mean
        #-------------------------
        tempVar = np.mean(var,axis=1)

        # Stack the daily values into an existing array
        #----------------------------------------------
        if firstFile == 0:
           firstFile = 1
           dataVal = tempVar
        else:
           dataVal = np.column_stack((dataVal,tempVar))

        #print dataVal.shape

        # Close file
        #-----------
        nf.close()

# End time
#-----------
endTime = dt.datetime.now()
diffTime = endTime - begTime
#finish = time.clock()

print
#print 'Elapsed Time for the time series calculations: ', finish - start,'s'
print 'Elapsed Time for the time series calculations: ', diffTime.total_seconds(),'s'
print

# Verification
# Make sure that the number of files read is 7305
#-------------
if (numDays == 7305):
   print "Successful reading"
else:
   print "Reading as not succcessful"

#sys.exit()

#days = [i+1 for i in range(numDays)]


# Plot the mean at a specified level
#-----------------------------------
#figName  = 'fig_TimeSeries_AgeOfAir'

#X, Y = np.meshgrid(np.array(days), levs)

#fig = plt.figure(figsize=(13,13))

#ax = fig.add_subplot(1,1,1)

#CS = ax.contour(X, Y, dataVal)
#ax.clabel(CS, inline=1, fontsize=10)
#ax.set_title('Age-of-Air (years) at  $86^o$  S')
## y-axis
#ax.set_yscale('log')
#ax.set_ylim(plt.ylim()[::-1])
#ax.set_ylabel('Pressure (hPa)')
#ax.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
#
## x-axis
#x_ticks = [day for day in days if day%365 == 0] # Only pull out full years
#x_labels = [str(i+begYear) for i in range(len(x_ticks))]
#ax.set_xticks(x_ticks)
#ax.set_xticklabels(x_labels)
#ax.set_xlabel('Year')
#ax.xaxis.grid(True)
#

#plt.savefig(figName+'.png')

#plt.show()
