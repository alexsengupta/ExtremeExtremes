clear; close all

load('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/largest_area_SSTA_MHW_maxSSTA2.mat')
fn='/Users/z3045790/OneDrive/DATASETS/mhw_12_2018/mhw_severity.pc90.330to360.70to90.1981.2018.nc'
time=nc_varget(fn,'time');
time(13231:end)=[];
dvec=datevec(time+datenum(1,1,1));
dnum=time+datenum(1,1,1);
decyear=decimalyear(dnum);

%something happened to length of matrices (chop of the ends)
AREA10_90pc_nonino(13231:end,:)=[];
INTINTENSITY10_90pc_nonino(13231:end,:)=[];
MAXSEV10_sev2_nonino(13231:end,:)=[];
AREA10_sev2_nonino(13231:end,:)=[];
INDEX10_90pc_nonino(13231:end,:)=[];
INTINTENSITY10_sev2_nonino(13231:end,:)=[];
MAXSSTA10_90pc_nonino(13231:end,:)=[];
INDEX10_sev2_nonino(13231:end,:)=[];
MAXSEV10_90pc_nonino(13231:end,:)=[];
MAXSSTA10_sev2_nonino(13231:end,:)=[];
BOUND10_sev2_nonino(13231:end)=[];
BOUND10_90pc_nonino(13231:end)=[];

fn='/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/iceedge.nc';
imask=nc_varget(fn,'mask');
lon=nc_varget(fn,'lon');
lat=nc_varget(fn,'lat');
imask=imask./imask;
imask(lat>80,:)=NaN;imask(lat<-70,:)=NaN;imask(isnan(imask))=0;
totarea=grid_area(lat,lon);
totarea=totarea.*imask;
totarea=nansum(totarea(:));

[~,~,~,nino34,~,~,obstime]=nino_indices_HadISST();

[nino34,ninotime,runs,runsln]=nino34_bands(0.5);
[nino34,ninotime,runs1,runsln1]=nino34_bands(1);
[nino34,ninotime,runs2,runsln2]=nino34_bands(2);

%%
yl=3;
ylm=-3;
figure(1);clf
for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[ylm yl yl ylm],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[ylm yl yl ylm],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[ylm yl yl ylm],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[ylm yl yl ylm],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[ylm yl yl ylm],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[ylm yl yl ylm],[.6 .6 1],'Edgecolor','none');hold on
end
plot(obstime,smooth(nino34,3),'k');xlim([1982 2017])

%%
figure(2);clf
subplot(2,1,1)
yl=20;
ylm=0;
for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[ylm yl yl ylm],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[ylm yl yl ylm],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[ylm yl yl ylm],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[ylm yl yl ylm],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[ylm yl yl ylm],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[ylm yl yl ylm],[.6 .6 1],'Edgecolor','none');hold on
end
plot(decyear,AREA10_90pc(:,1)/totarea*100,'k')
% hold on
% plot(decyear,AREA10_90pc(:,2)/totarea*100,'r')
xlim([1982 2017.5])

subplot(2,1,2)
yl=4;
ylm=0;
for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[ylm yl yl ylm],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[ylm yl yl ylm],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[ylm yl yl ylm],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[ylm yl yl ylm],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[ylm yl yl ylm],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[ylm yl yl ylm],[.6 .6 1],'Edgecolor','none');hold on
end
plot(decyear,AREA10_sev2(:,1)/totarea*100,'k')
% hold on
% plot(decyear,AREA10_sev2(:,2)/totarea*100,'r')
xlim([1982 2017.5])


%%
figure(3);clf
subplot(2,1,1)
yl=6;
ylm=0;
for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[ylm yl yl ylm],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[ylm yl yl ylm],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[ylm yl yl ylm],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[ylm yl yl ylm],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[ylm yl yl ylm],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[ylm yl yl ylm],[.6 .6 1],'Edgecolor','none');hold on
end
plot(decyear,MAXSEV10_90pc(:,1),'k')
xlim([1982 2017.5]);ylim([1 6])

