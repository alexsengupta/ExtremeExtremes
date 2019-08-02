% redo seasonality

clear; close all
load('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/MaxSeverity_MAxSST_date.mat')
clear M*_start* M*_end*
mask=nc_varget('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/iceedge.nc','mask');
mask=mask./mask;
mask(lat>80,:)=NaN;mask(lat<-70,:)=NaN;

for N=1:1
    cm=[.3 .7 .9
        .9 .7 .1
        .85 .3 .1
        .6 .1 .2
        .4 .1 .4];
    
    
    n=36
    cmapp=[0,0,0 ;102,0,102; 94,79,162; 22,80,220;0,120,250;52,154,188;241,243,180; 40,200,40 ;181,225,163;251,147,81;150,1,31;250,101,101;250,250,250]
    x = linspace(1,n,size(cmapp,1));
    xi = 1:n;
    yrmap = zeros(n,3);
    for ii=1:3
        yrmap(:,ii) = pchip(x,cmapp(:,ii),xi);
    end
    yrmap = (yrmap/255);
    colormap(yrmap)
    
    mycmap =[    1.0000    1.0000    1.0000
        0.9418    0.9791    0.9941
        0.8837    0.9582    0.9882
        0.8255    0.9373    0.9824
        0.7673    0.9163    0.9765
        0.7092    0.8954    0.9706
        0.6510    0.8745    0.9647
        0.5928    0.8536    0.9588
        0.5346    0.8327    0.9529
        0.4765    0.8118    0.9471
        0.4183    0.7908    0.9412
        0.3601    0.7699    0.9353
        0.3020    0.7490    0.9294
        0.3502    0.7445    0.8679
        0.3985    0.7400    0.8063
        0.4468    0.7354    0.7448
        0.4950    0.7309    0.6833
        0.5433    0.7264    0.6217
        0.5916    0.7219    0.5602
        0.6398    0.7173    0.4986
        0.6881    0.7128    0.4371
        0.7363    0.7083    0.3756
        0.7846    0.7038    0.3140
        0.8329    0.6992    0.2525
        0.8811    0.6947    0.1910
        0.9294    0.6902    0.1294
        0.9234    0.6624    0.1273
        0.9173    0.6347    0.1252
        0.9113    0.6069    0.1231
        0.9053    0.5792    0.1210
        0.8992    0.5514    0.1189
        0.8932    0.5237    0.1167
        0.8872    0.4959    0.1146
        0.8811    0.4682    0.1125
        0.8751    0.4404    0.1104
        0.8691    0.4127    0.1083
        0.8630    0.3849    0.1062
        0.8570    0.3572    0.1041
        0.8510    0.3294    0.1020
        0.8333    0.3085    0.1085
        0.8157    0.2876    0.1150
        0.7980    0.2667    0.1216
        0.7804    0.2458    0.1281
        0.7627    0.2248    0.1346
        0.7451    0.2039    0.1412
        0.7275    0.1830    0.1477
        0.7098    0.1621    0.1542
        0.6922    0.1412    0.1608
        0.6745    0.1203    0.1673
        0.6569    0.0993    0.1739
        0.6392    0.0784    0.1804
        0.6278    0.0863    0.2097
        0.6163    0.0941    0.2389
        0.6048    0.1020    0.2682
        0.5934    0.1098    0.2974
        0.5819    0.1176    0.3267
        0.5704    0.1255    0.3560
        0.5590    0.1333    0.3852
        0.5475    0.1412    0.4145
        0.5360    0.1490    0.4437
        0.5246    0.1569    0.4730
        0.5131    0.1647    0.5023
        0.5017    0.1725    0.5315
        0.4902    0.1804    0.5608]
    
    cmap=[0.2081    0.1663    0.5292
        0.2116    0.1898    0.5777
        0.2123    0.2138    0.6270
        0.2081    0.2386    0.6771
        0.1959    0.2645    0.7279
        0.1707    0.2919    0.7792
        0.1253    0.3242    0.8303
        0.0591    0.3598    0.8683
        0.0117    0.3875    0.8820
        0.0060    0.4086    0.8828
        0.0165    0.4266    0.8786
        0.0329    0.4430    0.8720
        0.0498    0.4586    0.8641
        0.0629    0.4737    0.8554
        0.0723    0.4887    0.8467
        0.0779    0.5040    0.8384
        0.0793    0.5200    0.8312
        0.0749    0.5375    0.8263
        0.0641    0.5570    0.8240
        0.0488    0.5772    0.8228
        0.0343    0.5966    0.8199
        0.0265    0.6137    0.8135
        0.0239    0.6287    0.8038
        0.0231    0.6418    0.7913
        0.0228    0.6535    0.7768
        0.0267    0.6642    0.7607
        0.0384    0.6743    0.7436
        0.0590    0.6838    0.7254
        0.0843    0.6928    0.7062
        0.1133    0.7015    0.6859
        0.1453    0.7098    0.6646
        0.1801    0.7177    0.6424
        0.2178    0.7250    0.6193
        0.2586    0.7317    0.5954
        0.3022    0.7376    0.5712
        0.3482    0.7424    0.5473
        0.3953    0.7459    0.5244
        0.4420    0.7481    0.5033
        0.4871    0.7491    0.4840
        0.5300    0.7491    0.4661
        0.5709    0.7485    0.4494
        0.6099    0.7473    0.4337
        0.6473    0.7456    0.4188
        0.6834    0.7435    0.4044
        0.7184    0.7411    0.3905
        0.7525    0.7384    0.3768
        0.7858    0.7356    0.3633
        0.8185    0.7327    0.3498
        0.8507    0.7299    0.3360
        0.8824    0.7274    0.3217
        0.9139    0.7258    0.3063
        0.9450    0.7261    0.2886
        0.9739    0.7314    0.2666
        0.9938    0.7455    0.2403
        0.9990    0.7653    0.2164
        0.9955    0.7861    0.1967
        0.9880    0.8066    0.1794
        0.9789    0.8271    0.1633
        0.9697    0.8481    0.1475
        0.9626    0.8705    0.1309
        0.9589    0.8949    0.1132
        0.9598    0.9218    0.0948
        0.9661    0.9514    0.0755
        0.9763    0.9831    0.0538
        0.9763    0.9831    0.0538
        0.9661    0.9514    0.0755
        0.9598    0.9218    0.0948
        0.9589    0.8949    0.1132
        0.9626    0.8705    0.1309
        0.9697    0.8481    0.1475
        0.9789    0.8271    0.1633
        0.9880    0.8066    0.1794
        0.9955    0.7861    0.1967
        0.9990    0.7653    0.2164
        0.9938    0.7455    0.2403
        0.9739    0.7314    0.2666
        0.9450    0.7261    0.2886
        0.9139    0.7258    0.3063
        0.8824    0.7274    0.3217
        0.8507    0.7299    0.3360
        0.8185    0.7327    0.3498
        0.7858    0.7356    0.3633
        0.7525    0.7384    0.3768
        0.7184    0.7411    0.3905
        0.6834    0.7435    0.4044
        0.6473    0.7456    0.4188
        0.6099    0.7473    0.4337
        0.5709    0.7485    0.4494
        0.5300    0.7491    0.4661
        0.4871    0.7491    0.4840
        0.4420    0.7481    0.5033
        0.3953    0.7459    0.5244
        0.3482    0.7424    0.5473
        0.3022    0.7376    0.5712
        0.2586    0.7317    0.5954
        0.2178    0.7250    0.6193
        0.1801    0.7177    0.6424
        0.1453    0.7098    0.6646
        0.1133    0.7015    0.6859
        0.0843    0.6928    0.7062
        0.0590    0.6838    0.7254
        0.0384    0.6743    0.7436
        0.0267    0.6642    0.7607
        0.0228    0.6535    0.7768
        0.0231    0.6418    0.7913
        0.0239    0.6287    0.8038
        0.0265    0.6137    0.8135
        0.0343    0.5966    0.8199
        0.0488    0.5772    0.8228
        0.0641    0.5570    0.8240
        0.0749    0.5375    0.8263
        0.0793    0.5200    0.8312
        0.0779    0.5040    0.8384
        0.0723    0.4887    0.8467
        0.0629    0.4737    0.8554
        0.0498    0.4586    0.8641
        0.0329    0.4430    0.8720
        0.0165    0.4266    0.8786
        0.0060    0.4086    0.8828
        0.0117    0.3875    0.8820
        0.0591    0.3598    0.8683
        0.1253    0.3242    0.8303
        0.1707    0.2919    0.7792
        0.1959    0.2645    0.7279
        0.2081    0.2386    0.6771
        0.2123    0.2138    0.6270
        0.2116    0.1898    0.5777
        0.2081    0.1663    0.5292];
    
