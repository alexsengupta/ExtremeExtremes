clear; close all

load '/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Code/CHL_U10_avSSTA_avSEV_collated.mat'
% decyr_chl CHLanomaly
% decyr_ws
% decyr U10anomaly  SEVaverage(f,:)erage SSTAaverage
% date_of_max_sev
% readme
% lon
% MHWmask
% MHWtime MHWarea
% rangelon
% rangelat

%%
for f=39%1:length(CHLanomaly(:,1))
    mask=MHWmask;mask(mask~=f)=NaN;mask=mask./mask;
    ind2=find(dvec_ws(:,1)==date_of_max_sev(f,1) & dvec_ws(:,2)==date_of_max_sev(f,2) & dvec_ws(:,3)==date_of_max_sev(f,3));
    figure(1);clf
    pcolor(lon,lat,mask);shading flat;plotmap
    figure(10);clf
    subplot(4,1,1)
    plot([1 1]*decyr_ws(ind2),[min(SEVaverage(f,:)) max(SEVaverage(f,:))],'color',[.6 .6 .6]);hold on
    plot(decyr,SEVaverage(f,:),'k');hold on
    plot([decyr(1) decyr(end)],[1 1],'b--')
    plot([decyr(1) decyr(end)],prctile(SEVaverage(f,:),90)*[1 1],'r')
    plot([decyr(1) decyr(end)],prctile(SEVaverage(f,:),99)*[1 1],'r');xlim([1982 2017.8]);title('Severity')
    subplot(4,1,2)
    plot([1 1]*decyr_ws(ind2),[min(SSTAaverage(f,:)) max(SSTAaverage(f,:))],'k');hold on
    plot(decyr,SSTAaverage(f,:),'k');hold on
    plot([decyr(1) decyr(end)],[0 0],'b--')
    plot([decyr(1) decyr(end)],prctile(SSTAaverage(f,:),90)*[1 1],'r')
    plot([decyr(1) decyr(end)],prctile(SSTAaverage(f,:),99)*[1 1],'r');xlim([1982 2017.8]);title('SSTA')
    subplot(4,1,3)
    WSav=smooth(U10anomaly(f,:),30);
    plot([1 1]*decyr_ws(ind2),[min(WSav) max(WSav)],'k');hold on
    plot(decyr_ws,WSav,'k');hold on
    plot([decyr_ws(1) decyr_ws(end)],[0 0],'b--')
    plot([decyr_ws(1) decyr_ws(end)],prctile(WSav,10)*[1 1],'r')
    plot([decyr_ws(1) decyr_ws(end)],prctile(WSav,1)*[1 1],'r');xlim([1982 2017.8]);title('WS')
    subplot(4,1,4)
    plot([1 1]*decyr_ws(ind2),[min(CHLanomaly(f,:)) max(CHLanomaly(f,:))],'k');hold on
    plot(decyr_chl,CHLanomaly(f,:),'k');hold on
    plot([decyr_chl(1) decyr_chl(end)],[0 0],'b--')
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),99)*[1 1],'r')
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),90)*[1 1],'r');
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),10)*[1 1],'r')
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),1)*[1 1],'r');xlim([1982 2017.8]);title('CHLa')
    
    figure(11);clf
    win=2.5;
    subplot(4,1,1)
    plot([1 1]*decyr_ws(ind2),[min(SEVaverage(f,:)) max(SEVaverage(f,:))],'color',[.6 .6 .6]);hold on
    plot(decyr,SEVaverage(f,:),'k');hold on
    plot([decyr(1) decyr(end)],[1 1],'b--')
    plot([decyr(1) decyr(end)],prctile(SEVaverage(f,:),90)*[1 1],'r')
    plot([decyr(1) decyr(end)],prctile(SEVaverage(f,:),99)*[1 1],'r');xlim([max([decyr_ws(ind2)-win 1982]) min([decyr_ws(ind2)+win 2017.8])]);title('Severity')
    subplot(4,1,2)
    plot([1 1]*decyr_ws(ind2),[min(SSTAaverage(f,:)) max(SSTAaverage(f,:))],'k');hold on
    plot(decyr,SSTAaverage(f,:),'k');hold on
    plot([decyr(1) decyr(end)],[0 0],'b--')
    plot([decyr(1) decyr(end)],prctile(SSTAaverage(f,:),90)*[1 1],'r')
    plot([decyr(1) decyr(end)],prctile(SSTAaverage(f,:),99)*[1 1],'r');xlim([max([decyr_ws(ind2)-win 1982]) min([decyr_ws(ind2)+win 2017.8])]);title('SSTA')
    subplot(4,1,3)
    WSav=smooth(U10anomaly(f,:),30);
    plot([1 1]*decyr_ws(ind2),[min(WSav) max(WSav)],'k');hold on
    plot(decyr_ws,WSav,'k');hold on
    plot([decyr_ws(1) decyr_ws(end)],[0 0],'b--')
    plot([decyr_ws(1) decyr_ws(end)],prctile(WSav,10)*[1 1],'r')
    plot([decyr_ws(1) decyr_ws(end)],prctile(WSav,1)*[1 1],'r');xlim([max([decyr_ws(ind2)-win 1982]) min([decyr_ws(ind2)+win 2017.8])]);title('WS')
    subplot(4,1,4)
    plot([1 1]*decyr_ws(ind2),[min(CHLanomaly(f,:)) max(CHLanomaly(f,:))],'k');hold on
    plot(decyr_chl,CHLanomaly(f,:),'k');hold on
    plot([decyr_chl(1) decyr_chl(end)],[0 0],'b--')
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),99)*[1 1],'r')
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),90)*[1 1],'r');
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),10)*[1 1],'r')
    plot([decyr_chl(1) decyr_chl(end)],prctile(CHLanomaly(f,:),1)*[1 1],'r');xlim([max([decyr_ws(ind2)-win 1982]) min([decyr_ws(ind2)+win 2017.8])]);title('CHLa')
    pause
