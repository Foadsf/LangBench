! **********************************************************
! https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/
! **********************************************************

      program belief

      IMPLICIT NONE

      real :: r

      real start, finish

      integer N
      integer, parameter :: dim = 5000
      double precision, allocatable :: A(:,:)
      double precision, allocatable :: x(:), x2(:)
      double precision :: mysum, mynorm

      integer :: i, j, k
      CHARACTER(len=50) :: arg(1)

      ! Get the dimension from the command line
      !----------------------------------------
      call getarg(1,arg(1))
      read(arg(1), * ) N

      call cpu_time(start)

      !-------------------------------------
      ! Allocate and initialize the matrices
      !-------------------------------------
      allocate(A(dim,dim))
      allocate(x(dim))

      call srand(86456)
      do i = 1, dim
         x(i) = 1.0
         do j = 1, dim
            call random_number(r)
            A(i, j) = r
         enddo
      enddo

      !----------------------------------
      ! Perform the belief calculations
      !----------------------------------

      DO k = 1, N

         x2 = matmul(A,x)

         x(:) = log(x2(:))

         mysum = sum(exp(x(:)))

         mynorm = log(mysum)
         x(:) = x(:) - mynorm
         
      END DO

      call cpu_time(finish)

      print "('Time for Belief Calculations (',i4,'):', 2x, f15.10,'s')", N, finish - start
      !print *,'Time for Belief Calculations (',N,'): ', finish - start,' s'

      end program belief
