import sys
import test_python
iterations = 0
if len(sys.argv) > 1:
    iterations = int(sys.argv[1])
test_python.test_python(iterations)
