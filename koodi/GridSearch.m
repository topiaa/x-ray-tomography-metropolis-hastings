function GridSearch( fun, betas, sigmas )
%function [ acc_rates ] = GridSearch( fun, betas, sigmas )
% Evaluate fun at each point in the cartesian product of betas and sigmas.

%[B, S] = meshgrid(betas, sigmas);
%acc_rates = arrayfun(fun, B, S);
gridsize=length(betas)*length(sigmas);
count = 0;
for i = 1:length(betas)
    for j = 1:length(sigmas)
        count = count + 1;
        acc = fun(betas(i), sigmas(j));
        if (acc > 0.2) && (acc < 0.4)
            fprintf('beta: %d ', betas(i));
            fprintf('sigma: %d\n', sigmas(j));         
        end
 fprintf('Count: %d of %d Acc: %d\n' ,count,gridsize,acc);
    end
    
end

end

