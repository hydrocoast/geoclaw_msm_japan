function [data_pick] = collect_pnt(lon_pnt,lat_pnt,...
    info_region,dataorg)
nx = info_region.nx; ny = info_region.ny;
dx = info_region.dx; dy = dx;
xorg = info_region.xorg; yorg = info_region.yorg;
xvec = xorg:dx:xorg+(nx-1)*dx;
yvec = yorg:dy:yorg+(ny-1)*dy;

[X,Y] = meshgrid(xvec,yvec);
% [lat,lon] = latlon14Q(X,Y);
% [lat,lon] = latlongrs80(X,Y);
lon = double(X);
lat = double(Y);


data2d = dataorg;

dist = sqrt((lon-lon_pnt).^2+(lat-lat_pnt).^2);
I = find( dist == min(dist(:)) );

if length(I) > 1
    lon_tmp = lon(I);
    lat_tmp = lat(I);
    data2d_tmp = data2d(I);
    tmp_tmp = sqrt((lon_tmp-lon_pnt).^2+(lat_tmp-lat_pnt).^2);
    [~,II] = min(tmp_tmp(:));
    data_pick = data2d_tmp(II);
elseif length(I) ==1
    data_pick = data2d(I);
else
    error('>>>> No data is found (T_T)')
end
    data_pick(isnan(data_pick)) = 0;

end