end
%% Calculate normalised wind speed 30 dat mean at a lag before MHW peak
% and chl-a concurrent with MHW
lag=15; %days
dvec_chlor=datevec(chlor_time);
for f=1:length(CHLanomaly(:,1))
    ind2=find(dvec_ws(:,1)==date_of_max_sev(f,1) & dvec_ws(:,2)==date_of_max_sev(f,2) & dvec_ws(:,3)==date_of_max_sev(f,3));
    WSav=smooth(U10anomaly(f,:),30);
    WSnorm(f)=WSav(ind2-lag)/std(WSav);
    WSmhw(f)=WSav(ind2-lag);
    if decyr_ws(ind2)>=decyr_chl(1)
        ind=findnearest(decyr_ws(ind2),decyr_chl);
        CHLnorm(f)=mean(CHLanomaly(f,ind))/nanstd(CHLanomaly(f,:));
        CHLmhw(f)=mean(CHLanomaly(f,ind));
    else
        CHLnorm(f)=NaN;
        CHLmhw(f)=NaN;
    end
end

%% Monte Carlo
% Select random dates for WS and CHL-a
for f=1:length(CHLanomaly(:,1))
    f
    WSav=smooth(U10anomaly(f,:),30);
    WSstd=std(WSav);
    CHstd=nanstd(CHLanomaly(f,:));
    for N=1:10000
        ind2=floor(length(WSav)*rand)+1;
        WSnormMC(N,f)=WSav(ind2)/WSstd;
        if decyr_ws(ind2)>=decyr_chl(1)
            ind=findnearest(decyr_ws(ind2),decyr_chl);
            CHLnormMC(N,f)=mean(CHLanomaly(f,ind))/CHstd;
        else
            CHLnormMC(N,f)=NaN;
        end
    end
end

CHLnormMC2=CHLnormMC*NaN;
for f=find(~isnan(CHLnorm))
    f
    CHstd=nanstd(CHLanomaly(f,:));
    for N=1:10000
        ind2=floor(length(CHLanomaly)*rand)+1;
        CHLnormMC2(N,f)=mean(CHLanomaly(f,ind2))/CHstd;
    end
end


[N,X] =hist(WSnorm,-10:.5:10)
subplot(2,1,2)
[NC,X] =hist(CHLnorm,-10:.5:10)

