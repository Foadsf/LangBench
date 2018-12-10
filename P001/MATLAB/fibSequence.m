
function fibSequence(n)

  fprintf('--------------------------\n')
  fprintf('Iterative Fibonacci:  %5g \n', n)
  fprintf('--------------------------\n')

  tic
    f=fibonacci(n);
  toc

  fprintf('--------------------------\n')
  fprintf('Recursive Fibonacci:  %5g \n', n)
  fprintf('--------------------------\n')

  tic
    f=fibonacci(n);
  toc
exit;
