import sys
import test_numpy_cython
iterations = 0
if len(sys.argv) > 1:
    iterations = int(sys.argv[1])
test_numpy_cython.test_python(iterations)
