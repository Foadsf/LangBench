import sys
from libc.stdlib cimport malloc, free
def test_cython(iterations):
    cdef int element = 0
    cdef int iteration = 0
    cdef int innerloop = 0
    cdef double total = 0.0
    cdef int array_length = 100000000
    cdef double *array = <double *>malloc(array_length * sizeof(double))
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
    free(array)
    array = NULL
