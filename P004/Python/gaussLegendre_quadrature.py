
import numpy as np
from scipy import integrate
from numpy import *
import datetime as dt
import sys
 
##################################################################
# The integrand - change as required
f = lambda x: np.exp(x)
##################################################################

if len(sys.argv) < 1:
        print 'Usage:'
        print '     ./gaussLegendre_quadrature.py N'
        print 'Please specify the order of the quadrature.'
        sys.exit()

order = int(sys.argv[1])
a = -3.0
b = 3.0

begTime = dt.datetime.now()

# Gauss-Legendre (default interval is [-1, 1]) 
x, w = np.polynomial.legendre.leggauss(order)
# Translate x values from the interval [-1, 1] to [a, b]
t = 0.5*(x + 1)*(b - a) + a
gauss = sum(w * f(t)) * 0.5*(b - a)

endTime = dt.datetime.now()
diffTime = endTime - begTime
print 'Gauss-Legendre Quad (',order,'):', diffTime.total_seconds(),'s'

# For comparison
quad, quad_err = integrate.quad(f, a, b)

#print 'The QUADPACK solution: {0:.12} with error: {1:.12}'.format(quad, quad_err)
#print 'Gauss-Legendre solution: {0:.12}'.format(gauss)
#print 'Difference between QUADPACK and Gauss-Legendre: ', abs(gauss - quad)


