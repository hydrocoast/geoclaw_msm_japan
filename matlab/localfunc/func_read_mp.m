% ======================================================================== 
% (function) func_read_mp
% Nobuki Fukui, Kyoto University
% Description: read Manning's coefficient file
% -----------------------------------------------------------------------
% Syntax: data = func_read_manning(filename, info_region)
% filename --> file name of Manning
% info_region --> region information which can be read by func_read_geo
% -----------------------------------------------------------------------
% Update:
% 2021/8/2, v1, First edition
% ========================================================================

function [data,info_region] = func_read_mp(filename)

    fid = fopen(filename,'r');
    header = cell2mat(textscan(fid,'%d%d',[1 1]));
    header2 = cell2mat(textscan(fid,'%f%f%f%f',[1 1]));

    % allocation
    nx = header(1);info_region.nx = nx;
    ny = header(2);info_region.ny = ny;
    info_region.xorg = header2(1);
    info_region.yorg = header2(2);
    info_region.dx = header2(3);
    info_region.dy = header2(4);
    
    % main data
    fmt = [repmat('%2d',[1 nx]),'\n'];
    rawdata = fscanf(fid,fmt);
    rawdata2 = reshape(rawdata,nx,ny);
    data = rawdata2.';
    data = flipud(data);
    
end