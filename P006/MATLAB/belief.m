% matlab

%function x=beliefprop2(A,x,N)
%  for i=1:N
%    x = log(A*exp(x));
%    x = x - log(sum(exp(x)));
%  end
%end

%matlab -nodesktop -nojvm -nosplash -r "belief(100)"
%
function belief(N)

  fprintf('--------------------------\n')
  fprintf('Belief Calculations:  %5g \n', N)
  fprintf('--------------------------\n')

  tic

  dim = 5000;
  A = rand (dim, dim);
  x = ones(dim,1);

  for i=1:N
    x = log(A*exp(x));
    x = x - log(sum(exp(x)));
  end

  toc

exit;