end

%% Date of maximum severity
landmask=MAXSSTA;landmask=landmask./landmask;

figure(3);clf
dateMAXsev=decyear(MAXSEVERITYindex).*landmask.*mask;
pcolor(lon,lat,dateMAXsev);shading flat
colorbar;plotmap;caxis([1981.5 2017.5]);colormap(yrmap);
pbaspect([1.8 1 1]);title('Date of maximum severity')
figure(31);clf
dateMAXssta=decyear(MAXSSTAindex).*landmask.*mask;
pcolor(lon,lat,dateMAXssta);shading flat
colorbar;plotmap;caxis([1981.5 2017.5]);colormap(yrmap);
pbaspect([1.8 1 1]);title('Date of maximum SSTA')


% load climatology based on daily data
for i=[0:30:330]
    i
    for j=[-90:20:70] % only go from -70 to 70
        fn=['/Users/z3045790/OneDrive/DATASETS/mhw_12_2018/mhw_severity.pc90.',num2str(i),'to',num2str(i+30),'.',num2str(j),'to',num2str(j+20),'.1981.2018.nc'];
        
        if exist(fn,'file')
            clim=nc_varget(fn,'climatology');clim(clim==0)=NaN;
            lonreg=nc_varget(fn,'lon');
            latreg=nc_varget(fn,'lat');
            indmax=zeros(length(latreg),length(lonreg))*NaN;
            for myi=1:length(lonreg)
                for myj=1:length(latreg)
                    climo=clim(:,myj,myi);
                    if ~all(isnan(climo))
                        tmp=find(climo==max(climo));
                        indmax(myj,myi)=tmp(1);
                    else
                        indmax(myj,myi)=NaN;
                    end
                    
                    jj=(j+90)*4+1;
                    ii=i*4+1;
                    CLIMmaxIndex(jj:jj+79,ii:ii+119)=indmax;
                end
            end
        end
    end
