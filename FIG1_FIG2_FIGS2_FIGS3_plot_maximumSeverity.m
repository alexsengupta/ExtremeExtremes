clear; close all
load('/Users/z3045790/OneDrive - UNSW/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/MaxSeverity_MAxSST_date.mat')
mask=nc_varget('/Users/z3045790/OneDrive - UNSW/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/iceedge.nc','mask');
mask=mask./mask;
mask(lat>80,:)=NaN;mask(lat<-70,:)=NaN;

cm=[.3 .7 .9
    .9 .7 .1
    .85 .3 .1
    .6 .1 .2
    .4 .1 .4];

cm=[.3*255 .7*255 .9*255
      255 218 103
      242 105 36
      203 57 39
      127 21 25]/255;

colors = colorscheme_1982_2017(1);
colors2 = colorscheme_1982_2017(2);

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

%% maximum ssta or severity across full record
latmask=lat./lat;latmask(lat>=60)=NaN;latmask(lat<=-55)=NaN;
figure(101);clf
contourf(lon,lat,smooth2a(MAXSEVERITY,2,2).*mask,[0:6],'linestyle','none')
caxis([0 5]);colormap(gca,cm)
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
plotmap;plot([0 360],[0 0],'k--')
lat_lon_labels([],[],[])
title('Maximum experiences severity (1982-2017)')
colorbar('SouthOutside','Ticks',[.5:4.5],...
         'TickLabels',{'','Moderate','Strong','Severe','Extreme'})
print -f101 -depsc -painters 'images/smax_severity_ssta'

figure(1011);clf
plot(latmask.*smooth(nanmean(MAXSEVERITY.*mask,2),5),lat,'k')
hold on
plot(latmask.*smooth(nanmedian(MAXSEVERITY.*mask,2),5),lat,'r')
ylim([-65 80]);xlim([2.5 4]);pbaspect([.25 1 1])
set(gca,'xtick',1:6)
print -f1011 -depsc -painters 'images/smax_severity_ssta_zavg'


     
figure(102);clf
contourf(lon,lat,smooth2a(MAXSSTA,2,2).*mask,[0:7],'linestyle','none')
caxis([1 6]);colormap(gca,cm)
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
plotmap;plot([0 360],[0 0],'k--')
lat_lon_labels([],[],[])
colorbar('SouthOutside','Ticks',[1.5:5.5],...
         'TickLabels',{'1.5','2.5','3.5','4.5','5.5'})
title('Maximum experienced SSTA (1982-2017)')
print -f102  -depsc -painters 'images/smax_intensity_ssta'

figure(1021);clf
plot(latmask.*smooth(nanmean(MAXSSTA.*mask,2),5),lat,'k')
hold on
plot(latmask.*smooth(nanmedian(MAXSSTA.*mask,2),5),lat,'r')
ylim([-65 80]);xlim([2 5.5]);pbaspect([.25 1 1])
set(gca,'xtick',1:6)
print -f1021 -depsc -painters 'images/smax_intensity_ssta_zavg'


gridarea=grid_area(lat,lon);
tmp=gridarea.*mask;totarea=nansum(tmp(:));
tmp=MAXSEVERITY.*mask;
% bins=.5:4.5;[f,X]=hist(tmp(:),bins);
% bar(bins,f)

figure(103);clf
% NB weightedhistc uses edges (hist uses centres)
[f]=weightedhistc(tmp(:),gridarea(:),0.5:6.5);
bar(1:7,f/totarea, 'BarWidth', 1)
xlabel('Severity');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])
xlim([1 7]);set(gca,'fontsize',14)
print -f103 -depsc 'images/PDF_maxSEV'


figure(104);clf
tmp=MAXSSTA.*mask;
[f]=weightedhistc(tmp(:),gridarea(:),-0:1:10);
bar(0.5:10.5,f/totarea, 'BarWidth', 1)
xlabel('SSTA');ylabel('Propotion of Ocean')
pbaspect([.7 1 1])
xlim([1 9]);set(gca,'fontsize',14)
print -f104 -depsc 'images/PDF_maxSSTA'




