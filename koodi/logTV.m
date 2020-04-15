function [ logprior ] = logTV(x, beta, nrow, ncol)

image = reshape(x, [nrow, ncol]);
%[nrow, ncol] = size(image);

% Construct operator matrix
T = -1*eye(nrow) + diag(ones(nrow - 1, 1), -1);
T = T(:, 1:(end-1));

% Columns
coldiff = sum(sum(abs(image*T), 1));

% Rows
rowdiff = sum(sum(abs(T'*image), 1));

logprior = -beta*(coldiff + rowdiff);
end