end

fn='/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/noaa_oi_lat_lon.nc'
lon=nc_varget(fn,'lon');
lat=nc_varget(fn,'lat');


dayofyear=datenum(0,dvec(:,2),dvec(:,3));
dayofyearMAXSSTAindex=dayofyear(MAXSSTAindex).*landmask;
ind=find(isnan(MAXSSTAindex));dayofyearMAXSSTAindex(ind)=NaN;

dayofyearMAXSEVindex=dayofyear(MAXSEVERITYindex).*landmask;
ind=find(isnan(MAXSSTAindex));dayofyearMAXSEVindex(ind)=NaN;

CLIMmaxIndex=CLIMmaxIndex.*mask;
dayofyearMAXSSTAindex=dayofyearMAXSSTAindex.*mask;
dayofyearMAXSEVindex=dayofyearMAXSEVindex.*mask;

figure(9);clf
subplot(3,1,1)
pcolor(lon,lat,CLIMmaxIndex);shading flat;colorbar;ylim([-60 70]);plotmap
title('Day in tear of climatological SST maximum')
subplot(3,1,2)
pcolor(lon,lat,dayofyearMAXSSTAindex);shading flat;colorbar;ylim([-60 70]);plotmap
colormap(cmap)
title('Day in year of maximum SSTA')
subplot(3,1,3)
pcolor(lon,lat,dayofyearMAXSEVindex);shading flat;colorbar;ylim([-60 70]);plotmap
colormap(cmap)
title('Day in year of maximum Sev')



mons=[0,31,28,31,30,31,30,31,31,30,31,30,31]
for m=1:12
    midmonth(m)=sum(mons(1:m))+mons(m+1)/2;
end

for j=1:length(lat)
    
[N,x]=hist(CLIMmaxIndex(j,:),midmonth);
Nc(j,:)=N;
[N,x]=hist(CLIMmaxIndex(j,:),1:365);
Nd(j,:)=N;
end
figure(91);clf
subplot(2,1,1)
pcolor(1:12,lat,Nc);shading flat;ylim([-70 70]);caxis([0 500])
subplot(2,1,2)
pcolor(1:365,lat,Nd);shading flat;ylim([-70 70]);caxis([0 50])


