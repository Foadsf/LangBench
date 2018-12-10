; **********************************************************
; https://justindomke.wordpress.com/2012/09/17/julia-matlab-and-c/
; **********************************************************
;
; .run belief
; belief, nx
;
pro belief, N

print, '----------------------------'
print, 'Belief calculations: ', N
print, '----------------------------'
print, ' '

time0 = SYSTIME(/SECONDS)

randomValue = RANDOMN(seed)

dim = 5000

A = randomn(seed, dim,dim)
x = fltarr(dim)

x[0:dim-1] = 1.0

for i = 1,N do begin
    x = ALOG10(A#EXP(x))
    x -= ALOG10(TOTAL(EXP(x)))  
endfor

time1 = SYSTIME(/SECONDS) - time0
print, 'Elapsed time: ', time1

return
end
