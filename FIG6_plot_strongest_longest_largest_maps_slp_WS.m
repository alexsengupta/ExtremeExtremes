clear;close all

cm=[.9 .9 .9
    .9 .7 .1
    .85 .3 .1
    .6 .1 .2
    .4 .1 .4];

load '/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/table_data_strongest_longest_largest.mat'

load '/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/max_sev_dur_date.mat'% created in plot_longestANDstrongest
files=dir('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/long_strong_*')
area=grid_area(lat,lon).*mask;
MHWmask=mask.*NaN;
for f=1:length(files)
    load(['/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/',files(f).name]);
    ind=find(~isnan(mhwmask.*mask));
    MHWmask(ind)=f;
    MHWarea(f)=nansum(nansum(area(ind)));
    COORD{f}=coord;
    MHWtime(f,:)=IDR;
end
mask0=mask;mask0(isnan(mask0))=0

fn='/Users/z3045790/OneDrive/DATASETS/mhw_12_2018//mhw_severity.pc90.0to30.-90to-70.1981.2018.nc'
alltime=nc_varget(fn,'time');
dvec=datevec(alltime+datenum(1,1,1));
yr=dvec(:,1);
mn=dvec(:,2);
dy=dvec(:,3);

fnws='/Users/z3045790/CCRC/DATASETS/ERA_interim/ERA_interim_windspeed_1979_2017_anom_climo.nc';
fnslp='/Users/z3045790/CCRC/DATASETS/ERA_interim/ERA_interim_SLP_1979_2017_anom_climo.nc';
alltime_slp=nc_varget(fnslp,'time');
%time:units = "days since 1900-01-01 00:00:0.0"
dvec_slp=datevec(alltime_slp+datenum(1900,1,1));
lon_slp=nc_varget(fnslp,'lon');
lat_slp=nc_varget(fnslp,'lat');

