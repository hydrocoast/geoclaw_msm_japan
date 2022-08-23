function [lat, lon] = latlonUTM(xdata,ydata,UTMType)
% % 
% %
% % by Takuya MIYASHITA

if size(xdata) ~= size(ydata)
    error('invalid input arguments')
end
if ~ismatrix(xdata)
    error('input arguments must be 1 or 2 dimensional')
end
% %  mstruct
ellipsoid      = almanac('earth','wgs84','meters');
mstruct        = defaultm('utm');
mstruct.geoid  = ellipsoid;
mstruct.zone   = UTMType; 
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