gridarea=grid_area(lat,lon);tmp=gridarea.*mask;totarea=nansum(tmp(:));

% loo at proportional areas to remove effect of more SH ocean
GAn=gridarea.*mask;ind=find(lat<0);GAn(ind,:)=NaN;AreaN=nansum(GAn(:));
GAs=gridarea.*mask;ind=find(lat>0);GAs(ind,:)=NaN;AreaS=nansum(GAs(:));

% AreaS=1;AreaN=1;
GAn_=GAn;GAs_=GAs;
ind=find(dayofyearMAXSSTAindex>datenum(0,2,29) & dayofyearMAXSSTAindex<datenum(0,12,1));
GAn_(ind)=NaN;;GAs_(ind)=NaN;propN(1)=nansum(GAn_(:))/AreaN;propS(1)=nansum(GAs_(:))/AreaS;

GAn_=GAn;GAs_=GAs;
ind=find(or(dayofyearMAXSSTAindex<datenum(0,3,1) , dayofyearMAXSSTAindex>datenum(0,5,31)));
GAn_(ind)=NaN;;GAs_(ind)=NaN;propN(2)=nansum(GAn_(:))/AreaN;propS(2)=nansum(GAs_(:))/AreaS;

GAn_=GAn;GAs_=GAs;
ind=find(or(dayofyearMAXSSTAindex<datenum(0,6,1) , dayofyearMAXSSTAindex>datenum(0,8,31)));
GAn_(ind)=NaN;;GAs_(ind)=NaN;propN(3)=nansum(GAn_(:))/AreaN;propS(3)=nansum(GAs_(:))/AreaS;

GAn_=GAn;GAs_=GAs;
ind=find(or(dayofyearMAXSSTAindex<datenum(0,9,1) , dayofyearMAXSSTAindex>datenum(0,11,30)));
GAn_(ind)=NaN;;GAs_(ind)=NaN;propN(4)=nansum(GAn_(:))/AreaN;propS(4)=nansum(GAs_(:))/AreaS;
(propN+propS)/2
% even if we remove the effect of a larger southern ocean, the enhancement
% in DJF is evident

pause
figure(10);clf
pcolor(lon,lat,dayofyearMAXSSTAindex);shading flat;colorbar;ylim([-60 70]);plotmap
colormap(cmap)
title('Day in year of maximum SSTA') 
figure(101);clf
subplot(2,1,1)
pcolor(lon,lat,GAn_);shading flat
subplot(2,1,2)
pcolor(lon,lat,GAs_);shading flat

%% NB weightedhistc uses edges (hist uses centres)

figure(11);clf
subplot(2,3,1)
[f_allC]=weightedhistc(CLIMmaxIndex(:),gridarea(:),.5:366.5);
bar(1:366,f_allC(1:end-1)/totarea, 'BarWidth', 1)
xlabel('Dat of max climatological SST');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])
subplot(2,3,4)
[f_all]=weightedhistc(dayofyearMAXSSTAindex(:),gridarea(:),.5:366.5);
bar(1:366,f_all(1:end-1)/totarea, 'BarWidth', 1)
xlabel('Dat of max SSTA');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])
[f_all_sev]=weightedhistc(dayofyearMAXSEVindex(:),gridarea(:),.5:366.5);

%distribution for max SSTA
indDJF=[datenum(0,12,1):366 1:datenum(0,2,29)];areaDJF=sum(f_all(indDJF));
indMAM=[datenum(0,3,1):datenum(0,5,31)];areaMAM=sum(f_all(indMAM));
indJJA=[datenum(0,6,1):datenum(0,8,31)];areaJJA=sum(f_all(indJJA));
indSON=[datenum(0,9,1):datenum(0,11,30)];areaSON=sum(f_all(indSON));
tot= areaDJF+areaMAM+areaJJA+areaSON
areaDJF/tot*100
areaMAM/tot*100
areaJJA/tot*100
areaSON/tot*100

