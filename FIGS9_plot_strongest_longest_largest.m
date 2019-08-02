clear; close all

cm=[.9 .9 .9
    .9 .7 .1
    .85 .3 .1
    .6 .1 .2
    .4 .1 .4];

n=36
% cmapp=[0,0,0 ;102,0,102; 94,79,162; 22,80,220;0,120,250;52,154,188;241,243,180; 40,200,40 ;181,225,163;251,147,81;150,1,31;250,101,101;220,220,220]
cmapp=[0,0,0 ;102,0,102; 94,79,162; 22,80,220;0,120,250;52,154,188;241,243,180; 40,200,40 ;181,225,163;251,147,81;150,1,31;250,101,101;250,250,250]
x = linspace(1,n,size(cmapp,1));
xi = 1:n;
yrmap = zeros(n,3);
for ii=1:3
    yrmap(:,ii) = pchip(x,cmapp(:,ii),xi);
end
yrmap = (yrmap/255);

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
for f=1:length(files)
    ind=find(MHWmask==f);
    MHWarea(f)=nansum(nansum(area(ind)));
end

fn='/Users/z3045790/OneDrive/DATASETS/mhw_12_2018/mhw_severity.pc90.0to30.-90to-70.1981.2018.nc'
alltime=nc_varget(fn,'time');alltime=alltime(1:13247);% to mimic older severity datset
dvec=datevec(alltime+datenum(1,1,1));
decyear=decimalyear(alltime+datenum(1,1,1));

load '/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/strongest_longest_largest.mat' %created in collate_strongest_longest_largest

%some problem with repeated date around october 2017 - just remove
ind=find(diff(alltime)==0);
alltime(ind)=[];
decyear(ind)=[];
dvec(ind,:)=[];
prcAREAcontigINregion(ind,:)=[];
prcAREAcontigINregion_sev2(ind,:)=[];
prcAREAsev1(ind,:)=[];
prcAREAsev2(ind,:)=[];
INTENSEcontig(ind,:)=[];
INTENSEcontig_sev2(ind,:)=[];
MAXSEVcontig(ind,:)=[];
MAXSEVcontig_sev2(ind,:)=[];
MAXSSTAcontig(ind,:)=[];
MAXSSTAcontig_sev2(ind,:)=[];
AREAcontig(ind,:)=[];
AREAcontig_sev2(ind,:)=[];
%% run this section multiple times to refine the time range (MHWtime) of the event
% used the proportion of area covered by sev>2 mhw and maximum intensity of
% mhw>2 to select time ranges
if exist('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/MHWtime_refined.mat','file')
    load('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/MHWtime_refined.mat') % created below (iterative process)
    MHWtime=MHWtime_refined;
end

