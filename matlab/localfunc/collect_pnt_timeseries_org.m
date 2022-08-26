
function [data_timeseries] = collect_pnt_timeseries(lon_pnt,lat_pnt,...
    info_region,timelap,dataorg)
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

data_timeseries = zeros(1,length(timelap));
% [nregion,~] = size(dataorg);

for it_time = 1:1:length(timelap)

    data2d = squeeze(dataorg(it_time,:,:));
    
        dist = sqrt((lon-lon_pnt).^2+(lat-lat_pnt).^2);
        I = find( dist == min(dist(:)) );

    if length(I) > 1
        lon_tmp = lon(I);
        lat_tmp = lat(I);
        data2d_tmp = data2d(I);
        tmp_tmp = sqrt((lon_tmp-lon_pnt).^2+(lat_tmp-lat_pnt).^2);
        [~,II] = min(tmp_tmp(:));
        data_timeseries(it_time) = data2d_tmp(II);        
    elseif length(I) ==1
        data_timeseries(it_time) = data2d(I);
    else
        error('>>>> No data is found (T_T)')
    end

end

    data_timeseries(isnan(data_timeseries)) = 0;

end