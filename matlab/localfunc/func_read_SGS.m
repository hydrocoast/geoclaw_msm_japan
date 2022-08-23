% ====================================================================== 
% (function) func_read_SGS
% Nobuki Fukui, Kyoto University
% Description: read geo file
% Syntax: data,info_region = func_read_geo(filename)
%         data --> bathymetry data in 2d array
%         filename --> File name of output (e.g. domain_04_ver01.table.geo)
%         info_region --> domain infomation in structure var. 
% ---------------------------------------------------------------------
% Update:
% 2021/4/19, v1, first version
% 2021/7/6, v2, reading style changed (textscan -> fscanf) for low standard
% I/O
% ======================================================================


function [data] = func_read_SGS(filename,info_region)

    fid = fopen(filename,'r');
%     header = cell2mat(textscan(fid,'%d%d',[1 1]));
%     header2 = cell2mat(textscan(fid,'%f%f%f%f',[1 1]));

    % allocation
    nx = info_region.nx;
    ny =info_region.ny;
%     info_region.xorg = header2(1);
%     info_region.yorg = header2(2);
%     info_region.dx = header2(3);
%     info_region.dy = header2(4);
%     
    % main data
    fmt = [repmat('%f',[1 nx]),'\n'];
    rawdata = fscanf(fid,fmt);
    rawdata2 = reshape(rawdata,nx,ny);
    data = rawdata2.';
    data = flipud(data);
    
end