for f=1:length(files)
    xl=[MHWtime(f,1)-4/12 MHWtime(f,2)+4/12];
    indt=find(decyear>MHWtime(f,1) & decyear<MHWtime(f,2));
    figure(5);clf
    pcolor(lon,lat,max_sev_dur_date);shading flat;
    colorbar;plotmap;
    hold on
    tmp=MHWmask;
    tmp(tmp ~= f)=NaN;tmp(isnan(tmp))=0;
    contour(lon,lat,tmp,[f-.5 f+.5],'r','linewidth',3)
    caxis([1981.5 2017.5]);colormap(yrmap);
    tmp(tmp==0)=NaN;tmp=tmp./tmp;
    
    figure(1);clf
    pcolor(lon,lat,tmp);shading flat
    mdate=max_sev_dur_date.*tmp;
    mdur=max_sev_dur_dur.*tmp;
    %focus on durations for dates within the manually selected MHW limits
    %(MHWtime)
    ind=find(mdate<MHWtime(f,1));mdur(ind)=NaN;
    ind=find(mdate>MHWtime(f,2));mdur(ind)=NaN;
    subplot(2,1,1);
    [AX, h1, h2]=plotyy(decyear,MAXSEVcontig(:,f),decyear,MAXSEVcontig_sev2(:,f))
    set(AX(1),'xlim',xl,'ylim',[1 6],'ytick',[0:6]);set(h1,'color',[.7 .7 .7],'linewidth',1.5)
    set(AX(2),'xlim',xl,'ylim',[1 6],'ytick',[0:6]);set(h2,'color','r')
    hold on
    plot(AX(1),[1 1]*MHWtime(f,1),[1 6],'k--')
    plot(AX(1),[1 1]*MHWtime(f,2),[1 6],'k--');xlim(xl)
    grid on
    %linkaxes([ax1,ax2,ax3,ax4],'x')
    title('max severity of contiguous area in MHW overlapping region')
    subplot(2,1,2);hist(mdur(:),100);xlabel('Duration [days]')
    title('Duration of longest MHW in region (within selected time bounds)')
    dat_DUR_IQR(f,:)=prctile(mdur(:),[25 50 75]);
    
    
    figure(6);clf
    ax1=subplot(4,1,1)
    [AX, h1, h2]=plotyy(decyear,prcAREAcontigINregion(:,f),decyear,prcAREAcontigINregion_sev2(:,f))
    set(AX(1),'xlim',xl,'YColor',[.5 .5 .5]);set(h1,'color',[.7 .7 .7],'linewidth',1.5)
    set(AX(2),'xlim',xl,'YColor','k');set(h2,'color','k')
    hold on
    plot(AX(1),[1 1]*MHWtime(f,1),[0 1],'k--')
    plot(AX(1),[1 1]*MHWtime(f,2),[0 1],'k--');
    title('Proportion of region in MHW [blue:mhw; red:sev>2]','FontWeight','Normal')
    dat_MAX_PROP_CONTIG_INREG(f)=max(prcAREAcontigINregion(indt,f));
    dat_MAX_PROP_CONTIG_INREG_SEV2(f)=max(prcAREAcontigINregion_sev2(indt,f));
    pbaspect(AX(1),[3 1 1]);pbaspect(AX(2),[3 1 1])
    ax2=subplot(4,1,2)
    [AX, h1, h2]=plotyy(decyear,AREAcontig(:,f)/1e12,decyear,AREAcontig_sev2(:,f)/1e12) %million km2
    set(AX(1),'xlim',xl,'ylim',[0 max(AREAcontig(indt,f))/1e12],'ytick',[0 max(AREAcontig(indt,f))/1e12],'YColor',[.5 .5 .5]);set(h1,'color',[.7 .7 .7],'linewidth',1.5)
    set(AX(2),'xlim',xl,'ylim',[0 max(AREAcontig_sev2(indt,f))/1e12],'ytick',[0 max(AREAcontig_sev2(indt,f))/1e12],'YColor','k');set(h2,'color','k')
    hold on
    plot(AX(1),[1 1]*MHWtime(f,1),[0 1]*max(AREAcontig(indt,f))/1e12,'k--')
    plot(AX(1),[1 1]*MHWtime(f,2),[0 1]*max(AREAcontig(indt,f))/1e12,'k--');
    title('Contiguous area in MHW overlapping region [Mkm^2]','FontWeight','Normal')
    dat_MAX_AREA_CONTIG_INTREG(f)=max(AREAcontig(indt,f))/1e12;
    dat_MAX_AREA_CONTIG_INTREG_SEV2(f)=max(AREAcontig_sev2(indt,f))/1e12;
    ind=find(max(AREAcontig(indt,f))==AREAcontig(indt,f));dat_MAX_CONTAREA_DATE(f,:)=dvec(indt(ind),:);
    ind=find(max(AREAcontig_sev2(indt,f))==AREAcontig_sev2(indt,f));dat_MAX_CONTAREA_DATE_SEV2(f,:)=dvec(indt(ind),:);
    pbaspect(AX(1),[3 1 1]);pbaspect(AX(2),[3 1 1])
    ax3=subplot(4,1,3)
    % intensity is integral(area.*ssta)
    [AX, h1, h2]=plotyy(decyear,INTENSEcontig(:,f)/1e12,decyear,INTENSEcontig_sev2(:,f)/1e12)
    set(AX(1),'xlim',xl,'ylim',[0 max(INTENSEcontig(indt,f))/1e12],'ytick',[0 max(INTENSEcontig(indt,f))/1e12],'YColor',[.5 .5 .5]);set(h1,'color',[.7 .7 .7],'linewidth',1.5)
    set(AX(2),'xlim',xl,'ylim',[0 max(INTENSEcontig_sev2(indt,f))/1e12],'ytick',[0 max(INTENSEcontig_sev2(indt,f))/1e12],'YColor','k');set(h2,'color','k')
    hold on
    plot(AX(1),[1 1]*MHWtime(f,1),[0 1]*max(INTENSEcontig(indt,f))/1e12,'k--')
    plot(AX(1),[1 1]*MHWtime(f,2),[0 1]*max(INTENSEcontig(indt,f))/1e12,'k--');xlim(xl)
    title('Intensity of contiguous area in MHW overlapping region [^oC Mkm^2]','FontWeight','Normal')
    dat_MAX_INT_CONTIG_INTREG(f)=max(INTENSEcontig(indt,f))/1e12;
    dat_MAX_INT_CONTIG_INTREG_SEV2(f)=max(INTENSEcontig_sev2(indt,f))/1e12;
    ind=find(max(INTENSEcontig(indt,f))==INTENSEcontig(indt,f));dat_MAX_INT_DATE(f,:)=dvec(indt(ind),:);
    ind=find(max(INTENSEcontig_sev2(indt,f))==INTENSEcontig_sev2(indt,f));dat_MAX_INT_DATE_SEV2(f,:)=dvec(indt(ind),:);
    pbaspect(AX(1),[3 1 1]);pbaspect(AX(2),[3 1 1])
    ax4=subplot(4,1,4)
    [N,X]=hist(mdate(:),decyear);
    bar(X,N,'FaceColor',[.7 .7 .7],'EdgeColor','none');xlim(xl)
    hold on;
    plot([MHWtime(f,1) MHWtime(f,1)],[0 max(N)],'k--');plot([MHWtime(f,2) MHWtime(f,2)],[0 max(N)],'k--')
    title('No of cells experiencing most severe MHW in region (where it co-occurs with longest MHW)','FontWeight','Normal')
    pbaspect([3 1 1])
    fno=['images/StrLonLarg_reg',num2str(f)];print(fno,'-depsc','-f6')
    fno=['images/StrLonLarg_maxsev_durationPDF_reg',num2str(f)];print(fno,'-depsc','-f1')
    %     in=input('update? [y/n]','s');
    %     in='y'
    in='n'
    if in=='y'
        figure(6);
        subplot(4,1,4)
        [xx,yy] = ginput(1);    MHWtime_refined(f,1)=xx;plot([MHWtime_refined(f,1) MHWtime_refined(f,1)],[0 max(N)],'--','color',[.8 0 0],'LineWidth',2)
        [xx,yy] = ginput(1);    MHWtime_refined(f,2)=xx;plot([MHWtime_refined(f,2) MHWtime_refined(f,2)],[0 max(N)],'--','color',[.8 0 0],'LineWidth',2)
    end
    
