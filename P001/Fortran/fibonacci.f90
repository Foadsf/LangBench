program fibonacci

      IMPLICIT NONE

      real start, finish
      integer m, n1, n2
      CHARACTER(len=50) :: arg(1)

      ! Get the dimension from the command line
      !----------------------------------------
      call getarg(1,arg(1))
      read(arg(1), * ) m

      !----------------------
      ! Calculation with loop
      !----------------------
      call cpu_time(start)
      n2 = fibI(m)
      call cpu_time(finish)
      print "('Iterative Fibonacci (',i2,'):', 2x, f15.10,'s')", m, finish - start
      !print *,'Loop - Fibonacci (',m,'): ', finish - start,'s', n2

      !------------------------------------
      ! Calculation with recursive function
      !------------------------------------
      call cpu_time(start)
      n1 = fibR(m)
      call cpu_time(finish)
      print "('Recursive Fibonacci (',i2,'):', 2x, f15.10,'s')", m, finish - start
      !print *,'Recursive - Fibonacci (',m,'): ', finish - start,'s', n1

contains

    recursive function fibR(n) result(fib)
        integer, intent(in) :: n
        integer             :: fib
 
        select case (n)
            case (:0);      fib = 0
            case (1);       fib = 1
            case default;   fib = fibR(n-1) + fibR(n-2)
        end select
    end function fibR

    function fibI(n)
        integer, intent(in) :: n
        integer, parameter :: fib0 = 0, fib1 = 1
        integer            :: fibI, back1, back2, i
 
        select case (n)
            case (:0);      fibI = fib0
            case (1);       fibI = fib1
 
            case default
                fibI = fib1
                back1 = fib0
                do i = 2, n
                    back2 = back1
                    back1 = fibI
                    fibI   = back1 + back2
                end do
         end select
    end function fibI
end program fibonacci
