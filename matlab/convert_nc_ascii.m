clear
close all

%% basic format
fc = '1d.con';
fp = 'slp_d01.swt';
fu = 'u10_d01.swt';
fv = 'v10_d01.swt';
strtime_base='           0000DDHHMM\n';
p_amb = 1013.0;


%% read
% Jebi
% ncdir = '../ncfile_daily/2018';
% ncfiles = { ...
%            '0830.nc', ...
%            '0831.nc', ...
%            '0901.nc', ...
%            '0902.nc', ...
%            '0903.nc', ...
%            '0904.nc', ...
%            '0905.nc', ...
%            };
%% read
% Hagibis
ncdir = '../ncfile_daily/2019';
ncfiles = { ...
           '1008.nc', ...
           '1009.nc', ...
           '1010.nc', ...
           '1011.nc', ...
           '1012.nc', ...
           '1013.nc', ...
           '1014.nc', ...
           };

nfile = length(ncfiles);

for ifile = 1:nfile
% for ifile = 1:1
    filename = fullfile(ncdir,ncfiles{ifile});
    ncinfo(filename);
    
    t = ncread(filename,'time');
    nt = length(t);
    psea = permute(ncread(filename,'psea'),[2,1,3])./1e2;
    u = permute(ncread(filename,'u'),[2,1,3]);
    v = permute(ncread(filename,'v'),[2,1,3]);
    
    
    %% print
    if ifile==1
        lon = ncread(filename,'lon');
        lat = ncread(filename,'lat');
        nlon = length(lon);
        dlon = mean(abs(diff(lon)));
        nlat = length(lat);
        dlat = mean(abs(diff(lat)));
        
        % -- header
        fid_c = fopen(fc,'w');
        fprintf(fid_c,'%d %d\n',[nlon,nlat]);
        fprintf(fid_c,'%0.3f %0.3f %12.5e\n',[min(lon), min(lat), dlat]);
        fprintf(fid_c,'%0.3f %0.3f %12.5e\n',[max(lon), max(lat), dlon]);
        fclose(fid_c);
        
        % -- puv
        fmt_p = [repmat('%7.1f ',[1,nlon-1]),'%7.1f\n'];
        fmt_uv = [repmat('%4.1f ',[1,nlon-1]),'%4.1f\n'];
        fid_p = fopen(fp,'w');
        fid_u = fopen(fu,'w');
        fid_v = fopen(fv,'w');
        
%         % -- initial time
%         strtime='           0000010000\n';
%         fprintf(fid_p,strtime);
%         fprintf(fid_p,fmt_p,p_amb*ones(nlat,nlon)');
%         fprintf(fid_u,strtime);
%         fprintf(fid_u,fmt_uv,zeros(nlat,nlon)');
%         fprintf(fid_v,strtime);
%         fprintf(fid_v,fmt_uv,zeros(nlat,nlon)');
    end
    
        
    for k = 1:nt
        %% time header
        strtime = strrep(strtime_base,'DD',sprintf('%02d',ifile));
        strtime = strrep(strtime,'HH',sprintf('%02d',t(k)));
        strtime = strrep(strtime,'MM',sprintf('%02d',0));
        
        %% print
        fprintf(fid_p,strtime);
        fprintf(fid_p,fmt_p, flipud(squeeze(psea(:,:,k)))');
        fprintf(fid_u,strtime);
        fprintf(fid_u,fmt_uv,flipud(squeeze(u(:,:,k)))');
        fprintf(fid_v,strtime);
        fprintf(fid_v,fmt_uv,flipud(squeeze(v(:,:,k)))');
    end
    
end
fclose(fid_p);
fclose(fid_u);
fclose(fid_v);
    

% %% print
% % -- header
% fid_c = fopen(fc,'w');
% fprintf(fid_c,'%d %d\n',[nlon,nlat]);
% fprintf(fid_c,'%0.2f %0.2f %0.2f\n',[lonrange(1),latrange(1),dl]);
% fprintf(fid_c,'%0.2f %0.2f %0.2f\n',[lonrange(2),latrange(2),dl]);
% fclose(fid_c);
% 
% % -- puv
% fmt_p = [repmat('%7.1f ',[1,nlon-1]),'%7.1f\n'];
% fmt_uv = [repmat('%4.1f ',[1,nlon-1]),'%4.1f\n'];
% fid_p = fopen(fp,'w');
% fid_u = fopen(fu,'w');
% fid_v = fopen(fv,'w');
% 
% % -- initial time
% strtime='           0000010000\n';
% fprintf(fid_p,strtime);
% fprintf(fid_p,fmt_p,p_amb*ones(nlat,nlon)');
% fprintf(fid_u,strtime);
% fprintf(fid_u,fmt_uv,zeros(nlat,nlon)');
% fprintf(fid_v,strtime);
% fprintf(fid_v,fmt_uv,zeros(nlat,nlon)');
% 
% for k = 1:nt
%     %% time header
%     strtime = strrep(strtime_base,'HH',sprintf('%02d',th(k)));
%     strtime = strrep(strtime,'MM',sprintf('%02d',tm(k)));
% 
%     %% print
%     fprintf(fid_p,strtime);
%     fprintf(fid_p,fmt_p,squeeze(flipud(p_out(:,:,k)))');    
%     fprintf(fid_u,strtime);
%     fprintf(fid_u,fmt_uv,zeros(nlat,nlon)');
%     fprintf(fid_v,strtime);
%     fprintf(fid_v,fmt_uv,zeros(nlat,nlon)');
% end
% 
% fclose(fid_p);
% fclose(fid_u);
% fclose(fid_v);
