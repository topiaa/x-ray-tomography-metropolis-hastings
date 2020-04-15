%Make sinogram

nAngles=180;

theta=linspace(0,180,nAngles+1);    

row=1127;
res=49;
modulo=mod(length((480:1720)),res);
width=[(480-floor(.5*(res-modulo)):480),(481:1719),(1720:1720+ceil(.5*(res-modulo)))];

% file='E:\PhD\Dynamic X-ray\data\cells_init_001.tif';
% rawData1 = importdata(file);

%sino=zeros(length(width),nAngles+1);
sino=zeros(res,nAngles+1);


for iii=0:ceil(180/nAngles):180
    
    file=['AnneTopias/asparagus' num2str(iii,'%05.3u') '.tif']
    rawData = importdata(file);
%     figure(3)
%     imagesc(rawData(:,width))
    %sino(:,iii+1)=rawData(row,width);
    sino(:,iii*nAngles/180+1)=mean(reshape(rawData(row,width),[],res));
    
end

figure(1)
imagesc(sino)

%%
sino2=abs(max(log(sino(:)))-log(sino));
% sino=max(sino(:));





rec=iradon(sino,theta);
rec2=iradon(sino2,theta,'linear','Ram-Lak',1,32);
figure(2)

imagesc(rec2)

save('sinog','sino','rec','sino2','rec2')