%distribution for max SEV
indDJF=[datenum(0,12,1):366 1:datenum(0,2,29)];areaDJF_s=sum(f_all_sev(indDJF));
indMAM=[datenum(0,3,1):datenum(0,5,31)];areaMAM_s=sum(f_all_sev(indMAM));
indJJA=[datenum(0,6,1):datenum(0,8,31)];areaJJA_s=sum(f_all_sev(indJJA));
indSON=[datenum(0,9,1):datenum(0,11,30)];areaSON_s=sum(f_all_sev(indSON));
tot_s= areaDJF_s+areaMAM_s+areaJJA_s+areaSON_s
areaDJF_s/tot_s*100
areaMAM_s/tot_s*100
areaJJA_s/tot_s*100
areaSON_s/tot_s*100

%NH
ind=find(lat>5);
tmp=gridarea(ind,:).*mask(ind,:);totareaNH=nansum(tmp(:));
subplot(2,3,2)
tmp1=CLIMmaxIndex(ind,:);tmp2=gridarea(ind,:)
[f_NHC]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);
bar(1:366,f_NHC(1:end-1)/totareaNH, 'BarWidth', 1)
xlabel('Dat of max climatological SST');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])
subplot(2,3,5)
tmp1=dayofyearMAXSSTAindex(ind,:);
[f_NH]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);
bar(1:366,f_NH(1:end-1)/totareaNH, 'BarWidth', 1)
xlabel('Dat of max SSTA');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])

%SH
ind=find(lat<-5);
tmp=gridarea(ind,:).*mask(ind,:);totareaSH=nansum(tmp(:));
subplot(2,3,3)
tmp1=CLIMmaxIndex(ind,:);tmp2=gridarea(ind,:)
[f_SHC]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);
bar(1:366,f_SHC(1:end-1)/totareaSH, 'BarWidth', 1)
xlabel('Dat of max climatological SST');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])
subplot(2,3,6)
tmp1=dayofyearMAXSSTAindex(ind,:);
[f_SH]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);
bar(1:366,f_SH(1:end-1)/totareaSH, 'BarWidth', 1)
xlabel('Dat of max SSTA');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])


%%
indDJF=[datenum(0,12,1):366 1:datenum(0,2,29)];areaDJF=sum(f_all(indDJF));
indMAM=[datenum(0,3,1):datenum(0,5,31)];areaMAM=sum(f_all(indMAM));
indJJA=[datenum(0,6,1):datenum(0,8,31)];areaJJA=sum(f_all(indJJA));
indSON=[datenum(0,9,1):datenum(0,11,30)];areaSON=sum(f_all(indSON));
tot= areaDJF+areaMAM+areaJJA+areaSON
areaDJF/tot*100
areaMAM/tot*100
areaJJA/tot*100
areaSON/tot*100

figure(12);clf
plot(1:366,smooth(f_NHC(1:end-1)/totareaNH,7),'k')
hold on
plot(1:366,smooth(f_NH(1:end-1)/totareaNH,7),'k--')
plot(1:366,smooth(f_SHC(1:end-1)/totareaSH,7),'r')
plot(1:366,smooth(f_SH(1:end-1)/totareaSH,7),'r--')
set(gca,'xtick',datenum(0,1:12,15),'xticklabel',{'J','F','M','A','M','J','J','A','S','O','N','D'})
xlim([1 366])
pbaspect([2 1 1])
ylabel('Proportion of Ocean')
print -f12 -depsc 'images/seasonality_maxSSTA_climSSTA'

figure(121);clf
% plot(1:366,smooth(f_NHC(1:end-1)/totareaNH,7),'k')
hold on
plot(1:366,smooth(f_NH(1:end-1)/totareaNH,7),'k');hold on
% plot(1:366,smooth(f_SHC(1:end-1)/totareaSH,7),'r')
plot(1:366,smooth(f_SH(1:end-1)/totareaSH,7),'r')
set(gca,'xtick',datenum(0,1:12,15),'xticklabel',{'J','F','M','A','M','J','J','A','S','O','N','D'})
xlim([1 366])
pbaspect([1 1 1])
ylabel('Proportion of Ocean')
print -f121 -depsc 'images/seasonality_maxSSTA_climSSTA'


