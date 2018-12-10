import sys
import test_cython
iterations = 0
if len(sys.argv) > 1:
    iterations = int(sys.argv[1])
test_cython.test_cython(iterations)
