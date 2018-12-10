! **********************************************************
! https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/
! **********************************************************

      program markovChain

      IMPLICIT NONE

      real :: r

      real start, finish

      integer N
      double precision :: x(2)
      double precision :: mysum, mynorm

      integer :: i, j, k
      CHARACTER(len=50) :: arg(1)

      ! Get the dimension from the command line
      !----------------------------------------
      call getarg(1,arg(1))
      read(arg(1), * ) N

      call cpu_time(start)


      !----------------------------------
      ! Perform the Markov Chain calculations
      !----------------------------------
      x(:) = 0.0

      call mcmc(x, N)

      call cpu_time(finish)

      print "('Markov Chain Calculations (',i2,'):', 2x, f15.10,'s')", N, finish - start
      !print *,'Markov Chain Calculations (',N,'): ', finish - start,' s'

      CONTAINS

      subroutine mcmc(x, N)
         IMPLICIT NONE
         double precision, intent(inOUT) :: x(2)
         integer, intent(IN) :: N
         integer :: i
         double precision :: p, p2, x2(2)
         real :: r

         call srand(86456)
         p = ff(x)
         DO i = 1, N
            call random_number(r)
            x2(1) = x(1) + 0.01d0*random_normal()
            call random_number(r)
            x2(2) = x(2) + 0.01d0*random_normal()

            p2 = ff(x2)
            call random_number(r)
            IF (r .LT. (p2/p)) THEN
               x(:) = x2(:)
               p    = p2
            END IF
         END DO

      return
      end subroutine mcmc

      double precision function ff(x)
         IMPLICIT NONE
         double precision :: x(2)
         ff = exp(sin(5.0d0*x(1)) - x(1)*x(1) - x(2)*x(2))
      end function ff

      FUNCTION random_normal() RESULT(fn_val)

      ! Adapted from the following Fortran 77 code
      !      ALGORITHM 712, COLLECTED ALGORITHMS FROM ACM.
      !      THIS WORK PUBLISHED IN TRANSACTIONS ON MATHEMATICAL SOFTWARE,
      !      VOL. 18, NO. 4, DECEMBER, 1992, PP. 434-435.

      !  The function random_normal() returns a normally distributed pseudo-random
      !  number with zero mean and unit variance.

      !  The algorithm uses the ratio of uniforms method of A.J. Kinderman
      !  and J.F. Monahan augmented with quadratic bounding curves.

      REAL :: fn_val

      !     Local variables
      REAL     :: s  = 0.449871,  t = -0.386595, a = 0.19600, b = 0.25472
      REAL     :: r1 = 0.27597,  r2 = 0.2784, half = 0.5
      REAL     :: u, v, x, y, q

      !     Generate P = (u,v) uniform in rectangle enclosing acceptance region

      DO
        CALL RANDOM_NUMBER(u)
        CALL RANDOM_NUMBER(v)
        v = 1.7156 * (v - half)

      !     Evaluate the quadratic form
        x = u - s
        y = ABS(v) - t
        q = x**2 + y*(a*y - b*x)
      
      !     Accept P if inside inner ellipse
        IF (q < r1) EXIT
      !     Reject P if outside outer ellipse
        IF (q > r2) CYCLE
      !     Reject P if outside acceptance region
        IF (v**2 < -4.0*LOG(u)*u**2) EXIT
      END DO
      
      !     Return ratio of P's coordinates as the normal deviate
      fn_val = v/u
      RETURN

      END FUNCTION random_normal

      end program markovChain
