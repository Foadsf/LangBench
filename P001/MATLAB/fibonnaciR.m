
% Matlab: Recursive fibonacci
function f=fibonacci(n)
  if n <= 2
    f=1.0;
  else
    f=fibonacci(n-1)+fibonacci(n-2);
  end
end
