import sys
def test_python(iterations):
    element = 0
    iteration = 0
    innerloop = 0
    total = float(0.0)
    array_length = 100000000
    array = [i for i in range(array_length)]
    print 'iterations', iterations
    while iteration < iterations:
        innerloop = 0
        while innerloop < 1000000000:
            total += array[(iteration + innerloop) % array_length];
            innerloop += 1
        iteration += 1
    print 'sum', total
    del array
