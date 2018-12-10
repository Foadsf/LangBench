# https://rosettacode.org/wiki/Numerical_integration/Gauss-Legendre_Quadrature#Julia

####################################################
# Get the number of iterations from the command line
####################################################
n, = size(ARGS)
if (n < 1)
   println("Usage: gaussLegendre_quadrature.jl N")
   println("       ---> Please specify the number of grid points.")
   exit()
end

N = parse(Int, ARGS[1])

function gauss(a,b, N)
    lamnda, Q = eig(SymTridiagonal(zeros(N), [ n / sqrt(4n^2 - 1) for n = 1:N-1 ]))
    return (lamnda + 1) * (b-a)/2 + a, [ 2*Q[1,i]^2 for i = 1:N ] * (b-a)/2
end

println("--------------------------")
println(@sprintf "Gauss-Legendre Quadrature %d" N)
println("--------------------------")

tic()
x,w = gauss(-3,3,N)
quad = sum(exp.(x) .* w)
toc()
#exact = exp(3) - exp(-3)
#println(quad)
#println(exact)
