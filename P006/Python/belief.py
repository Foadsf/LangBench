#!/usr/bin/env python

import numpy as np
import sys
import datetime as dt

# https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/

def beliefprop2(A,x,N):
    for i in range(N):
        x = np.log(np.dot(A, np.exp(x)))
        x -= np.log(np.sum(np.exp(x)))
    return x


if len(sys.argv) < 1:
        print 'Usage:'
        print '     ./belief.py N'
        print 'Please specify the number of iterations.'
        sys.exit()

N = int(sys.argv[1])

begTime = dt.datetime.now()

dim = 5000
A = np.random.rand(dim,dim)
#x = np.zeros((dim))
x = np.ones((dim,))

y = beliefprop2(A,x,N)

endTime = dt.datetime.now()
diffTime = endTime - begTime
print 'Time for belief calculations (',N,'):', diffTime.total_seconds(),'s'

