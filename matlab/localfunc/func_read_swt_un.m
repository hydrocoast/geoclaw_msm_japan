% ====================================================================
% (function) func_read_swt_un
% Nobuki Fukui, Kyoto University
% Description: read .un file (SuWAT output)
% -------------------------------------------------------------------
% Syntax: 
% [data,time] = func_read_swt_un(filename,info_region,nt)
% filename: string having file name 
% info_region: structure containing domain infomation
%              nx, ny, xorg, yorg, dx (refer to .con file) 
% nt: integer showing the number of output timestep
% -------------------------------------------------------------------
% Update:
% 2021/4/27, First edition
% ===================================================================


function [data,time] = func_read_swt_un(filename,info_region,nt)

% open file
fid = fopen(filename,'r');

% preallcation
data = zeros(nt, info_region.ny, info_region.nx);

for it = 1:1:nt
    
    % counter
    disp(['>>> Now Loading ... ',num2str(it*100/nt),' %'])
    
    % time stamp
    header = fread(fid,[1 8],'uint32');
    year  = 2000 + header(3);
    month = header(4);
    day   = header(5);
    hour  = header(6);
    min   = header(7);
    time(it).date = datestr([year,month,day,hour,min,0],'yyyymmdd.HHMM');
    if it == 1; timeorg = header(2); end
    time(it).timelap = header(2) - timeorg;
    
    % read main data
%     tmp = fread(fid,[info_region.nx info_region.ny],'single');
    tmp = fread(fid,[info_region.nx+2 info_region.ny],'single'); % 7/12 for new Version
    tmp = tmp(2:end-1,:);
    
    %
    data(it,:,:) = flipud(double(tmp)');
    
    % pointer change
    
    %         fgetl(fid);
    if feof(fid);break;end
    
end
end

