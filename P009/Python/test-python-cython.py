import sys
import test_python_cython
iterations = 0
if len(sys.argv) > 1:
    iterations = int(sys.argv[1])
test_python_cython.test_python(iterations)

