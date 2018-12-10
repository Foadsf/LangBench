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

function mcmc(x,y, N)
    f(x,y) = exp(sin(x*5) - x^2 - y^2)
    
    p = f(x,y)
    for n= 1:N
        x2 = x + .01*randn()
        y2 = y + .01*randn()
        p2 = f(x2, y2)
        if rand() < p2/p
            x = x2
            y = y2
            p = p2
        end
    end
    x,y
end

# trigger JIT
mcmc(0.0,0.0, 10)

println("--------------------------")
println(@sprintf "Markov Chain calculations: %d" N)
println("--------------------------")

@time mcmc(0.0,0.0,N)