for f=1:length(dat_MAX_INT_CONTIG_INTREG_SEV2)
    
    pcolor(lon,lat,MHWmask);caxis([f-.5 f+.5]);shading flat
    plotmap
    myyr=dat_MAX_INT_DATE_SEV2(f,1);
    mymn=dat_MAX_INT_DATE_SEV2(f,2);
    mydy=dat_MAX_INT_DATE_SEV2(f,3);
    
    tmp=MHWmask;tmp(tmp~=f)=NaN;
    clf;pcolor(lon,lat,tmp);caxis([f-.5 f+.5]);shading flat;plotmap
    
    switch f
        case 1
            xl=[0 360];
            yl=[-90 90];
            
    end
    ind1=find(yr==myyr & mn==mymn & dy==mydy);
    SEV=zeros(720,1440);SSTA=SEV;
    mytime=nc_varget(fn,'time',[ind1-1],1);
    mydvec=datevec(datenum(1,1,1)+mytime);
    for i=0:30:330
        i
        for j=-90:20:70
            fn=['/Users/z3045790/OneDrive/DATASETS/mhw_12_2018//mhw_severity.pc90.',num2str(i),'to',num2str(i+30),'.',num2str(j),'to',num2str(j+20),'.1981.2018.nc'];
            mhw=squeeze(nc_varget(fn,'severity',[ind1-1 0 0],[1 -1 -1]));
            jj=(j+90)*4+1;
            ii=i*4+1;
            SEV(jj:jj+79,ii:ii+119)=mhw;
            mhw=squeeze(nc_varget(fn,'ssta',[ind1-1 0 0],[1 -1 -1]));
            SSTA(jj:jj+79,ii:ii+119)=mhw;
        end
    end
    landmask=SSTA;landmask=landmask./landmask;landmask(isnan(landmask))=0;
    SEV2=SEV;SEV2(SEV2<2)=NaN;SEV2(isnan(SEV2))=0;
    SEV(isnan(SEV))=0;SSTA(SSTA==0)=NaN;
    
    % sanity check
    indf=find(MHWmask==f);
    [B,L] = bwboundaries(SEV,'noholes');
    %Find all contiguous areas that interesect with region
    Lunique=unique(L(indf)); Lunique(Lunique==0)=[];
    clear Larea* maxssta maxsev intensity
    % find largest contiguous area inside region sev>1
    tmpL=L;tmpL(:)=0;
    if ~isempty(Lunique)
        for c=1:length(Lunique)
            ind=find(L==Lunique(c) & MHWmask==f);
            Larea(c)=nansum(area(ind));
            ind=find(L==Lunique(c));
            tmpL(ind)=1;
            Lareafull(c)=nansum(area(ind));
            maxssta(c)=max(SSTA(ind));
            maxsev(c)=max(SEV2(ind));
            intensity(c)=nansum(area(ind).*SSTA(ind));
        end
        ind=find(Larea==max(Larea));
        % Choose contiguous region that covers the largest proportion of
        % the region
        prcAREAcontigINregion(f)=Larea(ind(1))/MHWarea(f);
        AREAcontig(f)=Lareafull(ind(1));
        MAXSSTAcontig(f)=maxssta(ind(1));
        MAXSEVcontig(f)=maxsev(ind(1));
        INTENSEcontig(f)=intensity(ind(1));
    else
        prcAREAcontigINregion(f)=NaN;
        AREAcontig(f)=NaN;
        MAXSSTAcontig(f)=NaN;
        MAXSEVcontig(f)=NaN;
        INTENSEcontig(f)=NaN;
    end
    
    % SEV2
    indf=find(MHWmask==f);
    [B,L] = bwboundaries(SEV2,'noholes');
    %Find all contiguous areas that interesect with region
    Lunique=unique(L(indf)); Lunique(Lunique==0)=[];
    clear Larea* maxssta maxsev intensity
    % find largest contiguous area inside region sev>1
    tmpL_sev2=L;tmpL_sev2(:)=0;
    if ~isempty(Lunique)
        for c=1:length(Lunique)
            ind=find(L==Lunique(c) & MHWmask==f);
            Larea(c)=nansum(area(ind));
            ind=find(L==Lunique(c));
            tmpL_sev2(ind)=1;
            Lareafull(c)=nansum(area(ind));
            maxssta(c)=max(SSTA(ind));
            maxsev(c)=max(SEV2(ind));
            intensity(c)=nansum(area(ind).*SSTA(ind));
        end
        ind=find(Larea==max(Larea));
        % Choose contiguous region that covers the largest proportion of
        % the region
        prcAREAcontigINregion_sev2(f)=Larea(ind(1))/MHWarea(f);
        AREAcontig_sev2(f)=Lareafull(ind(1));
        MAXSSTAcontig_sev2(f)=maxssta(ind(1));
        MAXSEVcontig_sev2(f)=maxsev(ind(1));
        INTENSEcontig_sev2(f)=intensity(ind(1));
    else
        prcAREAcontigINregion_sev2(f)=NaN;
        AREAcontig_sev2(f)=NaN;
        MAXSSTAcontig_sev2(f)=NaN;
        MAXSEVcontig_sev2(f)=NaN;
        INTENSEcontig_sev2(f)=NaN;
    end
    %     Find lon lat extent of event to find xlim and ylim
    SEV(SEV==0)=NaN;
    
