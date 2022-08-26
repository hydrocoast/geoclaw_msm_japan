% ====================================================================
% (program) check_fgmax
% Nobuki Fukui, Tottori University
% Description: read FGMAX (max values in fixed grids) data
% --------------------------------------------------------------------
% Input: fgmax00001.txt etc...
% -------------------------------------------------------------------
% Update:
% 2022/8/23,v1,first edition
% ===================================================================

%%

close all
clear
fclose all;
addpath localfunc

%%
i_region = 4;
casename = 'testrun_haishen_Wa05';
caldir = ['../CalSet/',casename];
matname = ['fgmax_',num2str(i_region,'%03u')];

cax = [0 1.5];cax2 = [0 1.0];cax3 = [0 12];
font = 'Helvetica';fontsize = 16;

starttime = datetime(2020,9,4,0,0,0);
basetime = datetime(2020,9,6,12,0,0);
diff_basetime = hours( basetime - starttime );
cb_ticks = 0:4:12;
cb_ticklabels =  {datestr(basetime,'mm/dd HH:MM'), datestr(basetime+hours(4),'mm/dd HH:MM'),...
                   datestr(basetime+hours(8),'mm/dd HH:MM'), datestr(basetime+hours(12),'mm/dd HH:MM')};

%%
fdir = fullfile(caldir,'_mat');
load(fullfile(fdir,matname))
X = linspace(xlims(1),xlims(end),nx);
Y = linspace(ylims(1),ylims(end),ny);


%%
fig = figure(1);clf
resize_figure_window(3,1)
t = tiledlayout(1,3);
t.TileSpacing = 'compact';

nexttile;
eta(eta==0)=NaN;
pcolor(X,Y,eta);shading flat;axis tight equal;hold on
contour(X,Y,D,[0.01 0.01],'-k')
cb = colorbar;title(cb,'[m]')
colormap jet
caxis(cax)
title('Max surge height')
xlabel('Longitude [deg]');ylabel('Latitude [deg]')
set(gca,'FontSize',fontsize,'FontName',font)

nexttile;
vel(vel==0)=NaN;
pcolor(X,Y,vel);shading flat;axis tight equal;hold on
contour(X,Y,D,[0.01 0.01],'-k')
cb2 = colorbar;title(cb2,'[m/s]')
colormap jet
caxis(cax2)
title('Max current velocity')
xlabel('Longitude [deg]');ylabel('Latitude [deg]')
set(gca,'FontSize',fontsize,'FontName',font)

nexttile;
time_etamax(isnan(eta)) = NaN; 
time_etamax = hours( seconds( time_etamax ) );
time_etamax = time_etamax - diff_basetime;
pcolor(X,Y,time_etamax);shading flat;axis tight equal;hold on
contour(X,Y,D,[0.01 0.01],'-k')
cb3 = colorbar;cb3.TickLabels = cb_ticklabels;
colormap jet
caxis(cax3)
title('Peak time of surge')
xlabel('Longitude [deg]');ylabel('Latitude [deg]')
set(gca,'FontSize',fontsize,'FontName',font)




