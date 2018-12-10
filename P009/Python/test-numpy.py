import sys
import test_numpy
iterations = 0
if len(sys.argv) > 1:
    iterations = int(sys.argv[1])
test_numpy.test_python(iterations)
