% Plot longest MHW info
% DURATION refers to duration of standard 90thpc MHW
% DURATION2 refers to MHW with severity>2
close all; clear


    n=36   
      cmapp=[0,0,0 ;102,0,102; 94,79,162; 22,80,220;0,120,250;52,154,188;241,243,180; 40,200,40 ;181,225,163;251,147,81;150,1,31;250,101,101;250,250,250]
        x = linspace(1,n,size(cmapp,1));
    xi = 1:n;
    yrmap = zeros(n,3);
    for ii=1:3
        yrmap(:,ii) = pchip(x,cmapp(:,ii),xi);
    end
    yrmap = (yrmap/255);
    
 mycmap =[    1.0000    1.0000    1.0000
    0.9418    0.9791    0.9941
    0.8837    0.9582    0.9882
    0.8255    0.9373    0.9824
    0.7673    0.9163    0.9765
    0.7092    0.8954    0.9700
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

load '/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/longest_events.mat'
mask=nc_varget('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/iceedge.nc','mask');

mask=mask./mask;
mask(lat>80,:)=NaN;mask(lat<-70,:)=NaN;
gridarea=grid_area(lat,lon);
tmp=gridarea.*mask;totarea=nansum(tmp(:));

figure(1);clf
contourf(lon,lat,mask.*DURATION(:,:,1),[0:30:400],'linestyle','none');%shading flat;
plotmap
pbaspect([1.8 1 1]);title('Duration of longest MHW')
colorbar('SouthOutside');caxis([0 300])
colormap(gca,mycmap)
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
plotmap;plot([0 360],[0 0],'k--')
lat_lon_labels([],[],[])
print -f1 -depsc -painters 'images/duration_of_longestMHW'

latmask=lat./lat;latmask(lat>=60)=NaN;latmask(lat<=-55)=NaN;
figure(101);clf
plot(latmask.*smooth(nanmean(mask.*DURATION(:,:,1),2),5),lat,'k');
hold on
plot(latmask.*smooth(nanmedian(mask.*DURATION(:,:,1),2),5),lat,'r');
ylim([-65 80]);pbaspect([.25 1 1])
set(gca,'ytick',[-60:30:60])
print -f101 -depsc  'images/duration_of_longestMHW_zavg'

figure(11);clf
contourf(lon,lat,mask.*DURATION2(:,:,1),[0:5:400],'linestyle','none');%shading flat;
plotmap
pbaspect([1.8 1 1]);title('Duration of longest s>=2 MHW')
colorbar('SouthOutside');caxis([0 100])
colormap(gca,mycmap)
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
plotmap;plot([0 360],[0 0],'k--')
lat_lon_labels([],[],[])
print -f11  -depsc -painters 'images/duration_of_longestMHW_severity2'

tmp=mask.*DURATION(:,:,1);IQR=prctile(tmp,[25 50 75]);
[f]=weightedhistc(tmp(:),gridarea(:),0:2:400);
tmp=mask.*DURATION2(:,:,1);IQRs2=prctile(tmp,[25 50 75]);
[fs2]=weightedhistc(tmp(:),gridarea(:),0:2:400);

figure(20);clf
plot(1:2:401,f/totarea,'b');hold on
plot(1:2:401,fs2/totarea,'r')
xlabel('Duration');ylabel('Propotion of Ocean')
pbaspect([1 1 1]);hold on
xlim([0 200])
figure(21);clf
plot(1:2:401,cumsum(f)/totarea,'b');hold on
plot(1:2:401,cumsum(fs2)/totarea,'r')
xlabel('Duration');ylabel('Propotion of Ocean')
pbaspect([1 1 1]);hold on
xlim([0 200])
plot([0 400],[.1 .1])
plot([0 400],[.25 .25])
plot([0 400],[.5 .5])
plot([0 400],[.75 .75])
plot([0 400],[.9 .9])
print -f20 -depsc 'images/pdf_duration_s1_s2'
print -f21 -depsc 'images/pdf_cum_duration_s1_s2'

figure(11);clf
pcolor(mask.*DURATION2(:,:,1));shading flat
colorbar;caxis([0 100])
colormap(mycmap)

CENTREDAY=floor(squeeze(STARTDAY(:,:,1)+0.5*DURATION(:,:,1)));
CENTREDAY2=floor(squeeze(STARTDAY2(:,:,1)+0.5*DURATION2(:,:,1)));
ind=find(~isnan(CENTREDAY)); CENTREDAY(ind)=decyear(CENTREDAY(ind));
ind=find(~isnan(CENTREDAY2)); CENTREDAY2(ind)=decyear(CENTREDAY2(ind));

figure(2);clf
pcolor(lon,lat,mask.*squeeze(CENTREDAY));shading flat;plotmap
caxis([1981.5 2017.5]);colormap(yrmap)%colormap(colorcube(35))
title('Central Date of longest MHW')
plotmap
colorbar('SouthOutside');
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
plotmap;
lat_lon_labels([],[],[])
colormap(colorscheme_1982_2017(1))

% find longest MHW in 2015-16
ind =find(or(CENTREDAY-squeeze(DURATION(:,:,1))/2/365<2015 , CENTREDAY+squeeze(DURATION(:,:,1))/2/365>2017));
tmp=mask.*squeeze(CENTREDAY);tmp(ind)=NaN;
figure(21);clf
pcolor(lon,lat,tmp);shading flat;plotmap
caxis([1981.5 2017.5]);colormap(yrmap)%colormap(colorcube(35))
title('Central Date of longest MHW')
plotmap
colorbar('SouthOutside');
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
plotmap;
lat_lon_labels([],[],[])


print -f2 -djpeg100 -r600 'images/centreDate_of_longestMHW'


subplot(2,1,2)
pcolor(lon,lat,squeeze(CENTREDAY2));shading flat;plotmap
colorbar;caxis([1981.5 2017.5]);colormap(yrmap)%colormap(colorcube(35))

% need to area weight

[nino34,ninotime,runs,runsln]=nino34_bands(0.5);
[nino34,ninotime,runs1,runsln1]=nino34_bands(1);
[nino34,ninotime,runs2,runsln2]=nino34_bands(2);

figure(33);clf
% NB weightedhistc uses edges (hist uses centres)
gridarea=grid_area(lat,lon);
tmp=gridarea.*mask;totarea=nansum(tmp(:));

for n=1:length(runs)
    patch([ninotime(runs(n,1)) ninotime(runs(n,1)) ninotime(runs(n,2)) ninotime(runs(n,2))],[-3 3 3 -3],[1 .9 .9],'Edgecolor','none');hold on
end
for n=1:length(runsln)
    patch([ninotime(runsln(n,1)) ninotime(runsln(n,1)) ninotime(runsln(n,2)) ninotime(runsln(n,2))],[-3 3 3 -3],[.9 .9 1],'Edgecolor','none');hold on
end
for n=1:length(runs1)
    patch([ninotime(runs1(n,1)) ninotime(runs1(n,1)) ninotime(runs1(n,2)) ninotime(runs1(n,2))],[-3 3 3 -3],[1 .75 .75],'Edgecolor','none');hold on
end
for n=1:length(runsln1)
    patch([ninotime(runsln1(n,1)) ninotime(runsln1(n,1)) ninotime(runsln1(n,2)) ninotime(runsln1(n,2))],[-3 3 3 -3],[.75 .75 1],'Edgecolor','none');hold on
end
for n=1:length(runs2)
    patch([ninotime(runs2(n,1)) ninotime(runs2(n,1)) ninotime(runs2(n,2)) ninotime(runs2(n,2))],[-3 3 3 -3],[1 .6 .6],'Edgecolor','none');hold on
end
for n=1:length(runsln2)
    patch([ninotime(runsln2(n,1)) ninotime(runsln2(n,1)) ninotime(runsln2(n,2)) ninotime(runsln2(n,2))],[-3 3 3 -3],[.6 .6 1],'Edgecolor','none');hold on
end

% [f]=weightedhistc(tmpsev(:),gridarea(:),1980:1/12:2018);
% bar(1980:1/12:2018,f/totarea,'Facecolor',[.4 .4 .4]);ylim([0 0.02]);xlim([1982 2017.5])
% [f]=weightedhistc(tmpssta(:),gridarea(:),1980:1/12:2018);
% b=bar(1980:1/12:2018,f/totarea,'Edgecolor','r','Facecolor','none');ylim([0 0.02]);xlim([1982 2017.5])
% alpha(b,.5)
% ylabel('Propotion of Ocean by month')
% set(gca,'xtick',1982.5:2017.5,'xticklabel',1982.5:2017.5);rotateticklabel(gca,90)
% pbaspect([4 1 1])
% plot(ninotime,nino34/1000+0.016,'k')
% plot([1982.5 2017.5],[0.016 0.016],'k--')
% print -f33 -depsc '../images/prop_of_ocean_with_most_severe_mhw'


yeartime=1980:1/12:2018
f=weightedhistc(CENTREDAY(:),gridarea(:),yeartime);
% bar(1980:1/12:2018,f/totarea,'Facecolor',[.4 .4 .4]);ylim([0 0.03]);xlim([1982 2017.5])
plot(1980:1/12:2018,f/totarea,'color',[1 .4 .4]);ylim([0 0.03]);xlim([1982 2017.5])
ylabel('Propotion of Ocean by month')
set(gca,'xtick',1982.5:2017.5,'xticklabel',1982.5:2017.5);rotateticklabel(gca,90)
pbaspect([4 1 1])
plot(ninotime,nino34/1000+0.024,'k')
plot([1982.5 2017.5],[0.024 0.024],'k--');xlim([1982 2017.5])
print -f33 -depsc 'images/prop_of_ocean_with_longest_mhw'

figure(34)
bar(1980:1/12:2018,cumsum(f)/totarea,'Facecolor',[.4 .4 .4]);;xlim([1982 2017.5])
print -f34 -depsc 'images/prop_of_ocean_with_longest_mhw_cumsum'