subplot(2,1,2)
yl=6;
ylm=0;
for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[ylm yl yl ylm],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[ylm yl yl ylm],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[ylm yl yl ylm],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[ylm yl yl ylm],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[ylm yl yl ylm],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[ylm yl yl ylm],[.6 .6 1],'Edgecolor','none');hold on
end
plot(decyear,MAXSEV10_sev2(:,1),'k')
xlim([1982 2017.5]);ylim([2 6])

% %%
% nino34i=interp1(obstime,nino34,decyear);
% ind=find(nino34i<0);
% figure(4);clf
% plot(decyear(ind),AREA10_sev2(ind,1),'.')

%% main figure
figure(20);clf
yl=20;
ylm=0;
for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[ylm yl yl ylm],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[ylm yl yl ylm],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[ylm yl yl ylm],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[ylm yl yl ylm],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[ylm yl yl ylm],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[ylm yl yl ylm],[.6 .6 1],'Edgecolor','none');hold on
end
plot(decyear,AREA10_90pc(:,1)/totarea*100,'k')
hold on
plot(decyear,AREA10_90pc_nonino(:,1)/totarea*100,'r')

% xlabel('Duration');
ylabel('Propotion of Ocean')
pbaspect([3 1 1])
xlim([1982 2017.5])
title('Largest contiguous MHW')

%% main figure Sev >2
figure(21);clf
yl=4;
ylm=0;
for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[ylm yl yl ylm],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[ylm yl yl ylm],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[ylm yl yl ylm],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[ylm yl yl ylm],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[ylm yl yl ylm],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[ylm yl yl ylm],[.6 .6 1],'Edgecolor','none');hold on
end
plot(decyear,AREA10_sev2(:,1)/totarea*100,'k')
hold on
plot(decyear,AREA10_sev2_nonino(:,1)/totarea*100,'r')

% xlabel('Duration');
ylabel('Propotion of Ocean')
pbaspect([3 1 1])
xlim([1982 2017.5])
title('Largest contiguous MHW (sev>2)')

print -f20 -depsc 'images/largestMHW_timeseries'
print -f21 -depsc 'images/largestMHW_sev2_timeseries'


%% main figure AS ABOVE WITH AREA INSTEAD OF PROPORTION
figure(22);clf
plot(decyear,AREA10_90pc(:,1),'k')
hold on
plot(decyear,AREA10_90pc_nonino(:,1),'r')

% xlabel('Duration');
ylabel('Area of Ocean')
pbaspect([3 1 1])
xlim([1982 2017.5])
title('Largest contiguous MHW')

%% main figure Sev >2  AS ABOVE WITH AREA INSTEAD OF PROPORTION
figure(23);clf
plot(decyear,AREA10_sev2(:,1),'k')
hold on
plot(decyear,AREA10_sev2_nonino(:,1),'r')

% xlabel('Duration');
ylabel('Area of Ocean')
pbaspect([3 1 1])
xlim([1982 2017.5])
title('Largest contiguous MHW (sev>2)')

print -f22 -depsc 'images/largestMHW_timeseries_area'
print -f23 -depsc 'images/largestMHW_sev2_timeseries_area'

%% plot a specific day
figure(8);clf
plot(AREA10_90pc(:,1)/totarea*100,'k')
hold on
plot(AREA10_90pc_nonino(:,1)/totarea*100,'r')
pbaspect([3 1 1])
ninoI=interp1(obstime,nino34,decyear);ninoI=ninoI/std(ninoI);
plot(ninoI*3+5,'g');plot([1 length(ninoI)],[5 5])

figure(9);clf
plot(AREA10_sev2(:,1)/totarea*100,'k')
hold on
plot(AREA10_sev2_nonino(:,1)/totarea*100,'r')
pbaspect([3 1 1])

%%
cm=[1 .9 .6
    .85 .3 .1
    .6 .1 .2
    .4 .1 .4];
% dd=7;mm=11;yy=1997; ind=find(dvec(:,1)==yy & dvec(:,2)==mm & dvec(:,3)==dd)

