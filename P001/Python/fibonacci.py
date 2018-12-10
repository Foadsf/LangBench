#!/usr/bin/env python

import numpy as np
import datetime as dt
import sys

def fibIter(n):
    if n < 2:
       return n
    fibPrev = 1
    fib = 1
    for num in xrange(2, n):
        fibPrev, fib = fib, fib + fibPrev
    return fib

def fibRec(n):
    if n < 2:
       return n
    else:
       return fibRec(n-1) + fibRec(n-2)

if len(sys.argv) < 1:
        print 'Usage:'
        print '     ./"fibonacci.py N'
        print 'Please specify the number of iterations.'
        sys.exit()

N = int(sys.argv[1])

begTime = dt.datetime.now()

n1 = fibIter(N)

endTime = dt.datetime.now()
diffTime = endTime - begTime
print 'Iterative Fibonacci (',N,'):', diffTime.total_seconds(),'s', n1

begTime = dt.datetime.now()

n2 = fibRec(N)

endTime = dt.datetime.now()
diffTime = endTime - begTime
print 'Recursive Fibonacci (',N,'):', diffTime.total_seconds(),'s', n2
