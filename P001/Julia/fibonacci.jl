# https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/
# https://rosettacode.org/wiki/Fibonacci_sequence#Julia


####################################################
# Get the number of iterations from the command line
####################################################
n, = size(ARGS)
if (n < 1)
   println("Usage: fibonacci.jl N")
   println("       ---> Please specify the number of iterations.")
   exit()
end

N = parse(Int, ARGS[1])

# julia

#----------
# Recursive
#----------
function fibR(n)
  if n <= 2
    1.0
  else
    fibR(n-1)+fibR(n-2);
  end
end

#----------
# Iterative
#----------
function fibI(n)
  x,y = (0,1)
  for i = 1:n x,y = (y, x+y) end
  x
end

#-------
# Matrix
#-------
function fibM(n) 
    ([1 1 ; 1 0]^n)[1,2]
end

println("--------------------------")
println(@sprintf "Iterative - Fibonacci %d" N)
println("--------------------------")

tic()
fibI(N)
toc()

println("--------------------------")
println(@sprintf "Recursive - Fibonacci %d" N)
println("--------------------------")

tic()
fibR(N)
toc()

#println("--------------------------")
#println(@sprintf "Matrix - Fibonacci %d" N)
#println("--------------------------")
#
#tic()
#fibM(N)
#toc()
