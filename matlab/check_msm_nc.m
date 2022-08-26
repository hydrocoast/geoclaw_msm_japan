% ====================================================================
% (program) check_msm_nc
% Nobuki Fukui, Tottori University
% Description: read netCDF files of MSM forecast data
% --------------------------------------------------------------------
% Input: DATE.nc
% -------------------------------------------------------------------
% Update:
% 2022/8/19,v1,first edition
% ===================================================================

%%
close all
clear
fclose all;
addpath localfunc

%%

ncdir = '../ncfile_daily/2020';
ncfiles = { ...
           '0902.nc', ...
           '0903.nc', ...
           '0904.nc', ...
           '0905.nc', ...
           '0906.nc', ...
           '0907.nc', ...
           };
casename = 'haishen';
datestart = datetime(2020,9,2,0,0,0);
figdir = ['./fig/',casename];
if ~exist(figdir,'dir'); mkdir(figdir);end

xrange = [125,135];
yrange = [25,35];
cax = [920 1020];
skip = 20;


%%
load japancoast2_250000.mat

%%
nfile = length(ncfiles);
jt = 1;

for ifile = 1:nfile
% for ifile = 1:1
    filename = fullfile(ncdir,ncfiles{ifile});
    ncinfo(filename);
    
    t = ncread(filename,'time');
    nt = length(t);
    psea = permute(ncread(filename,'psea'),[2,1,3])./1e2;
    u = permute(ncread(filename,'u'),[2,1,3]);
    v = permute(ncread(filename,'v'),[2,1,3]);
    lon = ncread(filename,'lon');
    lat = ncread(filename,'lat');


    for it = 1:nt
    psea_snap = squeeze(psea(:,:,it));
    u_snap = squeeze(u(:,:,it));
    v_snap = squeeze(v(:,:,it));
    date_current = datestart+(jt-1)*hours(1);
    c_title = datestr(date_current,'yyyy/mm/dd HH:MM');
    
    fig = figure(1);clf;hold on;axis tight equal
    pcolor(lon,lat,psea_snap);shading flat
    plot(jcoast_lon,jcoast_lat,'-k','LineWidth',1)
    cb = colorbar;colormap(flipud(jet))
    caxis(cax)
    xlim(xrange);ylim(yrange)
    xlabel('Longitude [deg]')
    ylabel('Latitude [deg]')

    % ---------------------------------------------
    lon_plt = lon(1:skip:end,1:skip:end);
    lat_plt = lat(1:skip:end,1:skip:end);
    u_plt = u_snap(1:skip:end,1:skip:end);
    v_plt = v_snap(1:skip:end,1:skip:end);

    q = ncquiverref(lon_plt,lat_plt,u_plt,v_plt,...
        '[m/s]',20,'True','k');
    [q.hd.LineWidth] = deal( 1.2 );
    q.hd_ref.LineWidth = 1.2;
    title(c_title)

    % ---------------------------------------------------

    hold off

    figname = ['fig_storm_field_',casename,'_',num2str(jt)];
    print('-dpng',fullfile(figdir,figname),'-r400')

    jt = jt+1;
    end
    
   
    
end

    