%     figure(2);clf
%     contourf(lon,lat,SEV,[0:6],'linestyle','none');shading flat;%plotmap
%     hold on
%     contourl(lon,lat,tmpL,[0.5 1.5],'r','-',.5,0);caxis([0 5])
%     %contourl(lon,lat,mask.*mhwmask,[f-.5 f+.5],'k','-',1,0);caxis([0 5])
%     contourl(lon,lat,mask0,[.5 1.5],'b','-',.5,0);
%     contourl(lon,lat,landmask,[.5 1.5],'k','-',.5,0);
%     contourl(lon,lat,tmpL_sev2,[0.5 1.5],'k','-',.5,0);colormap(gca,cm);
%     title(['Region ',num2str(f),' Severity (',num2str(mydy),'/',num2str(mymn),'/',num2str(myyr),')'])
%     set(gca,'FontSize',8);colorbar
%     fno=['../images/region_',num2str(f),'_sev_ssta_global']
%     print(fno,'-f2','-djpeg100','-r400')
    
    tmpL_sev2_all=tmpL_sev2;%used later on
    
    ALLevents(f,:,:)=SEV.*tmpL;
    ALLevents(ALLevents==0)=NaN;
    
    tmpL=tmpL.*mask;tmpL(isnan(tmpL))=0;
    tmpL_sev2=tmpL_sev2.*mask;tmpL_sev2(isnan(tmpL_sev2))=0;
    mhwmask=MHWmask;mhwmask(mhwmask~=f)=NaN;mhwmask(isnan(mhwmask))=0;
    figure(1);clf;
    subplot(2,1,1)
    contourf(lon,lat,SEV,[0:6],'linestyle','none');shading flat;
    caxis([0 5])
    hold on
    %contourl(lon,lat,tmpL,[0.5 1.5],'r','-',1,0);caxis([0 5])
    %contourl(lon,lat,mask.*mhwmask,[f-.5 f+.5],'k','-',1,0);caxis([0 5])
    contourl(lon,lat,mask0,[.5 1.5],'b','-',.5,0);
    contourl(lon,lat,landmask,[.5 1.5],'k','-',.5,0);
    contourl(lon,lat,tmpL_sev2,[0.5 1.5],'k','-',.5,0);colormap(gca,cm);
    ind=find(nansum(tmpL,1));    xl_=lon(range(ind));
    ind=find(nansum(tmpL,2));    yl_=lat(range(ind));
    xl(1)=max([0 xl_(1)-30]);xl(2)=min([360 xl_(2)+30]);
    yl(1)=max([-80 yl_(1)-30]);yl(2)=min([80 yl_(2)+30]);
    xlim(xl);ylim(yl);pbaspect([1.7 1 1]);colorbar
    title(['Region ',num2str(f),' Severity (',num2str(mydy),'/',num2str(mymn),'/',num2str(myyr),')'])
    set(gca,'FontSize',7)
    subplot(2,1,2)
    contourf(lon,lat,SSTA,[-10:.25:10],'linestyle','none');shading flat;
    hold on
    %contourl(lon,lat,tmpL,[0.5 1.5],'r','-',1,0);caxis([0 5])
    contourl(lon,lat,mask.*mhwmask,[f-.5 f+.5],'k','--',.75,0);caxis([-5 5])
    contourl(lon,lat,mask0,[.5 1.5],'b','-',.5,0);
    contourl(lon,lat,landmask,[.5 1.5],'k','-',.5,0);
    %contourl(lon,lat,tmpL_sev2,[0.5 1.5],'k','-',1,0);
    colormap(gca,lbmap(21,'BlueRed'))
    xlim(xl);ylim(yl);
    pbaspect([1.7 1 1]);colorbar
    title('SSTA');set(gca,'FontSize',7)
    fno=['../images/region_',num2str(f),'_sev_ssta']
    print(fno,'-f1','-djpeg100','-r400')
    
    %     figure(3);clf
    %     contourf(lon,lat,SSTA,[-10:.25:10],'linestyle','none');shading flat;
    %     hold on
    %     %contourl(lon,lat,tmpL,[0.5 1.5],'r','-',1,0);caxis([0 5])
    %     %contourl(lon,lat,mask.*mhwmask,[f-.5 f+.5],'k','--',.75,0);caxis([-5 5])
    %     contourl(lon,lat,mask0,[.5 1.5],'b','-',.5,0);
    %     contourl(lon,lat,landmask,[.5 1.5],'k','-',.5,0);
    %     contourl(lon,lat,tmpL_sev2_all,[0.5 1.5],'k','-',1,0);
    %     colormap(gca,lbmap(21,'BlueRed'))
    %
    %     ind1=find(dvec_slp(:,1)==myyr & dvec_slp(:,2)==mymn & dvec_slp(:,3)==mydy);
    %     msla=nc_varget(fnslp,'msla',[ind1-1 0 0],[1 -1 -1]);
    %     %mslpa_time=datevec(nc_varget(fnslp,'time',[ind1-1],[1])+datenum(1900,1,1));
    %     contourl(lon_slp,lat_slp,msla,[0:500:10000],'k','-',.5,0);
    %     contourl(lon_slp,lat_slp,msla,[-10000:500:0],'k','--',.5,0);
    %     contourl(lon_slp,lat_slp,msla,[-999999 0 999999],'k','-',1,0);
    %     xl(1)=max([0 xl_(1)-50]);xl(2)=min([360 xl_(2)+50]);
    %     yl(1)=max([-80 yl_(1)-50]);yl(2)=min([80 yl_(2)+50]);
    %     xlim(xl);ylim(yl);
    %     pbaspect([1.7 1 1]);colorbar
    %     title('SSTA');set(gca,'FontSize',7)
    
    %select 60 days prior to date of maximum conguous area of sev>2
    ind2=find(dvec_slp(:,1)==myyr & dvec_slp(:,2)==mymn & dvec_slp(:,3)==mydy);
    ind1=ind2-60;
    msla=squeeze(mean(nc_varget(fnslp,'msla',[ind1-1 0 0],[ind2-ind1 -1 -1])));
    ws=squeeze(mean(nc_varget(fnws,'S10_anomaly',[ind1-1 0 0],[ind2-ind1 -1 -1])));
    
    %select 60 days post to date of maximum conguous area of sev>2
    ind3=ind2+60;
    msla_post=squeeze(mean(nc_varget(fnslp,'msla',[ind2-1 0 0],[ind3-ind2 -1 -1])));
    ws_post=squeeze(mean(nc_varget(fnws,'S10_anomaly',[ind2-1 0 0],[ind3-ind2 -1 -1])));
  pause  