for n=1:10000
    [Nmc(n,:),Xmc] =hist(WSnormMC(n,:),-10:.5:10);
    [NCmc(n,:),Xmc] =hist(CHLnormMC(n,:),-10:.5:10);
    [NCmc2(n,:),Xmc] =hist(CHLnormMC2(n,:),-10:.5:10);
end
figure(1);clf
subplot(2,1,1)
plot(X,N,'-o','linewidth',2);hold on
subplot(2,1,2)
plot(X,NC,'-o','linewidth',2);hold on

% for n=1:10000
%     subplot(2,1,1)
%     plot(X,Nmc(n,:),'-');hold on
%     subplot(2,1,2)
%     plot(X,NCmc(n,:),'-');hold on
%     pause
% end


figure(1);clf
subplot(2,1,1)
plot(X,N,'-o','linewidth',2);hold on
plot(X,median(Nmc),'k')
plot(X,prctile(Nmc,95),'b')
plot(X,prctile(Nmc,99),'r')
plot(X,prctile(Nmc,99.9),'r--')
plot(X,prctile(Nmc,1),'r')
plot(X,prctile(Nmc,5),'b');xlim([-5 5]);set(gca,'xtick',-5:5)
title('WS prior to max severity')
% NB only 5 of the 62 regions have normalised WS that is anomalously strong
% (anomalies in these cases are all weak)
pbaspect([1.5 1 1])
subplot(2,1,2)
plot(X,NC,'-o','linewidth',2);hold on
% plot(X,median(NCmc),'k')
% plot(X,prctile(NCmc,95),'b')
% plot(X,prctile(NCmc,99),'r')
% plot(X,prctile(NCmc,99.9),'r--')
% plot(X,prctile(NCmc,1),'r')
% plot(X,prctile(NCmc,5),'b');xlim([-5 5])

plot(X,median(NCmc2),'k')
plot(X,prctile(NCmc2,95),'b')
plot(X,prctile(NCmc2,99),'r')
plot(X,prctile(NCmc2,99.9),'r--')
plot(X,prctile(NCmc2,1),'r')
plot(X,prctile(NCmc2,5),'b');xlim([-5 5]);set(gca,'xtick',-5:5)
pbaspect([1.5 1 1])
title('CHL concurrent with max severity')
% NB only 16 of the 62 regions have normalised Chl that is anomalously
% high

ind=find(WSnorm>-0);
mymask=MHWmask*NaN;
for n=1:length(ind);
    ind2=find(MHWmask==ind(n));
    mymask(ind2)=WSnorm(ind(n));
end
ind=find(CHLnorm>0)
mymaskc=MHWmask*NaN;
for n=1:length(ind);
    ind2=find(MHWmask==ind(n));
    mymaskc(ind2)=CHLnorm(ind(n));
end
figure(5);clf
subplot(2,1,1)
pcolor(lon,lat,mymask);shading flat;plotmap;colorbar;grid on
subplot(2,1,2)
pcolor(lon,lat,mymaskc);shading flat;plotmap;colorbar;grid on

% A frequency distribution of normalised wind stress anomalies for the 62
% regions averaged over the month leading up to the peak of the MHW clearly
% shows the importance of surface wind strength in the development of
% extreme MHW. The distribution is eavily skewed towards anomalously low
% wind speeds. Indeed only 5 out of the 62 regions have anomalously high
% windspeeds prior to the MHW peak.

% Strong surface warming is also likely to be related to increased
% stratification and surpressed mixing. As such we might expect large MHW
% to be assocated with lowered productivty. Fig X, shows the distribution of
% normalised chl-a at the peak of the MHW. This demonstates that a
% significant productuivity signal is discernable with ~70% of extreme
% MHW associated with supressed producyivity [NB only events post 1997 can be evaluated, due to the availability of satellite chl-a data]
% Greatest suppression tends to occur at lower latitudes with a shift
% towards enhanced productivity at high latitudes [could be related to
% shift between nutrient limited and light limited regimes], however an
% investigation of more events are needed to establish how robust a pattern
% this is

