% ====================================================================== 
% (function) func_read_swt
% Nobuki Fukui, Kyoto University
% Description: read swt file
% Syntax: data = func_read_swt(filename,info_region)
%         data --> Raw output from SuWAT
%         filename --> File name of output (e.g. max_wse_d04.swt)
%         info_region --> domain infomation in structure var. 
% ---------------------------------------------------------------------
% Update:
% 2021/4/19, v1, first version
% ======================================================================


function data = func_read_swt(filename,info_region)

    nx = info_region.nx;
    ny = info_region.ny; 
    fmt = '%16.6f';
    
    fid = fopen(filename,'r');
    rawdata = cell2mat(textscan(fid,fmt));
    data = reshape(rawdata,[nx,ny]);
    data = flipud(data');
    
end