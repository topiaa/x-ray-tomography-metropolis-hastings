function mcmc_cm=CMestplotter(chain,period)


[rows,cols]=size(chain);
% Plotataan ja lasketaan CM-estimaatti 

burninperiod= period*cols; %poistetaan ketjun alusta kamaa CM-estimaatin tarkkuuden parantamiseksi
mcmc_cm1=mean(chain(:,(burninperiod:burninperiod + floor(.5*(cols-burninperiod)))),2);
mcmc_cm2=mean(chain(:,burninperiod + floor(.5*(cols-burninperiod))+1:end),2);
mcmc_cm=mean([mcmc_cm1,mcmc_cm2],2);
figure(2)
imagesc(reshape(mcmc_cm,[32,32]))
end

