#!/usr/bin/env python

import sys
import numpy as np
import datetime as dt

# https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/


def f(x):
    return np.exp(np.sin(x[0]*5) - x[0]*x[0] - x[1]*x[1])

def mcmc(x,N):
   p = f(x)
   for n in range(N): 
       x2 = x + .01*np.random.randn(x.size)
       p2 = f(x2)
       if (np.random.rand() < (p2/p)):
          x = x2
          p = p2
   return x

begTime = dt.datetime.now()

import sys
if len(sys.argv) < 1:
        print 'Usage:'
        print '     ./"markovChain.py N'
        print 'Please specify the number of iterations.'
        sys.exit()

N = int(sys.argv[1])
x = np.zeros((2))

y = mcmc(x,N)

endTime = dt.datetime.now()
diffTime = endTime - begTime
print 'Time for Markov Chain calculations (',N,'):', diffTime.total_seconds(),'s'
