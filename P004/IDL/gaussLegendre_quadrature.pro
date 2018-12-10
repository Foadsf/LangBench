pro gaussLegendre_quadrature, n


    print, "-------------------------"
    print, "Gauss Legendre Quadrature", n
    print, "-------------------------"

    time_beg = SYSTIME(/SECONDS)

    x1 = -3.0
    x2 =  3.0
    x = fltarr(1,n)
    w = fltarr(1,n)

    Brm_GauLeg54, x1, x2, n, x, w

    quad = TOTAL(w*exp(x))

    time_end = SYSTIME(/SECONDS) - time_beg
    print, 'Time for Gauss Legendre Quadrature: ', time_end

    print, " "

end
