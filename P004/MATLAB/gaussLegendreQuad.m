

function gaussLegendreQuad(N)

  fprintf('--------------------------\n')
  fprintf('Gauss-Legendre Quadrature:  %5g \n', N)
  fprintf('--------------------------\n')

  a = -3.0;
  b =  3.0;

  tic
    [x, w] = lgwt(N, a, b);
    int = w'*exp(x);
  toc

exit;
