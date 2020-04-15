function logposterior=logposterior(A,x,m,noiselevel,prmean,prcov, beta, nrow, ncol)
loglikel=-1/(2*noiselevel^2)*norm(A*x-m)^2;
%logprior=-1/(2*prcov^2)*norm(x-prmean)^2;
logprior = logTV(x, beta, nrow, ncol);
logposterior=loglikel+logprior;
end