% Figure caption
% a)Frequency histogram of normalised wind speed anomalies avereraged over the month preceeding the MHW peak (wind speed
% anomalies are averaged over each region in Fig X and divided by the
% standard deviation of the wind speed anomaly timeseries). Superimposed
% are estimated 1,5,10,90,95,99 & 99.9 percentile distributions based on a
% Monte Carlo random sampling of dates (repreated 10,000 times for each
% region). b) As a) for normalised monthly-averaged chlorophyll-a concurrent with the MHW
% peak. To obtain the longest possible Chlorophyll-a record we have
% combined SEAWIF () and MODIS (url;date range) level 3 monthly satellite data. At each grid
% point a linear regression model is derived between SEAWIF and MODIS data over the
% overlap period. This is used to extend the MODIS data backwards in time
% using modified SEAWIFS data.


%% latitudinal breakdown
figure(6);clf
for f=1:62
    subplot(1,2,1)
    plot([1 1]*WSnorm(f),rangelat(f,:));hold on;grid on
    plot(WSnorm(f),mean(rangelat(f,:)),'k.')
    title('normalised WS by latitude')
    subplot(1,2,2)
    plot([1 1]*CHLnorm(f),rangelat(f,:));hold on;grid on
    plot(CHLnorm(f),mean(rangelat(f,:)),'k.')
    title('normalised CHL by latitude')
end
p=polyfit(mean(rangelat,2),WSnorm',2); Y = polyval(p,-60:60);
subplot(1,2,1);    plot(Y,[-60:60],'k')
ind=find(~isnan(CHLnorm));
p=polyfit(mean(rangelat(ind,:),2),CHLnorm(ind)',2); Y = polyval(p,-60:60);ylim([-70 70])
subplot(1,2,2);    plot(Y,[-60:60],'k');ylim([-70 70])

figure(7);clf
for f=1:62
    subplot(1,2,1)
    plot([1 1]*WSmhw(f),rangelat(f,:));hold on;grid on
    plot(WSmhw(f),mean(rangelat(f,:)))
    title('WS by latitude')
    subplot(1,2,2)
    plot([1 1]*CHLmhw(f),rangelat(f,:));hold on;grid on
    plot(CHLmhw(f),mean(rangelat(f,:)))
    title('CHL by latitude')
end
p=polyfit(mean(rangelat,2),WSmhw',2); Y = polyval(p,-60:60);
subplot(1,2,1);    plot(Y,[-60:60],'k')
ind=find(~isnan(CHLmhw));
p=polyfit(mean(rangelat(ind,:),2),CHLmhw(ind)',2); Y = polyval(p,-60:60);
subplot(1,2,2);    plot(Y,[-60:60],'k')

%%  WSnorm and CHL norm

mymask=MHWmask*NaN;
mymaskmhw=MHWmask*NaN;
for n=1:62
    ind2=find(MHWmask==n);mymask(ind2)=WSnorm(n);
    mymaskmhw(ind2)=WSmhw(n);
end

mymaskc=MHWmask*NaN;
mymaskcmhw=MHWmask*NaN;
for n=1:62
    ind2=find(MHWmask==n);mymaskc(ind2)=CHLnorm(n);
    mymaskcmhw(ind2)=CHLmhw(n);
end

figure(8);clf
subplot(2,1,1)
pcolor(lon,lat,mymask);shading flat;plotmap;colorbar;grid on;caxis([-3 3]);colormap(lbmap(21,'BlueRed'))
title('normalised WS')
subplot(2,1,2)
pcolor(lon,lat,mymaskc);shading flat;plotmap;colorbar;grid on;caxis([-3 3]);colormap(lbmap(21,'BlueRed'))
title('normalised CHL')

figure(9);clf
subplot(2,1,1)
pcolor(lon,lat,mymaskmhw);shading flat;plotmap;colorbar;grid on;caxis([-3 3]);colormap(lbmap(21,'BlueRed'))
title('WS')
subplot(2,1,2)
pcolor(lon,lat,mymaskcmhw);shading flat;plotmap;colorbar;grid on;caxis([-.2 .2]);colormap(lbmap(21,'BlueRed'))
title('CHL')


print -f6 -depsc 'normalised_WS_CHL_byLat'
print -f1 -depsc 'normalised_WS_CHL_hist'