%% Date of maximum severity
landmask=MAXSSTA;landmask=landmask./landmask;

figure(3);clf
tmpsev=decyear(MAXSEVERITYindex).*landmask.*mask;
pcolor(lon,lat,tmpsev);shading flat
colorbar;plotmap;caxis([1981.5 2017.5]);colormap(yrmap);
pbaspect([1.8 1 1]);title('Date of maximum severity')
colormap(colors);

% figure(3);clf
% tmpsev=decyear(MAXSEVERITYindex).*landmask.*mask;
% contourf(lon,lat,tmpsev,1981.5:2018,'linestyle','none');
% colorbar;plotmap;caxis([1981.5 2017.5]);colormap(yrmap);
% pbaspect([1.8 1 1]);title('Date of maximum severity')
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
lat_lon_labels([],[],[])

figure(31);clf
tmpssta=decyear(MAXSSTAindex).*landmask.*mask;
pcolor(lon,lat,tmpssta);shading flat
colorbar;plotmap;caxis([1981.5 2017.5]);colormap(yrmap);
pbaspect([1.8 1 1]);title('Date of maximum SSTA')
colormap(colors);
ylim([-65 80]);xlim([0 360]);pbaspect([1.7 1 1])
lat_lon_labels([],[],[])
print -f3 -dtiff -r600 'images/date_of_maxSEV'
print -f31 -djpeg -r600 'images/date_of_maxSSTA'

pause
figure(3);clf
tmpsev=decyear(MAXSEVERITYindex).*landmask.*mask;
contourf(lon,lat,tmpsev,1981.5:.25:2017.5,'linestyle','none');
colorbar;plotmap;caxis([1981.5 2017.5]);colormap(yrmap);
pbaspect([1.8 1 1]);title('Year of maximum severity')
xlim([0 360]);ylim([-80 80])
print -f3 -dtiff -r600 'images/date_of_maxSEV'



%%
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

[f]=weightedhistc(tmpsev(:),gridarea(:),1980:1/12:2018);
bar(1980:1/12:2018,f/totarea,'Facecolor',[.4 .4 .4]);ylim([0 0.02]);xlim([1982 2017.5])
[f]=weightedhistc(tmpssta(:),gridarea(:),1980:1/12:2018);
b=bar(1980:1/12:2018,f/totarea,'Edgecolor','r','Facecolor','none');ylim([0 0.02]);xlim([1982 2017.5])
alpha(b,.5)
ylabel('Proportion of Ocean by month')
set(gca,'xtick',1982:2017,'xticklabel',1982:2017);rotateticklabel(gca,90)
pbaspect([4 1 1])
plot(ninotime,nino34/1000+0.016,'k')
plot([1982.5 2017.5],[0.016 0.016],'k--')
print -f33 -depsc 'images/prop_of_ocean_with_most_severe_mhw'

figure(88)
plot(ninotime,nino34,'k')
pbaspect([4 1 1])
xlim( 1.0e+03 *[ 1.9820    2.0175])
print -f88 -depsc 'images/prop_of_ocean_with_most_severe_mhw_EN'
% figure(331);clf
% plot(ninotime,nino34)
% set(gca,'xtick',1982.5:2017.5,'xticklabel',1982.5:2017.5);rotateticklabel(gca,90)
% pbaspect([4 1 1])
% xlim([1982 2017.5])
% print -f33 -depsc 'images/prop_of_ocean_with_most_severe_mhw_nino34'

figure(311);clf
[f]=weightedhistc(tmpsev(:),gridarea(:),1980:1/12:2018);
bar(1980:1/12:2018,f,'Facecolor',[.4 .4 .4]);xlim([1982 2017.5])


