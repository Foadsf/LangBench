#!/usr/bin/env python

import datetime as dt
from numpy import *

import sys
if len(sys.argv) < 1:
	print 'Usage:'
	print '     ./copyMatrix.py dim'
	print 'Please specify matrix dimensions'
	sys.exit()

dim = int(sys.argv[1])

# Copy with loop
#----------------
A = random.rand(dim,dim,3)

begTime = dt.datetime.now()

for i in range(dim):
    for j in range(dim):
        A[i,j,0] = A[i,j,1]
        A[i,j,2] = A[i,j,0]
        A[i,j,1] = A[i,j,2]

endTime = dt.datetime.now()
diffTime = endTime - begTime
print 'Time for copy with loops: ', diffTime.total_seconds(),'s'
print

# Vectorized Copy
#----------------
A = random.rand(dim,dim,3)

begTime = dt.datetime.now()

A[:,:,0] = A[:,:,1]
A[:,:,2] = A[:,:,0]
A[:,:,1] = A[:,:,2]

endTime = dt.datetime.now()
diffTime = endTime - begTime
print 'Time for vectorized copy: ', diffTime.total_seconds(),'s'
print
