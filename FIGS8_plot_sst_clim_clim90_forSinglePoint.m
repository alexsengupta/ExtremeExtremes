clear;close all

fn=['/Users/z3045790/OneDrive/DATASETS/mhw_12_2018/mhw_severity.pc90.90to120.-30to-10.1981.2018.nc'];
severity=nc_varget(fn,'severity');severity(severity==0)=NaN;
ssta=nc_varget(fn,'ssta');


time=nc_varget(fn,'time');
lon=nc_varget(fn,'lon');
lat=nc_varget(fn,'lat');
time366=nc_varget(fn,'time366');
ssta=nc_varget(fn,'ssta');
severity=nc_varget(fn,'severity');
climatology=nc_varget(fn,'climatology');
climatology90=nc_varget(fn,'climatology90');

dvec=datevec(datenum(1,1,1)+time);
dectime=decimalyear(datenum(1,1,1)+time);
dvec366=datevec(datenum(1,1,1)+time366);

clim_recon=ssta*NaN;
clim_recon90=ssta*NaN;

for t=1:length(dvec)
    m=dvec(t,2);
    d=dvec(t,3);
    ind=find(dvec366(:,2)==m & dvec366(:,3)==d);
    clim_recon(t,:,:)=squeeze(climatology(ind,:,:));
    clim_recon90(t,:,:)=squeeze(climatology90(ind,:,:));
end
sst=clim_recon+ssta;


figure(1)
pcolor(lon,lat,squeeze(max(severity)));plotmap
caxis([0 5])

i=min(findnearest(lon,113))
j=min(findnearest(lat,-30))

figure(2);clf
plot(dectime,squeeze(sst(:,j,i)))
hold on
plot(dectime,squeeze(clim_recon(:,j,i)),'k')
plot(dectime,squeeze(clim_recon90(:,j,i)),'r')
plot(dectime,squeeze(clim_recon(:,j,i))+2*(squeeze(clim_recon90(:,j,i))-squeeze(clim_recon(:,j,i))),'r')
plot(dectime,squeeze(clim_recon(:,j,i))+3*(squeeze(clim_recon90(:,j,i))-squeeze(clim_recon(:,j,i))),'r')
plot(dectime,squeeze(clim_recon(:,j,i))+4*(squeeze(clim_recon90(:,j,i))-squeeze(clim_recon(:,j,i))),'r')
plot(dectime,squeeze(clim_recon(:,j,i))+5*(squeeze(clim_recon90(:,j,i))-squeeze(clim_recon(:,j,i))),'r')
xlim([2010 2012]);ylim([18 30])
pbaspect([2 1 1])
set(gca,'xtick',2000+0.1/12:2/12:2017)

print('-f2','-dpdf', '../images/SST_clim_clim90_ningalooN')



clear
load '/Users/alexsengupta/CCRC/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed data/MHW_count.mat'
fn='/Users/alexsengupta/CCRC/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed data/noaa_oi_lat_lon.nc'
lon=nc_varget(fn,'lon');
lat=nc_varget(fn,'lat');

mask=nc_varget('/Users/alexsengupta/CCRC/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed data/iceedge.nc','mask');
mask=mask./mask;
mask(lat>80,:)=NaN;mask(lat<-70,:)=NaN;


figure(1)
subplot(2,1,1)
pcolor(lon,lat,mask.*COUNT90);shading flat;caxis([0.05 0.15])
subplot(2,1,2)
pcolor(lon,lat,mask.*COUNTMHW);shading flat;caxis([0.05 0.15])

gridarea=grid_area(lat,lon);
tmp=gridarea.*mask;totarea=nansum(tmp(:));
tmp=COUNT90.*mask;

figure(2);clf
[f]=weightedhistc(tmp(:),gridarea(:),0:0.001:1);
subplot(2,1,1);bar(0.0005:0.001:1+0.0005,f/totarea)
xlabel('% time');ylabel('Propotion of Ocean')
xlim([0 .2])

tmp2=COUNTMHW.*mask;
[f2]=weightedhistc(tmp2(:),gridarea(:),0:0.001:1);
subplot(2,1,2);bar(0.0005:0.001:1+0.0005,f2/totarea)
xlabel('% time');ylabel('Propotion of Ocean')
xlim([0 .2])

figure(3);
subplot(2,1,1);bar(0.0005:0.001:1+0.0005,cumsum(f)/totarea);hold on
xlabel('% time');ylabel('Propotion of Ocean')
xlim([0 .2]);ylim([0 1])
plot([0 1],[0.5 0.5]);plot([0 1],[0.25 0.25]);plot([0 1],[0.75 0.75])
subplot(2,1,2);bar(0.0005:0.001:1+0.0005,cumsum(f2)/totarea);hold on
xlabel('% time');ylabel('Propotion of Ocean')
xlim([0 .2]);ylim([0 1])
plot([0 1],[0.5 0.5]);plot([0 1],[0.25 0.25]);plot([0 1],[0.75 0.75])