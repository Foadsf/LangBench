#!/usr/bin/env python


import sys
if len(sys.argv) < 1:
	print 'Usage:'
	print '     ./copyMatrix.py dim'
	print 'Please specify matrix dimensions'
	sys.exit()

from numpy import *
from time import *
from numba import jit

dim = int(sys.argv[1])


# Copy with loop
#----------------

@jit
def serial_copy(A):
    for i in range(dim):
        for j in range(dim):
            A[i,j,0] = A[i,j,1]
            A[i,j,2] = A[i,j,0]
            A[i,j,1] = A[i,j,2]
    
@jit
def vectorized_copy(A):
    A[:,:,0] = A[:,:,1]
    A[:,:,2] = A[:,:,0]
    A[:,:,1] = A[:,:,2]


A = random.rand(dim,dim,3)

start = clock()
serial_copy(A)
finish = clock()
print 'Time for copy with loops: ', finish - start,'s'
print

# Vectorized Copy
#----------------
A = random.rand(dim,dim,3)

start = clock()
vectorized_copy(A)
finish = clock()
print 'Time for vectorized copy: ', finish - start,'s'
print
