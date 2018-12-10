import numpy
import sys
def test_python(iterations):
    element = 0
    iteration = 0
    innerloop = 0
    total = numpy.float64(0.0)
    array_length = 100000000
    array = numpy.zeros(array_length, numpy.float64)
    print 'iterations', iterations
    while element < array_length:
        array[element] = element
        element += 1
    while iteration < iterations:
        innerloop = 0
        while innerloop < 1000000000:
            total += array[(iteration + innerloop) % array_length];
            innerloop += 1
        iteration += 1
    print 'sum', total
    del array
