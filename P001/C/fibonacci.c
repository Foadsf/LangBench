
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long int fibR(int n);
long long int fibI(int n);

int main(int argc, char* argv[])
{
        int N, M, n1;
        clock_t start, finish;

        // ---------------------------------------
        // Get the number of iterations from the command line
        // ---------------------------------------
        N = atoi(argv[1]);
        M = N;

        srand(time(NULL));

        // ------------------------------------------
        // Perform the Recursive Fibonnacy operations
        // ------------------------------------------
        start = clock();

        n1 = fibI(N);
        finish = clock();

        printf("Iterative - Fibonacci (%d): %lf s --> %d \n", N, (double) (finish - start)/CLOCKS_PER_SEC, n1);
        // ------------------------------------------
        // Perform the Recursive Fibonnacy operations
        // ------------------------------------------
        start = clock();

        n1 = fibR(M);
        finish = clock();

        printf("Recursive - Fibonacci (%d): %lf s --> %d \n", M, (double) (finish - start)/CLOCKS_PER_SEC, n1);  
        return 0;

}

// recursive method
long long int fibR(int n){
  if(n<=2)
    return(1);
  else
    return(fibR(n-2)+fibR(n-1));
}

// Iterative method
// https://rosettacode.org/wiki/Fibonacci_sequence
long long int fibI(int n) {
     int fnow = 0, fnext = 1, tempf;
     while(--n>0)
     {
         tempf = fnow + fnext;
         fnow = fnext;
         fnext = tempf;
     }
     return fnext;	
}
