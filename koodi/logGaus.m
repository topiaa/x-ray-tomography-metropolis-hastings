function [ logprior1 ] = logGaus(candidate,prcov,prmean)

%Evaluate Gaussian log prior
logprior1 = -1/2*(candidate-prmean).'*inv(prcov)*(candidate-prmean);
end
