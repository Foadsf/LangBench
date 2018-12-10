#!/usr/bin/env python

import datetime as dt
from numpy import *
import sys

if len(sys.argv) < 2:
	print 'Usage:'
	print '     ./matMult.py dim1 dim2 dim3'
	print 'Please specify matrix dimensions'
	sys.exit()


dim1 = int(sys.argv[1])
if len(sys.argv) < 3:
	dim2 = dim1
else:
	dim2 = int(sys.argv[2])
if len(sys.argv) < 4:
	dim3 = dim1
else:
	dim3 = int(sys.argv[3])

A = random.rand(dim1,dim2)
B = random.rand(dim2,dim3)

begTime = dt.datetime.now()

C = dot(A,B)

endTime = dt.datetime.now()
diffTime = endTime - begTime

print 'time for','C'+str(shape(C)),'=','A'+str(shape(A)),'B'+str(shape(B)),'is', diffTime.total_seconds(),'s'