f=weightedhistc(tmpsev(:),gridarea(:),1980:1/12:2018);
nino34I=interp1(ninotime,nino34,1980:1/12:2018);
figure(34);clf
plot(nino34I/nanstd(nino34I),f,'.')
xlabel('Nino34 (standardised)');ylabel('Area with most severe MHW')
line(-2:.1:2.5,mylowess([(nino34I/nanstd(nino34I))',f'],-2:.1:2.5,0.5),'color','k','linestyle','-', 'linewidth',2)
print -f34 -dpdf 'images/nino34vsAreaMostSevere'

% tmp=nino34I/nanstd(nino34I);
% c=1
% for n=-2:.1:2.5
%     ind=find(tmp>(n-.5) & tmp<(n+.5))
%     ln(c)=median(f(ind));
%     c=c+1;
% end
% hold on
% plot(-2.5:.1:2.5,ln)

%% composite EN/LN years

tmpsev=decyear(MAXSEVERITYindex).*landmask.*mask;
tmpssta=decyear(MAXSSTAindex).*landmask.*mask;
nino34i=interp1(ninotime,nino34,decyear);
en1=find(nino34i>1);
ln1=find(nino34i<-1);
en2=find(nino34i>2);
ln2=find(nino34i<-2);
EN_mhw=zeros(length(lat),length(lon))*NaN;
LN_mhw=EN_mhw;
EN_mhw2=zeros(length(lat),length(lon))*NaN;
LN_mhw2=EN_mhw;
for i=1:length(lon)
    i
    for j=1:length(lat)
        tmp=tmpsev(j,i);
        
        if ~isnan(tmp);
            ind=find(tmp==decyear(en1));
            if ~isempty(ind)
                EN_mhw(j,i)=1;
            else
               EN_mhw(j,i)=0; 
            end
            
            ind=find(tmp==decyear(ln1));
            if ~isempty(ind)
                LN_mhw(j,i)=1;
            else
               LN_mhw(j,i)=NaN; 
            end
            
            ind=find(tmp==decyear(en2));
            if ~isempty(ind)
                EN_mhw2(j,i)=1;
            else
               EN_mhw2(j,i)=0; 
            end
            
            ind=find(tmp==decyear(ln2));
            if ~isempty(ind)
                LN_mhw2(j,i)=1;
            else
               LN_mhw2(j,i)=NaN; 
            end
        end
    end
end
ind=find(LN_mhw==1); EN_mhw(ind)=2;
ind=find(LN_mhw2==1); EN_mhw(ind)=2.5;
ind=find(EN_mhw2==1); EN_mhw(ind)=1.5;


ind=find(EN_mhw==1); %EN
en_area=sum(gridarea(ind));
ind=find(EN_mhw==1.5); %EN
en_area2=sum(gridarea(ind));
ind=find(EN_mhw==2); %EN
ln_area=sum(gridarea(ind));
ind=find(EN_mhw==2.5); %EN
ln_area2=sum(gridarea(ind));
ind=find(~isnan(EN_mhw)); %All
tot_area=sum(gridarea(ind));
disp(['% Time in EN>1: ',num2str(length(en1)/length(nino34i)*100)])
disp(['% Time in LN>1: ',num2str(length(ln1)/length(nino34i)*100)])
disp(['% Area in EN>1: ',num2str((en_area+en_area2)/tot_area*100)])
disp(['% Area in LN>1: ',num2str((ln_area+ln_area2)/tot_area*100)])
disp('')
disp(['% Time in EN>2: ',num2str(length(en2)/length(nino34i)*100)])
disp(['% Time in LN>2: ',num2str(length(ln2)/length(nino34i)*100)])
disp(['% Area in EN>2: ',num2str((en_area2)/tot_area*100)])
disp(['% Area in LN>2: ',num2str((ln_area2)/tot_area*100)])

