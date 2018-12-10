; https://rosettacode.org/wiki/Fibonacci_sequence#IDL

function fibR,n
   if n lt 3 then return,1L else return, fibR(n-1)+fibR(n-2)
end

function fibI,n
  psum = (csum = 1uL)
  if n lt 3 then return,csum
  for i = 3,n do begin
    nsum = psum + csum
    psum = csum
    csum = nsum
  endfor
  return,nsum
end

pro fibonacci, n

    time0 = SYSTIME(/SECONDS)
    n1 = fibI(n)
    time1 = SYSTIME(/SECONDS) - time0
    print, 'Iterative Fibonacci (',n,'): ', time1, n1

    time0 = SYSTIME(/SECONDS)
    n2 = fibR(n)
    time1 = SYSTIME(/SECONDS) - time0
    print, 'Recursive Fibonacci (',n,'): ', time1, n2

    return
end