%     figure(3);clf
%     contourf(lon,lat,SEV,[0:6],'linestyle','none');shading flat;
%     caxis([0 5])
%     hold on
%     %contourl(lon,lat,tmpL,[0.5 1.5],'r','-',1,0);caxis([0 5])
%     %contourl(lon,lat,mask.*mhwmask,[f-.5 f+.5],'k','-',1,0);caxis([0 5])
%     contourl(lon,lat,mask0,[.5 1.5],'b','-',.5,0);
%     contourl(lon,lat,landmask,[.5 1.5],'k','-',.5,0);
%     contourl(lon,lat,tmpL_sev2,[0.5 1.5],'k','-',.5,0);colormap(gca,cm);
%     ind=find(nansum(tmpL,1));    xl_=lon(range(ind));
%     ind=find(nansum(tmpL,2));    yl_=lat(range(ind));
%     xl(1)=max([0 xl_(1)-30]);xl(2)=min([360 xl_(2)+30]);
%     yl(1)=max([-80 yl_(1)-30]);yl(2)=min([80 yl_(2)+30]);
%     xlim(xl);ylim(yl);pbaspect([1.7 1 1]);colorbar
%     title(['Region ',num2str(f),' Severity (',num2str(mydy),'/',num2str(mymn),'/',num2str(myyr),')'])
%     set(gca,'FontSize',7)
%     
%     
%     ind2=find(dvec_slp(:,1)==myyr & dvec_slp(:,2)==mymn & dvec_slp(:,3)==mydy);
%     ind1=ind2-60;
%     %mslpa_time=datevec(nc_varget(fnslp,'time',[ind1-1],[1])+datenum(1900,1,1));
%     contourl(lon_slp,lat_slp,msla,[0:200:10000],'k','-',.5,0);
%     contourl(lon_slp,lat_slp,msla,[-10000:200:0],'k','--',.5,0);
%     contourl(lon_slp,lat_slp,msla,[-999999 0 999999],'k','-',1,0);
%     xl(1)=max([0 xl_(1)-40]);xl(2)=min([360 xl_(2)+40]);
%     yl(1)=max([-80 yl_(1)-40]);yl(2)=min([80 yl_(2)+40]);
%     xlim(xl);ylim(yl);
%     pbaspect([1.7 1 1]);colorbar
%     title(['Severity: ',num2str(mydy),'-',num2str(mymn),'-',num2str(myyr),]);set(gca,'FontSize',7)
%     fno=['../images/region_',num2str(f),'_sev_slp']
%     print(fno,'-f3','-dtiff','-r600')
    
    ind=find(nansum(tmpL_sev2,1));    xl_=lon(range(ind));
    ind=find(nansum(tmpL_sev2,2));    yl_=lat(range(ind));
    xl(1)=max([0 xl_(1)-40]);xl(2)=min([360 xl_(2)+40]);
    yl(1)=max([-80 yl_(1)-30]);yl(2)=min([80 yl_(2)+30]);
    
    
    figure(2);clf
    contourf(lon,lat,SEV,[0:6],'linestyle','none');shading flat;plotmap(1.25)
    hold on
    contourl(lon,lat,tmpL,[0.5 1.5],'r','-',.5,0);caxis([0 5])
    %contourl(lon,lat,mask.*mhwmask,[f-.5 f+.5],'k','-',1,0);caxis([0 5])
    contourl(lon,lat,mask0,[.5 1.5],'b','-',.5,0);
    contourl(lon,lat,landmask,[.5 1.5],'k','-',.5,0);
    contourl(lon,lat,tmpL_sev2,[0.5 1.5],'k','-',.5,0);colormap(gca,cm);
    title(['Region ',num2str(f),' Severity (',num2str(mydy),'/',num2str(mymn),'/',num2str(myyr),')'])
    set(gca,'FontSize',8);colorbar
    contourl(lon_slp,lat_slp,msla,[0:200:10000],'k','-',.5,0);   
    contourl(lon_slp,lat_slp,msla,[-10000:200:0],'k','--',.5,0);
    contourl(lon_slp,lat_slp,msla,[-999999 0 999999],'k','-',1,0);
    xlim([0 360]);ylim([-80 80])
    fno=['../images/region_',num2str(f),'_sev_ssta_global']
    print(fno,'-f2','-djpeg100','-r400')
    
    
    figure(4);clf
    contourf(lon_slp,lat_slp,ws,[-4:.25:4],'linestyle','none');plotmap;colormap(lbmap(21,'BlueRed'));caxis([-3 3]);hold on
    contourl(lon_slp,lat_slp,msla,[0:200:10000],'k','-',.5,0);   
    contourl(lon_slp,lat_slp,msla,[-10000:200:0],'k','--',.5,0);
    contourl(lon_slp,lat_slp,msla,[-999999 0 999999],'k','-',1,0);
    plotmap(1)
    xlim(xl);ylim(yl);
    colorbar
    contourl(lon,lat,tmpL,[.5 1.5],'r','-',.5,0);
    contourl(lon,lat,tmpL_sev2,[0.5 1.5],'r','-',1,0)
