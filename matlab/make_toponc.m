clear
close all

file = '~/Dropbox/miyashita/dataset/GEBCO2021/gebco_2021_n60.0_s-60.0_w120.0_e300.0.nc';
[lon,lat,topo] = Topo.grdread2(file);

lonrange = [115,155];
latrange = [20,50];

[~,ind_lon1] = min(abs(lonrange(1)-lon));
[~,ind_lon2] = min(abs(lonrange(2)-lon));
[~,ind_lat1] = min(abs(latrange(1)-lat));
[~,ind_lat2] = min(abs(latrange(2)-lat));

lon_new = lon(ind_lon1:ind_lon2);
lat_new = lat(ind_lat1:ind_lat2);
topo_new = topo(ind_lat1:ind_lat2,ind_lon1:ind_lon2);


pcolor(lon_new,lat_new,topo_new); shading flat
axis equal tight
demcmap([-5000,5000]);
colorbar;

