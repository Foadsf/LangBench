#include <iostream>
#include <cstdlib>
using namespace std;
int main(int argc, char **argv) {
    int element = 0;
    int iteration = 0;
    int iterations = 0;
    int innerloop = 0;
    double sum = 0;
    int array_length = 100000000;
    double *array = new double[array_length];
    if (argc > 1)
        iterations = atoi(argv[1]);
    cout << "iterations " << iterations << endl;;
    for (element = 0; element < array_length; element++)
        array[element] = element;
    for (iteration = 0; iteration < iterations; iteration++)
        for (innerloop = 0; innerloop < 1000000000; innerloop++)
            sum += array[(iteration + innerloop) % array_length];
    cout << "sum " << sum << endl;
    delete array;
    array = NULL;
    return 0;
}
