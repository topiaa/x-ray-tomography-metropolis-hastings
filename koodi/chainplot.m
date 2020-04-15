function chainplot(chain, start, step)

%funktio MC:n plottaamiseen.

chain0=chain(:,(start:step:end));

figure(1)
clf
hold on
plot(chain0')