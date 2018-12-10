; **********************************************************
; https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/
; **********************************************************
;
; .run markovChain
; markovChain, nx
;
;function ff, x
   ;y = EXP(SIN(5.0*x[0]) - x[0]*x[0] - x[1]*x[1])
   ;return, y
;end

pro markovChain, N

    print, '----------------------------'
    print, 'Markov Chain calculations: ', N
    print, '----------------------------'
    print, ' '

    time0 = SYSTIME(/SECONDS)

    randomValueN = RANDOMN(seedN)
    randomValueU = RANDOMN(seedU)

    x = fltarr(2)
    x2= fltarr(2)

    x[0:1] = 0.0

    p = EXP(SIN(5.0*x[0]) - x[0]*x[0] - x[1]*x[1])
    ;p = ff(x)

    for i = 1,N do begin
        x2 = x + 0.01*randomn(seedN, 2)
        p2 = EXP(SIN(5.0*x2[0]) - x2[0]*x2[0] - x2[1]*x2[1])
        ;p2 = ff(x2)
        IF (randomu(seedU, 1) < (p2/p)) THEN BEGIN
           x = x2
           p = p2
        ENDIF
    endfor

    time1 = SYSTIME(/SECONDS) - time0
    print, 'Elapsed time: ', time1

    return
end
