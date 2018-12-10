! https://rosettacode.org/wiki/Numerical_integration/Gauss-Legendre_Quadrature#Fortran

! Works with gfortran but needs the option 
!   -assume realloc_lhs
! when compiled with Intel Fortran.
 
program gauss
      implicit none
      integer, parameter :: p = 16 ! quadruple precision
      integer            :: n, k, m
      !integer            :: n = 10, k
      real(kind=p), allocatable :: r(:,:)
      real(kind=p)       :: z, a, b, exact

      real start, finish
      CHARACTER(len=50) :: arg(1)

      ! Get the dimension from the command line
      !----------------------------------------
      call getarg(1,arg(1))
      read(arg(1), * ) m

      a = -3
      b =  3
      exact = exp(3.0_p)-exp(-3.0_p)

      call cpu_time(start)
      r = gaussquad(m)
      z = (b-a)/2*dot_product(r(2,:),exp((a+b)/2+r(1,:)*(b-a)/2))
      call cpu_time(finish)
      !print "(i0,1x,g0,1x,g10.2)",m, z, z-exact
      print "('Gauss-Legendre Quadrature (',i4,'):', 2x, f15.10,'s')", m, finish - start

!      do n = 1,m
!        r = gaussquad(n)
!        z = (b-a)/2*dot_product(r(2,:),exp((a+b)/2+r(1,:)*(b-a)/2))
!        print "(i0,1x,g0,1x,g10.2)",n, z, z-exact
!      end do
 
  contains 
 
      function gaussquad(n) result(r)
      integer                 :: n
      real(kind=p), parameter :: pi = 4*atan(1._p)
      real(kind=p)            :: r(2, n), x, f, df, dx
      integer                 :: i,  iter
      real(kind = p), allocatable :: p0(:), p1(:), tmp(:)
 
      p0 = [1._p]
      p1 = [1._p, 0._p]
 
      do k = 2, n
         tmp = ((2*k-1)*[p1,0._p]-(k-1)*[0._p, 0._p,p0])/k
         p0 = p1; p1 = tmp
      end do
      do i = 1, n
        x = cos(pi*(i-0.25_p)/(n+0.5_p))
        do iter = 1, 10
          f = p1(1); df = 0._p
          do k = 2, size(p1)
            df = f + x*df
            f  = p1(k) + x * f
          end do
          dx =  f / df
          x = x - dx
          if (abs(dx)<10*epsilon(dx)) exit
        end do
        r(1,i) = x
        r(2,i) = 2/((1-x**2)*df**2)
      end do
      end function
end program