'SH'
sum(f_SH([datenum(0,6,1):datenum(0,8,31)]))/totareaSH
sum(f_SH([1:datenum(0,2,28) datenum(0,12,1):end]))/totareaSH
'NH'
sum(f_NH([datenum(0,6,1):datenum(0,8,31)]))/totareaNH
sum(f_NH([1:datenum(0,2,28) datenum(0,12,1):end]))/totareaNH
%%
% Possibe factors influencing the seasonality of MHWs
% MLD - however Id expect MLD to be shallowest at the peak of the warm
% season
% Wind Speed - need to check NH/SH seasonality

% Look at MLD maximum
ff='/Users/z3045790/CCRC/DATASETS/MLD/mld_dReqdTm02.nc'
mlon=nc_varget(ff,'lon');
mlat=nc_varget(ff,'lat');
mld_D=nc_varget(ff,'mld');
ind=find(mld_D>1e8);mld_D(ind)=NaN;
ff='/Users/z3045790/CCRC/DATASETS/MLD/mld_dTm02.nc'
mld_T=nc_varget(ff,'mld');
ind=find(mld_T>1e8);mld_T(ind)=NaN;
mmask=interp2(lon,lat,mask,mlon,mlat');
mon_mld_D=zeros(length(mlat),length(mlon))*NaN;
mon_mld_T=mon_mld_D;
for i=1:length(mlon)
    for j=1:length(mlat)
        tmp=squeeze(mld_D(:,j,i));
        if ~all(isnan(tmp))
            mon_mld_D(j,i)=find(tmp==max(tmp));
            tmp=squeeze(mld_T(:,j,i));
            mon_mld_T(j,i)=find(tmp==max(tmp));
        end
    end
end


mon_mld_D=mon_mld_D.*mmask;
mon_mld_T=mon_mld_T.*mmask;

figure(20);clf
subplot(2,1,1)
pcolor(mlon,mlat,mon_mld_D);shading flat
subplot(2,1,2)
pcolor(mlon,mlat,mon_mld_T);shading flat

mgridarea=grid_area(mlat,mlon);mgridarea=mgridarea.*mmask;mtotarea=nansum(nansum(mgridarea));
ind=find(mlat>5);
mtotareaNH=nansum(nansum(mgridarea(ind,:)));
tmp1=mon_mld_D(ind,:);tmp2=mgridarea(ind,:);[fNH]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);
tmp1=mon_mld_T(ind,:);tmp2=mgridarea(ind,:);[fNHT]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);
ind=find(mlat<-5);
mtotareaSH=nansum(nansum(mgridarea(ind,:)));
tmp1=mon_mld_D(ind,:);tmp2=mgridarea(ind,:);[fSH]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);
tmp1=mon_mld_T(ind,:);tmp2=mgridarea(ind,:);[fSHT]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);

figure(121);
bar(1:12,fNH(1:end-1)/mtotareaNH,'FaceColor','none','EdgeColor','k') 
hold on
bar(1:12,fSH(1:end-1)/mtotareaSH,'FaceColor','none','EdgeColor','r')
pbaspect([2 1 1]);xlim([0.5 12.5])
print -f121 -depsc 'images/monthOFmaxMLDdensity_NH_SH'

%%
% Look at MLD maximum

mon_mld_D=zeros(length(mlat),length(mlon))*NaN;
mon_mld_T=mon_mld_D;
for i=1:length(mlon)
    for j=1:length(mlat)
        tmp=squeeze(mld_D(:,j,i));
        if ~all(isnan(tmp))
            mon_mld_D(j,i)=mean(find(tmp==min(tmp)));
        end
    end
end


mon_mld_D=mon_mld_D.*mmask;

figure(20);clf
subplot(2,1,1)
pcolor(mlon,mlat,mon_mld_D);shading flat


mgridarea=grid_area(mlat,mlon);mgridarea=mgridarea.*mmask;mtotarea=nansum(nansum(mgridarea));
ind=find(mlat>5);
mtotareaNH=nansum(nansum(mgridarea(ind,:)));
tmp1=mon_mld_D(ind,:);tmp2=mgridarea(ind,:);[fNH]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);
tmp1=mon_mld_T(ind,:);tmp2=mgridarea(ind,:);[fNHT]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);
ind=find(mlat<-5);
mtotareaSH=nansum(nansum(mgridarea(ind,:)));
tmp1=mon_mld_D(ind,:);tmp2=mgridarea(ind,:);[fSH]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);
tmp1=mon_mld_T(ind,:);tmp2=mgridarea(ind,:);[fSHT]=weightedhistc(tmp1(:),tmp2(:),.5:12.5);

