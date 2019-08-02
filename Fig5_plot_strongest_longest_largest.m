clear ;close all

load('/Users/z3045790/OneDrive/My Projects/OceanXtremes/extreme_extremes/Extreme_Extremes_2017/Processed_data/max_sev_dur_date.mat')


%% manually select events
figure(10);clf
pcolor(lon,lat,mask.*max_sev_dur_date);shading flat;%plotmap;hold on
colorbar;;colormap(colorscheme_1982_2017(1))
xl=[1981.5 2017.5];
caxis(xl)
pbaspect([1.8 1 1]);title(['Central Date of most severe MHW'])

xlim([0 360]);ylim([-80 80])

print -f10 -dtiff -r600 'images/extreme_extreme_date'