end
save '/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/MHWtime_refined.mat' MHWtime_refined
save '/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/table_data_strongest_longest_largest.mat' dat* MHWtime_refined

%%
fid = fopen('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/table_data_strongest_longest_largest.txt','w');
fprintf(fid,'Region\t maxIntensity(sev2)\t date\t maxIntensity\t date\t maxArea(sev2)\t date\t maxArea\t data\t propAREA(sev2)\t propArea\t durIQR\t durIQRrange\t durMedian\t dateRange\t dateRange\n')
for f=1:length(files)
    fprintf(fid,[num2str(f),'\t'])
    % maximum intesity (sum(ssta.*area)) for sev>2 and 1>sev<2 and
    % corresponding date (contiguos area overlapping selected region)
    fprintf(fid,[num2str(round(dat_MAX_INT_CONTIG_INTREG_SEV2(f),1)),'\t ('])
    fprintf(fid,[num2str(dat_MAX_INT_DATE_SEV2(f,3)),'/',num2str(dat_MAX_INT_DATE_SEV2(f,2)),'/',num2str(dat_MAX_INT_DATE_SEV2(f,1)),') \t'])
    fprintf(fid,[num2str(round(dat_MAX_INT_CONTIG_INTREG(f),1)),'\t ('])
    fprintf(fid,[num2str(dat_MAX_INT_DATE(f,3)),'/',num2str(dat_MAX_INT_DATE(f,2)),'/',num2str(dat_MAX_INT_DATE(f,1)),') \t'])
    % maximum area for sev>2 and 1>sev<2 and
    % corresponding date (contiguous area overlapping selected region) NB max
    % intensity and area are very closely related
    fprintf(fid,[num2str(round(dat_MAX_AREA_CONTIG_INTREG_SEV2(f),1)),'\t ('])
    fprintf(fid,[num2str(dat_MAX_CONTAREA_DATE_SEV2(f,3)),'/',num2str(dat_MAX_CONTAREA_DATE_SEV2(f,2)),'/',num2str(dat_MAX_CONTAREA_DATE_SEV2(f,1)),') \t'])
    fprintf(fid,[num2str(round(dat_MAX_AREA_CONTIG_INTREG(f),1)),'\t ('])
    fprintf(fid,[num2str(dat_MAX_CONTAREA_DATE(f,3)),'/',num2str(dat_MAX_CONTAREA_DATE(f,2)),'/',num2str(dat_MAX_CONTAREA_DATE(f,1)),') \t'])
    % proportion of region covered by contiguous MHW for sev>2 and 1>sev<2
    fprintf(fid,[num2str(round(dat_MAX_PROP_CONTIG_INREG_SEV2(f)*100)),'\t'])
    fprintf(fid,[num2str(round(dat_MAX_PROP_CONTIG_INREG(f)*100)),'\t'])
    % IQR of MHW duration (for locations where duration and intesity maximums
    % overlap)
    fprintf(fid,[num2str(dat_DUR_IQR(f,1)),' to ',num2str(dat_DUR_IQR(f,3)),'\t'])
    fprintf(fid,[num2str(dat_DUR_IQR(f,3)- dat_DUR_IQR(f,1)),'\t'])
    fprintf(fid,[num2str(dat_DUR_IQR(f,2)),'\t'])
    % duration of core MHW (where sev>2 mhw proportional area, contiguous overlapping area (and intensity) and time of most severe recorded MHW overlap)
    t1=MHWtime_refined(f,1);t2=MHWtime_refined(f,2);
    rg=round((t2-t1)*365);
    y1=floor(t1);y2=floor(t2);
    t1=round((t1-y1)*365);t2=round((t2-y2)*365);
    t1=datevec(t1);t2=datevec(t2);
    m1=t1(2);d1=t1(3);m2=t2(2);d2=t2(3);
    
    fprintf(fid,[num2str(d1),'/',num2str(m1),'/',num2str(y1),' to ',num2str(d2),'/',num2str(m2),'/',num2str(y2),'\t'])
    fprintf(fid,[num2str(rg),'\n'])
