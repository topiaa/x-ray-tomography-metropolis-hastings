function [ res ] = loglike( x, A, noiselevel, m )
% Compute the logpdf of a multivariate normal at x.

% Parameters:
% x             evaluation point
% A             forward map
% noiselevel    measurement noise
% m             the measurement

res = -1/(2*noiselevel^2)*norm(A*x-m)^2;

end

