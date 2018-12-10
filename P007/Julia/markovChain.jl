


####################################################
# Get the number of iterations from the command line
####################################################
n, = size(ARGS)
if (n < 1)
   println("Usage: markovChain.jl N")
   println("       ---> Please specify the number of iterations.")
   exit()
end

N = parse(Int, ARGS[1])

function mcmc(x,N)
   f(x) = exp(sin(x[1]*5) - x[1]^2 - x[2]^2);
   p = f(x);
   for n=1:N
       x2 = x + .01*randn(size(x));
       p2 = f(x2);
       if rand() < p2/p
          x = x2;
          p = p2;
       end
   end
end

println("--------------------------")
println(@sprintf "Markov Chain calculations: %d" N)
println("--------------------------")

tic()
x = zeros(2)
mcmc(x,N)

toc()
