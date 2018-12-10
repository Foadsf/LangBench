#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
int main(int argc, char **argv) {
    int element = 0;
    int iteration = 0;
    int iterations = 0;
    int innerloop = 0;
    double sum = 0.0;
    int array_length = 100000000;
    double *array = (double*)malloc(array_length * sizeof(double));
    if (argc > 1)
        iterations = atoi(argv[1]);
    printf("iterations %d\n", iterations);
    for (element = 0; element < array_length; element++)
        array[element] = element;
    for (iteration = 0; iteration < iterations; iteration++)
        for (innerloop = 0; innerloop < 1000000000; innerloop++)
            sum += array[(iteration + innerloop) % array_length];
    printf("sum %E\n", sum);
    free(array);
    array = NULL;
    return 0;
}
