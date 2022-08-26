function [lat, lon] = latlongrs80(xdata,ydata)
% % 
% %
% % by Takuya MIYASHITA
% % modified by Nobuki Fukui

if size(xdata) ~= size(ydata)
    error('invald input arguments')
end
if ~ismatrix(xdata)
    error('input arguments must be 1 or 2 dimensional')
end
% %  mstruct
ellipsoid      = almanac('earth','grs80','meters');
mstruct        = defaultm('tranmerc'); % Gauss-Krueger projection
mstruct.geoid  = ellipsoid;
% mstruct.origin = [36.0 138.5];
REF_lat = [ 40  0 0];
REF_lon = [140 50 0];
mstruct.origin = [REF_lat(1)+REF_lat(2)/60+REF_lat(3)/3600 REF_lon(1)+REF_lon(2)/60+REF_lon(3)/3600];
mstruct        = defaultm(mstruct);

if ismatrix(xdata)
    [ny,nx] = size(xdata);
    xline = reshape(xdata,[1 nx*ny]);
    yline = reshape(ydata,[1 nx*ny]);
    [latline,lonline] = minvtran(mstruct,xline,yline);
    lat = reshape(latline,[ny nx]);
    lon = reshape(lonline,[ny nx]);
else
    [lat,lon] = minvtran(mstruct,xdata,ydata);
end




end