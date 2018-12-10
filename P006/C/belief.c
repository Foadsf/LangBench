
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const int dim = 1000;

void beliefprop2(double A[dim][dim], double x[dim], int N);

int main(int argc, char* argv[])
{
        double A[dim][dim];
        double x[dim];
        int N;
        int i, j, dim;
        clock_t start, finish;

        double maxr;

        // ---------------------------------------
        // Get the number of iterations from the command line
        // ---------------------------------------
        N = atoi(argv[1]);

        srand(time(NULL));
        start = clock();

        maxr = (double)RAND_MAX;
        for (i = 0; i < dim; i++)
        {
                x[i] = 1.0;
                for (j = 0; j < dim; j++)
                    A[i][j] = rand()/maxr;
         }

        // ---------------------------
        // Perform the belief operations
        // ---------------------------
        beliefprop2( A, x, N);
        finish = clock();

        printf("Time for belief calculations (%d): %lf s\n", N, (double) (finish - start)/CLOCKS_PER_SEC);  
        return 0;

}

void beliefprop2(double A[dim][dim], double x[dim], int N){
  int i, k, j;
  double x2[dim];
  for (k=0; k<N; k++){
      for (i=0; i<dim; i++){
          x2[i]=0;
          for (j=0; j<dim; j++)
	      x2[i] += A[i][j]*exp(x[j]);
      }   
      for (i=0; i<dim; i++)
          x[i]=log(x2[i]);
      double mysum = 0;
      for (i=0; i<dim; i++)
          mysum += exp(x[i]);
      double mynorm = log(mysum);
      for (i=0; i<dim; i++)
          x[i] -= mynorm;
  }
  return;
}

