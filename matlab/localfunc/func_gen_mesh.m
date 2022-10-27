
function [X,Y,lat,lon] = func_gen_mesh(info_region,utmZone)
nx = double(info_region.nx); ny = double(info_region.ny);
dx = info_region.dx; dy = dx;
xorg = info_region.xorg; yorg = info_region.yorg;
xvec = xorg:dx:xorg+(nx-1)*dx;
yvec = yorg:dy:yorg+(ny-1)*dy;
xvec = double(xvec);yvec = double(yvec);

[X,Y] = meshgrid(xvec,yvec);

if strcmp(utmZone,'GRS80')
    [lat,lon] = latlongrs80(X,Y);
else
    [lat,lon] = latlonUTM(X,Y,utmZone);
end

end