%     [x,y]=mottle(lon,lat,tmpL,3,4,1,.3);
%     [x,y]=mottle(lon,lat,tmpL_sev2,2,4,4,.5);
    set(gca,'fontsize',12)
    title(['Region (60 days prior): ',num2str(f),', ',num2str(mydy),'-',num2str(mymn),'-',num2str(myyr),]);set(gca,'FontSize',11)
    fno=['../images/region_',num2str(f),'_sev_slp_ws']
    print(fno,'-f4','-dtiff','-r300')
    
    figure(5);clf
    contourf(lon_slp,lat_slp,ws_post,[-4:.25:4],'linestyle','none');plotmap;colormap(lbmap(21,'BlueRed'));caxis([-3 3]);hold on
    contourl(lon_slp,lat_slp,msla_post,[0:200:10000],'k','-',.5,0);   
    contourl(lon_slp,lat_slp,msla_post,[-10000:200:0],'k','--',.5,0);
    contourl(lon_slp,lat_slp,msla_post,[-999999 0 999999],'k','-',1,0);
    plotmap(1)
    xlim(xl);ylim(yl);
    colorbar
    contourl(lon,lat,tmpL,[.5 1.5],'r','-',.5,0);
    contourl(lon,lat,tmpL_sev2,[0.5 1.5],'r','-',1,0)
%     [x,y]=mottle(lon,lat,tmpL,3,4,1,.3);
%     [x,y]=mottle(lon,lat,tmpL_sev2,2,4,4,.5);
    set(gca,'fontsize',12)
    title(['Region (60 days post): ',num2str(f),', ',num2str(mydy),'-',num2str(mymn),'-',num2str(myyr),]);set(gca,'FontSize',11)
    fno=['../images/region_',num2str(f),'_sev_slp_ws_post']
    print(fno,'-f5','-dtiff','-r300')
end