end
fclose(fid)

close all
figure(51);clf
pcolor(lon,lat,max_sev_dur_date);shading flat
% contourf(lon,lat,max_sev_dur_date,'linestyle','none')
colorbar;plotmap;pbaspect([1.8 1 1]);caxis([1981.5 2017.5]);colormap(yrmap);
xlim([0 360]);ylim([-80 80])
lat_lon_labels(13,[],[])

figure(6);clf
colorbar;plotmap;pbaspect([1.8 1 1]);caxis([1981.5 2017.5]);colormap(yrmap);
xlim([0 360]);ylim([-80 80])
hold on
for f=1:length(files)
    xl=[MHWtime(f,1)-4/12 MHWtime(f,2)+4/12];
    indt=find(decyear>MHWtime(f,1) & decyear<MHWtime(f,2));
    
    tmp=MHWmask;
    tmp(tmp ~= f)=NaN;tmp(isnan(tmp))=0;
    [B,L] = bwboundaries(tmp,'noholes');
    B=B{1};
    mylat=mean(lat(B(:,1)));
    mylon=mean(lon(B(:,2)));
    text(mylon,mylat,num2str(f))
    contourl(lon,lat,tmp,[f-.5 f+.5],'r','-',1,0)
f
end
lat_lon_labels(13,[],[])

figure(61);clf
colorbar;plotmap;pbaspect([1.8 1 1]);caxis([1981.5 2017.5]);colormap(yrmap);
xlim([0 360]);ylim([-80 80])
hold on
lat_lon_labels(13,[],[])
for N=1:62
load(['/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/long_strong_',num2str(N),'.mat'])
X=coord(:,1);X(end+1)=X(1);
Y=coord(:,2);Y(end+1)=Y(1);
plot(X,Y,'c')
hold on
end


print -f51 -dpng -r500 'images/strongest_longest_regions'
print -f6 -depsc 'images/strongest_longest_regions2'
print -f61 -depsc 'images/strongest_longest_regions3'