%%
fn='/Users/z3045790/CCRC/DATASETS/HadISST/HadISST_sst.nc';
obslon=nc_varget ( fn, 'longitude');
obslat=nc_varget ( fn, 'latitude');
ind1lat=min(find(obslat<=-80));
ind2lat=max(find(obslat>=80));
obslat=nc_varget ( fn, 'latitude',ind2lat-1,(ind1lat-ind2lat+1));
obstime=nc_varget(fn, 'time');%'days since 1870-1-1 0:0:0'
dn=datenum(1870,1,1)
dat=datevec(datestr(double(dn+obstime)));
obstime=dat(:,1)+(dat(:,2)-1)/12+dat(:,3)/365;
obssst = nc_varget ( fn, 'sst', [0 ind2lat-1 0], [-1 (ind1lat-ind2lat+1) -1] );

% reorder
ind1=(find(obslon<0));ind2=(find(obslon>=0));
lon2(1:length(ind1))=obslon(ind2);
lon2(length(ind1)+1:length(obslon))=obslon(ind1)+360;
obssst2(:,:,1:length(ind1))=obssst(:,:,ind2);
obssst2(:,:,length(ind1)+1:length(obslon))=obssst(:,:,ind1);
obslon=lon2;obssst=obssst2;
clear *1 *2

obssst=permute(obssst,[2 3 1]);
obssst=double(obssst);
ssta=anomaly(obssst,1);
clear obssst


indi=find(obslon>=190 &obslon<=240);
indj=find(obslat<=5 & obslat>=-5);
nnino34=normalise1D(squeeze(nanmean(nanmean(ssta(indj,indi,:),1),2)));
ind=find(obstime>1950)
for i=1:length(obslon)
    i
    for j=1:length(obslat)
        tmp=squeeze(ssta(j,i,ind));
        p=polyfit(nnino34(ind),tmp,1);
        N34(j,i)=p(1);
%         [R(j,i),P(j,i)]=corr(nnino34,tmp);
    end
end

