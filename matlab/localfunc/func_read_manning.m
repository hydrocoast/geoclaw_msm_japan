% ======================================================================== 
% (function) func_read_manning
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

function data = func_read_manning(filename, info_region)

    fid = fopen(filename,'r');

    % allocation
    nx = info_region.nx;
    ny = info_region.ny;
    
    % main data
    fmt = [repmat('%f',[1 nx]),'\n'];
    rawdata = fscanf(fid,fmt);
    rawdata2 = reshape(rawdata,nx,ny);
    data = rawdata2.';
    data = flipud(data);

end