function [acc_rate, chain] = MHsampler(A, noiselevel, initial, Nsamples, beta, sigma, m, nrow, ncol, mask, printprogress)

% Parameters
% A             forward map
% noiselevel    known measurement noise
% initial       starting point for the sampler
% Nsamples      number of samples
% beta          hyperparameter for TV prior
% sigma         standard deviation of the proposal distribution
% m             measurement
% nrow          number of rows in the reconstruction
% ncol          number of columns -""-
% mask          binary matrix indicating whether a pixel is sampled
% printprogress     boolean

% Initialize the chain
Npixels=length(initial);
chain=zeros(Npixels,Nsamples);
accnum=0;
chain(:,1)=initial;

reverseStr = '';
for iii=2:Nsamples
prev=chain(:,iii-1);
chain(:,iii)=prev;

% Generate candidate
candidate=prev+sigma*randn(Npixels,1);
candidate(not(mask)) = 0;

    %%% Test with negativity starts here
    candidate( candidate < 0) = 0;
    %%%% Test with negativity ends here
   
% TV PRIOR    
osoittaja = loglike(candidate, A, noiselevel, m) + logTV(candidate, beta, nrow, ncol);
nimittaja = loglike(prev, A, noiselevel, m) + logTV(candidate, beta, nrow, ncol);

% %with Gaussian prior
% prmean = ones(Npixels,1)*0.05;
% prcov  = eye(Npixels)*0.01;
% osoittaja = loglike(candidate, A, noiselevel, m) + logGaus(candidate, prcov, prmean);  
% nimittaja = loglike(prev, A, noiselevel, m) + logGaus(candidate, prcov, prmean);

%ota MAP analyyttisesti posteriori Bartzilai

ratio = min(1,exp(osoittaja-nimittaja));
if rand < ratio && min(candidate >= -0.01)
%if rand < ratio
    chain(:,iii)=candidate;
    accnum=accnum+1;
end

 % Display the progress
if printprogress
    percentDone = 100 * iii / Nsamples;
    msg = sprintf('Percent done: %3.1f', percentDone);
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end


end
%fprintf('\n')

acc_rate = accnum/Nsamples;