%largest contiguous area
ind=12606;

%largest noElNino contiguous area (Indian Ocean)
%ind=12666;

% %largest noElNino area, non during an EL Nino
% ind=12044;
%
% %2nd largest noElNino area  (N Pacific)
% ind=12044;
%
% %largest noElNino area in Atlantic (after 2010 El Nino)
ind=10445;
%
% %largest sev>2
% ind=12416
%
% %largest sev>2 outside EL Nino (western NPac)
% ind=11980
%
% % largest sev>2 La Nina
% ind=8893
%
% %largest sev>2 suring 2010 EN (long event)
% ind=10327
%
%
% ind=12360;

for cc=1
    switch cc
        case 1
            %largest LalNina
            ind=10616
        case 2
            %largest contiguous area
            ind=12606;
        case 3
            %largest noElNino contiguous area (Indian Ocean)
            ind=12666;
        case 4
            %largest noElNino area in Atlantic (after 2010 El Nino)
            ind=10445;
    end
    
    SSTA=zeros(length(lat),length(lon))*NaN;
    SEV=SSTA;
    for i=[0:30:330]
        
        for j=[-90:20:70] % only go from -70 to 70
            fn=['/Users/z3045790/OneDrive/DATASETS/mhw_12_2018/mhw_severity.pc90.',num2str(i),'to',num2str(i+30),'.',num2str(j),'to',num2str(j+20),'.1981.2018.nc'];
            
            ssta=nc_varget(fn,'ssta',[ind-1 0 0],[1 -1 -1]);
            severity=nc_varget(fn,'severity',[ind-1 0 0],[1 -1 -1]);
            mytime=nc_varget(fn,'time',ind-1,1);mydvec=datevec(mytime+datenum(1,1,1));
            jj=(j+90)*4+1;
            ii=i*4+1;
            SEV(jj:jj+79,ii:ii+119)=severity;
            SSTA(jj:jj+79,ii:ii+119)=ssta;
            
        end
    end
    SSTA(SSTA==0)=NaN;
    SEV(SEV==0)=NaN;
    figure(5);clf
    pcolor(lon,lat,SEV.*imask);shading flat
    caxis([1 5]);colorbar
    colormap([.8 .8 1
        .4 1 .4
        1 .5 .1
        1 .4 .8])
    B=BOUND10_90pc{ind};B=B{1};
    hold on
    plot(lon(B(:,2)),lat(B(:,1)),'k')
    ylim([-60 65])
    plotmap
    AREA10_90pc(ind,1)/totarea*100
    AREA10_sev2(ind,1)/totarea*100
    colormap(cm)
    pbaspect([1.7 1 1])
    title([num2str(mydvec(3)),'-',num2str(mydvec(2)),'-',num2str(mydvec(1)),'-'])
    
    figure(6);clf
    contourf(lon,lat,SSTA.*imask,[-5:.5:5],'linestyle','none');
    plotmap
    caxis([-3 3]);colorbar
    colormap(lbmap(21,'BlueRed'))
    B=BOUND10_90pc{ind};B=B{1};
    hold on
    plot(lon(B(:,2)),lat(B(:,1)),'k','linewidth',2)
    B=BOUND10_sev2{ind};B=B{1};
    plot(lon(B(:,2)),lat(B(:,1)),'r','linewidth',2)
    % subplot(2,1,2)
    % pcolor(lon,lat,SEV);shading flat
    % caxis([0 5]);colorbar
    ylim([-60 65]);xlim([0.5 359.5])
    pbaspect([1.7 1 1])
    title([num2str(mydvec(3)),'-',num2str(mydvec(2)),'-',num2str(mydvec(1))])
    lat_lon_labels(13,[],[])
%     print -f6 -depsc -painters  'images/largest_area_24_9_2010'
    print ('-painters','-depsc' ,'-f6',['images/largest_area_',num2str(mydvec(3)),'_',num2str(mydvec(2)),'_',num2str(mydvec(1))])
end