figure(1211);
bar(1:12,fNH(1:end-1)/mtotareaNH,'FaceColor','none','EdgeColor','k') 
hold on
bar(1:12,fSH(1:end-1)/mtotareaSH,'FaceColor','none','EdgeColor','r')
pbaspect([2 1 1]);xlim([0.5 12.5])
print -f1211 -depsc 'images/monthOFminMLDdensity_NH_SH'

%% wind speed
fnws='/Users/z3045790/CCRC/DATASETS/ERA_interim/ERA_interim_windspeed_1979_2017_anom_climo.nc'
ws_climo=nc_varget(fnws,'S10_climo');
wlon=nc_varget(fnws,'lon');  
wlat=nc_varget(fnws,'lat');  
dayofmax_ws_climo=zeros(length(wlat),length(wlon))*NaN;
for i=1:length(wlon)
    for j=1:length(wlat)
        tmp=squeeze(ws_climo(:,j,i));
        if ~all(isnan(tmp))
            dayofmax_ws_climo(j,i)=min(find(tmp==max(tmp)));
        end
    end
end
wmask=interp2(lon,lat,mask.*landmask,wlon,wlat');
dayofmax_ws_climo=dayofmax_ws_climo.*wmask;
figure(13);clf
pcolor(wlon,wlat,dayofmax_ws_climo);shading flat;colorbar

wgridarea=grid_area(wlat,wlon);wgridarea=wgridarea.*wmask;wtotarea=nansum(nansum(wgridarea));
ind=find(wlat>5);
wtotareaNH=nansum(nansum(wgridarea(ind,:)));
tmp1=dayofmax_ws_climo(ind,:);tmp2=wgridarea(ind,:);[fwNH]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);
ind=find(wlat<-5);
wtotareaSH=nansum(nansum(wgridarea(ind,:)));
tmp1=dayofmax_ws_climo(ind,:);tmp2=wgridarea(ind,:);[fwSH]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);

figure(131);clf
plot(1:366,smooth(fwNH(1:end-1)/wtotareaNH,7),'k') 
hold on
plot(1:366,smooth(fwSH(1:end-1)/wtotareaSH,7),'r')
xlim([1 366])
pbaspect([2 1 1])
print -f131 -depsc 'images/monthOFmaxWS_NH_SH'

%% wind speed minimum
dayofmin_ws_climo=zeros(length(wlat),length(wlon))*NaN;
for i=1:length(wlon)
    for j=1:length(wlat)
        tmp=squeeze(ws_climo(:,j,i));
        if ~all(isnan(tmp))
            dayofmin_ws_climo(j,i)=min(find(tmp==min(tmp)));
        end
    end
end
wmask=interp2(lon,lat,mask.*landmask,wlon,wlat');
dayofmin_ws_climo=dayofmin_ws_climo.*wmask;
figure(13);clf
pcolor(wlon,wlat,dayofmin_ws_climo);shading flat;colorbar

wgridarea=grid_area(wlat,wlon);wgridarea=wgridarea.*wmask;wtotarea=nansum(nansum(wgridarea));
ind=find(wlat>5);
wtotareaNH=nansum(nansum(wgridarea(ind,:)));
tmp1=dayofmin_ws_climo(ind,:);tmp2=wgridarea(ind,:);[fwNH]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);
ind=find(wlat<-5);
wtotareaSH=nansum(nansum(wgridarea(ind,:)));
tmp1=dayofmin_ws_climo(ind,:);tmp2=wgridarea(ind,:);[fwSH]=weightedhistc(tmp1(:),tmp2(:),.5:366.5);

figure(1311);clf
plot(1:366,smooth(fwNH(1:end-1)/wtotareaNH,7),'k') 
hold on
plot(1:366,smooth(fwSH(1:end-1)/wtotareaSH,7),'r')
xlim([1 366])
pbaspect([2 1 1])
print -f1311 -depsc 'images/monthOFminWS_NH_SH'



