function [outval] = poissonKS(k,lambda) 
   outval = (lambda^k)*exp(-lambda)/factorial(k);
end