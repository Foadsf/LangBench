# https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/


####################################################
# Get the number of iterations from the command line
####################################################
n, = size(ARGS)
if (n < 1)
   println("Usage: belief.jl N")
   println("       ---> Please specify the number of iterations.")
   exit()
end

N = parse(Int, ARGS[1])

# julia
function beliefprop2(A,x,N)
  for i=1:N
    x = log.(A*exp.(x));
    x -= log.(sum(exp.(x)));
  end
  x
end

println("--------------------------")
println(@sprintf "Belief calculations: %d" N)
println("--------------------------")

tic()

dim = 5000
x = ones(dim)
A = (randn(dim,dim) + 1.0)/2.0

beliefprop2(A,x,N)

toc()
