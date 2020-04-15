%XR01_buildA

 %load('A')
% %load('A_1')
 %load('rec2')
 load('sino');


vecsino = sino(:);
vecrec2 = rec2(:);
vecsinog = sinog(:);
% exampledatashaper

noisevar = var([-0.000250965617792967,-0.000182881694179866,-0.000224455753033509,0.000596466577725747,0.000572676914936953,-1.62450703327501e-05,-0.000318830094204747,0.000415425944393853,0.000106875157055580,-0.000282350368976381,-0.000494183282515357,0.000658773839799174,0.000614291172445769,0.000148499578635867,0.000160716308996479,0.000866679723412665]);
noisesd  = sqrt(noisevar);

noiselevel =  noisesd;
%initial = vecrec2;
initial = 0.05*ones(1,1024);
%initial = chain(:,end);
  
% Construct mask
%load('mask.mat')
I = imagesc(rec2((1:32),(1:32)));
mask = roipoly(rec2((1:32),(1:32)));
%mask = openfig('mask1');

%% Search for parameters


%Parameters
Nsamples = 1000;
%betas = linspace(0, 5, 15);
betas = 3.3;
sigmas = linspace(2.9e-3,3.1e-3,20);
%sigmas = 1e-4;
m = vecsinog;

  tic
  mhs = @(beta, sigma) MHsampler(A, noiselevel, initial, Nsamples, beta, sigma, m, 32, 32, mask, false);
  GridSearch(mhs, betas, sigmas);
  toc

% %% Run sampler
% Nsamples = 1e2; 
% beta =  3.33;
% sigma = 8.921053e-04;
% m = vecsinog;
% tic
% [acc, chain] = MHsampler(A, noiselevel, initial, Nsamples, beta, sigma, m, 32, 32, mask, true);
% toc
% acc 
% %% Plotting
% chainplot(chain,1,Nsamples/1000);
% mcmc_cm=CMestplotter(chain, 0.7);
% 
% save('result2','acc','chain','mcmc_cm')