N34i=interp2(obslon,obslat,N34,lon,lat');

figure(41);clf
contourf(lon,lat,N34i.*mask,[-2:.1:2],'linestyle','none');
hold on
contourl(lon,lat,N34i.*mask,[-2:.2:0],'k','--',1,0)
contourl(lon,lat,N34i.*mask,[0:.2:2],'k','-',1,0)
contourl(lon,lat,N34i.*mask,[-99 0 99],'k','-',2,0)
caxis([-1 1]);ylim([-60 60])
colormap(lbmap(21,'BlueRed'))

figure(40);clf
pcolor(lon,lat,EN_mhw);shading flat;plotmap
caxis([0.2500    2.7500])
colormap([.9   .9  .9
    1    .6    .6
    1    0.2    0.2
    .6    .6    1
    .2    .2    1])

hold on
contourl(lon,lat,N34i.*mask,[-2:.1:0],'k','--',.5,0)
contourl(lon,lat,N34i.*mask,[0:.1:2],'k','-',.5,0)
contourl(lon,lat,N34i.*mask,[-99 0 99],'k','-',1,0)
pbaspect([1.8 1 1])
ylim([-80 80])
lat_lon_labels(14,[],[])
colorbar
print -f40 -djpeg100 -r300 'images/EN_LN_MHWcontribution' 

%% Animation of MHW with sliding window
save '/Users/z3045790/OneDrive - UNSW/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed data/sliding_window_animation_severity.mat' decyear MAXSEVERITYindex MAXSSTAindex lon lat landmask
pause
cmap=[1.0000    1.0000    1.0000
    0.9800    0.9488    0.9545
    0.9599    0.8976    0.9089
    0.9399    0.8464    0.8634
    0.9198    0.7952    0.8179
    0.8998    0.7440    0.7723
    0.8797    0.6928    0.7268
    0.8597    0.6416    0.6813
    0.8397    0.5904    0.6357
    0.8196    0.5392    0.5902
    0.7996    0.4880    0.5447
    0.7795    0.4368    0.4991
    0.7595    0.3856    0.4536
    0.7394    0.3344    0.4081
    0.7194    0.2832    0.3625
    0.6993    0.2320    0.3170
    0.6793    0.1808    0.2715
    0.6593    0.1296    0.2259
    0.6392    0.0784    0.1804
    0.6604    0.1326    0.2286
    0.6817    0.1869    0.2768
    0.7029    0.2411    0.3250
    0.7241    0.2953    0.3732
    0.7453    0.3495    0.4215
    0.7666    0.4037    0.4697
    0.7878    0.4579    0.5179
    0.8090    0.5121    0.5661
    0.8302    0.5663    0.6143
    0.8514    0.6205    0.6625
    0.8727    0.6747    0.7107
    0.8939    0.7290    0.7589
    0.9151    0.7832    0.8072
    0.9363    0.8374    0.8554
    0.9576    0.8916    0.9036
    0.9788    0.9458    0.9518
    1.0000    1.0000    1.0000];
figure(4)
tmpsev=decyear(MAXSEVERITYindex).*mask;
tmpssta=decyear(MAXSSTAindex).*mask;


for t=6259:7:length(decyear)
    clf
    subplot(2,1,1)
    tmp=decyear(t)-floor(decyear(t))
    
    pcolor(lon,lat,tmpsev);shading flat
    colorbar;plotmap;caxis([decyear(t)-1/2 decyear(t)+1/12]);
    
    pbaspect([1.8 1 1]);title(['Date of maximum severity ',num2str(round(tmp*12)),':',num2str(floor(decyear(t)))])
    subplot(2,1,2)
    
    pcolor(lon,lat,tmpssta);shading flat
    colorbar;plotmap;caxis([decyear(t)-1/2 decyear(t)+1/12]);
    pbaspect([1.8 1 1]);title(['Date of maximum ssta ',num2str(round(tmp*12)),':',num2str(floor(decyear(t)))])
    colormap(cmap)
    if t<10
        pre='0000';
    elseif t<100
        pre='000';
    elseif t<1000
        pre='00';
    elseif t<10000
        pre='0';
    else
        pre='';
    end
    print (['images/max_sev_ssta_date_',pre,num2str(t)],'-f4' ,'-djpeg', '-r200')
end
 %%
figure(5)
subplot(2,1,1)
duration=(MAXSEVERITY_endindex-MAXSEVERITY_startindex).*mask;
duration_s2=(MAXSEVERITY2_endindex-MAXSEVERITY2_startindex).*mask;
pcolor(lon,lat,duration);shading flat;caxis([0 400]);colorbar
subplot(2,1,2)
pcolor(lon,lat,duration_s2);shading flat;caxis([0 200]);colorbar

figure(6);clf
[f,x]=hist(duration(:),200);hold on
[f2,x2]=hist(duration_s2(:),200);
plot(x,f,'k')
plot(x2,f2,'r')
xlim([0 200])


%%
figure(10);clf
subplot(2,1,1)
mask=duration;
ind=find(mask>50);
mask(:)=NaN;mask(ind)=1;
tmpsev=decyear(MAXSSTAindex).*landmask.*mask;
pcolor(lon,lat,tmpsev);shading flat
colorbar;plotmap;caxis([1981.5 2017.5]);colormap(colorcube(36));
pbaspect([1.8 1 1]);title('Date of maximum SSTA with MHW duration > 50 days')

subplot(2,1,2)
mask=duration_s2;
ind=find(mask>14);
mask(:)=NaN;mask(ind)=1;
tmpsev=decyear(MAXSEVERITYindex).*landmask.*mask;
pcolor(lon,lat,tmpsev);shading flat
colorbar;plotmap;caxis([1981.5 2017.5]);colormap(colorcube(36));
pbaspect([1.8 1 1]);title('Date of maximum Severity with sev>2 for more than 14 days')